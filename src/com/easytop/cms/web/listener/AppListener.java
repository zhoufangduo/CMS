package com.easytop.cms.web.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import net.solosky.maplefetion.bean.Presence;

import org.apache.commons.lang.StringUtils;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;

import com.easytop.cms.utils.FetionSender;
import com.easytop.cms.utils.PropertyUtil;

public final class AppListener implements ServletContextListener {
	
	private static String OFFICE_HOME = "officeHome";
	
	private static String OFFICE_PORT = "officePort";
	
	public void contextInitialized(ServletContextEvent event) {
		
		initOffice(event);
		
		initFetionSender(event);
		
	}

	private void initFetionSender(ServletContextEvent event) {
		boolean enable = PropertyUtil.getBoolean("fetion.enable", false);
		if (enable) {
			event.getServletContext().setAttribute("fetionSender", newFectionSender());
		}
		
	}

	private FetionSender newFectionSender() {
		
		FetionSender sender = new FetionSender();
		sender.login(Presence.ONLINE);
		
		return sender;
	}

	private void initOffice(ServletContextEvent event) {
		final String office_home = PropertyUtil.get(OFFICE_HOME);
		
		final int port[] = {PropertyUtil.getInt(OFFICE_PORT,8100)};
		
		if (StringUtils.isNotEmpty(office_home)) {
			
			DefaultOfficeManagerConfiguration configuration = 
					getOfficeManagerConfiguration(office_home,port);
			
			OfficeManager officeManager = configuration.buildOfficeManager();
			
			officeManager.start();
			
			event.getServletContext().setAttribute("officeManager", officeManager);
		}
	}
	
	/**
	 * 
	 * @param office_home
	 * @param port
	 * @return
	 * 	configuration.setOfficeHome(office_home);//设置OpenOffice.org安装目录
     *  configuration.setPortNumbers(port); //设置转换端口，默认为8100
     *  configuration.setTaskExecutionTimeout(1000 * 60 * 5L);//设置任务执行超时为5分钟
     *  configuration.setTaskQueueTimeout(1000 * 60 * 60 * 24L);//设置任务队列超时为24小时
	 */
	private DefaultOfficeManagerConfiguration getOfficeManagerConfiguration(
			String office_home, final int[] port) {
		
		DefaultOfficeManagerConfiguration configuration = new DefaultOfficeManagerConfiguration();
		
		configuration.setOfficeHome(office_home);
        configuration.setPortNumbers(port); 
        configuration.setTaskExecutionTimeout(1000 * 60 * 5L);
        configuration.setTaskQueueTimeout(1000 * 60 * 60 * 24L);
		return configuration;
	}
	
	
	
	public void contextDestroyed(ServletContextEvent event) {
		
		OfficeManager officeManager = 
				(OfficeManager)event.getServletContext().getAttribute("officeManager");
		
		if (officeManager != null) {
			officeManager.stop();
		}
		
		FetionSender sender = (FetionSender)event.getServletContext().getAttribute("fetionSender");
		
		if (sender != null) {
			try {
				sender.exit();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
