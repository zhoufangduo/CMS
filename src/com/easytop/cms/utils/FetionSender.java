package com.easytop.cms.utils;



import org.apache.log4j.Logger;
import net.solosky.maplefetion.ClientState;
import net.solosky.maplefetion.FetionClient;
import net.solosky.maplefetion.LoginState;
import net.solosky.maplefetion.NotifyEventAdapter;
import net.solosky.maplefetion.bean.Buddy;
import net.solosky.maplefetion.bean.Message;
import net.solosky.maplefetion.event.ActionEvent;
import net.solosky.maplefetion.event.ActionEventType;
import net.solosky.maplefetion.event.action.ActionEventListener;
import net.solosky.maplefetion.event.action.FailureEvent;
import net.solosky.maplefetion.event.action.success.SendChatMessageSuccessEvent;
import net.solosky.maplefetion.net.AutoTransferFactory;
import net.solosky.maplefetion.store.SimpleFetionStore;
import net.solosky.maplefetion.util.SingleExecutor;
import net.solosky.maplefetion.util.StringHelper;
import net.solosky.maplefetion.util.ThreadTimer;


public class FetionSender extends NotifyEventAdapter {
	private static Logger logger = Logger.getLogger(FetionSender.class);

	
	private FetionClient client;


	public FetionSender() {
		try {
			
			this.client = new FetionClient(PropertyUtil.get("fetion.account"),
					PropertyUtil.get("fetion.pwd"), this,
					new AutoTransferFactory(), new SimpleFetionStore(),
					new ThreadTimer(), new SingleExecutor());
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}

	}

	public void login(int presence) {
		try {
			
			this.client.enableGroup(false);
			this.client.login(presence);
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see net.solosky.maplefetion.LoginListener#loginStateChanged(LoginState)
	 */
	@Override
	public void loginStateChanged(LoginState state) {
		try {
			
			switch (state) {
			case SEETING_LOAD_DOING:
				logger.info("获取自适应系统配置...");
				break;// 加载自适应配置
			case SSI_SIGN_IN_DOING:
				logger.info("SSI登录...");
				break; // SSI登录
			case SIPC_REGISTER_DOING:
				logger.info("服务器验证...");
				break; // 注册SIPC服务器
			case GET_CONTACTS_INFO_DOING:
				logger.info("获取联系人...");
				break; // 获取联系人信息
			case GET_GROUPS_INFO_DOING:
				logger.info("获取群信息...");
				break;// 获取群消息
			case GROUPS_REGISTER_DOING:
				logger.info("群登录...");
				break;// 注册群
			case LOGIN_SUCCESS:
				logger.info("登录成功");
				break;
			case SSI_NEED_VERIFY:
			case SSI_VERIFY_FAIL:
				if (state == LoginState.SSI_NEED_VERIFY)
					logger.info("需要验证, 请输入目录下的[verify.png]里面的验证码:");
				else
					logger.info("验证码验证失败，刷新验证码中...");
				break;
			case SSI_CONNECT_FAIL:
				logger.info("SSI连接失败!");
				break;
			case SIPC_TIMEOUT:
				logger.info("登陆超时！");
				break;
			case SSI_AUTH_FAIL:
				logger.info("用户名或者密码错误!");
				break;
			case SSI_ACCOUNT_SUSPEND:
				logger.info("你已经停机，请缴费后再使用飞信。");
				break;
			default:
				logger.info("其他状态:" + state.name());
				break;
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}

	}

	public void tel(final String tel, String msg) {
		try {
			long mobile = Long.parseLong(tel);
			this.client.sendChatMessage(mobile,
					new Message(StringHelper.qouteHtmlSpecialChars(msg),
							Message.TYPE_PLAIN), new ActionEventListener() {
						public void fireEevent(ActionEvent event) {
							switch (event.getEventType()) {
							case SUCCESS:
								SendChatMessageSuccessEvent evt = (SendChatMessageSuccessEvent) event;
								if (evt.isSendToMobile()) {
									logger.info("发送成功，消息已通过短信发送到对方手机！");
								} else if (evt.isSendToClient()) {
									logger.info("发送成功，消息已通过服务直接发送到对方客户端！");
								}
								break;

							case FAILURE:
								FailureEvent evt2 = (FailureEvent) event;
								switch (evt2.getFailureType()) {
								case BUDDY_NOT_FOUND:
									logger.info("发送失败, 该用户可能不是你好友，请尝试添加该用户为好友后再发送消息。");
									break;
								case USER_NOT_FOUND:
									logger.info("发送失败, 该用户不是移动用户。");
									break;
								case SIPC_FAIL:
									logger.info("发送失败, 服务器返回了错误的信息。");
									break;
								case UNKNOWN_FAIL:
									logger.info("发送失败, 不知道错在哪里。");
								default:
									;
								}
								break;

							case SYSTEM_ERROR:
								logger.info("发送失败, 客户端内部错误。");
								break;
							case TIMEOUT:
								logger.info("发送失败, 超时");
								break;
							case TRANSFER_ERROR:
								logger.info("发送失败, 超时");

							}
						}
					});
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
		
	}

	/**
	 * 发送手机短信消息
	 */
	public void sms(String uri, final String message) {
		try {
			
			final Buddy buddy = this.client.getFetionStore().getBuddyByUri(uri);
			if (buddy != null) {
				this.client.sendSMSMessage(buddy, Message.wrap(message),
						new ActionEventListener() {
					public void fireEevent(ActionEvent event) {
						if (event.getEventType() == ActionEventType.SUCCESS) {
							logger.info("提示：发送给" + buddy.getDisplayName()
									+ " 的短信发送成功！");
						} else {
							logger.info("[系统消息]:你发给 "
									+ buddy.getDisplayName() + " 的短信  "
									+ message + " 发送失败！");
						}
					}
				});
			} else {
				logger.info("找不到这个好友，请检查你的输入！");
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
	}

	/**
	 * 给自己发送短信
	 */
	public void self(String message) {
		try {
			
			this.client.sendSMSMessage(this.client.getFetionUser(),
					Message.wrap(message), new ActionEventListener() {
				public void fireEevent(ActionEvent event) {
					if (event.getEventType() == ActionEventType.SUCCESS) {
						logger.info("给自己发送短信成功！");
					} else {
						logger.info("给自己发送短信失败！");
					}
				}
			});
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
	}

	/**
	 * 退出程序
	 * 
	 * @throws Exception
	 */
	public void exit() throws Exception {
		this.client.logout();
		logger.info("你已经成功的退出！");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see net.solosky.maplefetion.NotifyListener#statusChanged(ClientState)
	 */
	@Override
	public void clientStateChanged(ClientState state) {
		try {
			
			switch (state) {
			case OTHER_LOGIN:
				logger.info("你已经从其他客户端登录。");
				logger.info("30秒之后重新登录..");
				// //新建一个线程等待登录，不能在这个回调函数里做同步操作
				new Thread(new Runnable() {
					public void run() {
						try {
							Thread.sleep(30000);
						} catch (InterruptedException e) {
							System.out.println("重新登录等待过程被中断");
						}
						client.login();
					}
				}).start();
				break;
			case CONNECTION_ERROR:
				logger.info("客户端连接异常");
				break;
			case DISCONNECTED:
				logger.info("服务器关闭了连接");
				break;
			case LOGOUT:
				logger.info("已经退出。。");
				break;
			case ONLINE:
				logger.info("当前是在线状态。");
				break;
				
			default:
				break;
			}
		} catch (Exception e) {
			///logger.warn(e.getMessage(), e);
		}
	}

}
