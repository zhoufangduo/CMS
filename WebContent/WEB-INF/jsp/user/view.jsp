<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resource/flat-ui/css/flat-ui.css" rel="stylesheet"> 
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/html5shiv.js"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/validate/jquery.form.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-switch.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-select.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-checkbox.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-radio.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.tagsinput.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.placeholder.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.stacktable.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/application.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/validate_form.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/messages_zh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resource/My97DatePicker/WdatePicker.js"></script>
<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
<script type="text/javascript">
	$(function(){
		$("#sex").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
		$("#roleType").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
		$("#classNo").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
		
		var validator = $("#addUserForm").validate({
			success:success,
			ignore: "",
			errorPlacement: showErrorTab,
			rules:{
				"name":{
					required:true
				},
				"password":{
					required:false,
					rangelength:[6,20]
				},
				"idCard":{
					required:false,
					rangelength:[6,20]
				},
				"born" :{
					required:true,
					date:true
				},
				"email":{
					required:false,
					email:true
				},
				"mobile":{
					required:false,
					digits:true
				},
				"qq":{
					required:false,
					digits:true
				}
			},
			messages:{
				"name": "姓名不能为空!",
				"password": {required: "登录密码不能为空!", rangelength: "长度为6-20个字符"},
				"idCard": {required: "身份证不能为空!", rangelength: "长度为6-20个字符"},
				"born": {required : "出生日期不能为空!", date: "日期格式不正确,例如: 2000-01-30"},
				"email": {required: "Email不能为空!", email: "Email的格式不对，例如: json@gmail.com"},
				"mobile": {digits: "手机号码输入的格式不对!"},
				"qq": {digits: "QQ号码输入的格式不对!"}
			},
			submitHandler: function(form) {
				$(form).ajaxSubmit({
					dataType	: "json",
					type        : "POST",
					cache       : false,
					success		: function(data){								
						if(data.result){
							alert("修改用户信息成功!");
							window.parent.parent.parent.mainFrame.close();
						}else{
							alert("修改用户信息失败，请联系管理员");
						}
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<form id="addUserForm" action="<%=request.getContextPath()%>/user/update" method="post">
		<div>
			<ul id="navTab" class="nav nav-tabs" style="font-weight: bold;">
				<li class="active"><a  href="#tab1" data-toggle="tab">用户信息</a></li>
			</ul>
			<div id="navTabContent" class="tab-content">
				<div class="tab-pane fade in active" id="tab1">
					<div class="tile" style="width: 100%; height: 100%; border-radius: 1px;">
						<table style="width: 100%; height: 100%;" border="0">
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">用户名</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="username"
											 value="${user.username}" readonly="readonly" />
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">姓名</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="name" placeholder="请输入姓名"
											value = "${user.name}"  />
									</div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">登录密码</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="password" class="form-control" name="password" placeholder="请输入登录密码"
											value =""/>
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">身份证号</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="idCard" placeholder="请输入身份证号码" 
											value = "${user.idCard}" />
									</div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">出生日期</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" readonly="readonly"
											name="born" value = "${user.born}"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
											placeholder="请选择出生日期" />
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">性别</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<select id="sex" class="select-block" name="sex">
											<option value="MALE" <c:if test="${user.sex == 'MALE'}">selected="selected"</c:if>>男</option>
											<option value="FEMALE" <c:if test="${user.sex == 'FEMALE'}">selected="selected"</c:if>>女</option>
											<option value="SECRECY" <c:if test="${user.sex == 'SECRECY'}">selected="selected"</c:if>>保密</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">角色类型</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<select id="roleType" class="select-block" name="roleType">
											<option value="ADMIN" <c:if test="${user.roleType == 'ADMIN'}">selected="selected"</c:if>>管理员</option>
											<option value="TEACHER" <c:if test="${user.roleType == 'TEACHER'}">selected="selected"</c:if>>教师</option>
											<option value="STUDENT" <c:if test="${user.roleType == 'STUDENT'}">selected="selected"</c:if>>学生</option>
										</select>
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">所在班级</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<select id="classNo" class="select-block" name="classNo">
											<option value="TODO">待 定</option>
											<c:forEach items="${clazzs}" var="clazz">
												<option value="${clazz.id}" 
													<c:if test="${user.classNo == clazz.id}">selected="selected"</c:if>>
													${clazz.name}
												</option>
											</c:forEach>
										</select>
									 </div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">Eamil</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="email" placeholder="请输入Email地址"
											value = "${user.email}"  />
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">手机号码</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="mobile" placeholder="请输入手机号码" 
											value = "${user.mobile}" />
									</div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">电话号码</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="tel" placeholder="请输入联系电话号码"
											value = "${user.tel}" />
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">QQ</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="qq" placeholder="请输入QQ号码"
										value = "${user.qq}" />
									</div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">微信</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="weixin" placeholder="请输入目前使用微信" 
										value = "${user.weixin}"/>
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">微博</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="weibo" placeholder="请输入目前使用微博" 
										value = "${user.weibo}"/>
									</div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">家庭地址</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="addresss1" placeholder="请输入家庭地址"
										value = "${user.address1}" />
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">所在地址</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="addresss2" placeholder="请输入目前所在地址"
										  value = "${user.address2}" />
									</div>
								</td>
							</tr>
						</table>
						<c:if test="${param.isView == false}">
							<input id="next" type="submit" style="padding:10px 50px;" class="btn btn-primary" value="保&nbsp;&nbsp;存">
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>