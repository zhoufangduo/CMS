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
				"username":{
					required:true,
					rangelength:[5,30],
					remote:{
			            type:"POST",
			            url:"<%=request.getContextPath()%>/user/validate",     
			            data:{
			               username:function(){return $("[name=username]").val();}
			            } 
			         } 
				},	
				"name":{
					required:true
				},
				"password":{
					required:true,
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
				"username": {required: "用户名不能为空!", rangelength: "长度为5-30个字符",remote:"该用户名已存在"},
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
						if(data.result == "1"){
							alert("添加用户成功!");
							window.parent.parent.parent.mainFrame.close();
						}else if(data.result = "2"){
							alert("该用户已经存在，不能再进行添加了!");
						}else{
							alert("添加用户失败，请联系管理员");
						}
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<form id="addUserForm" action="<%=request.getContextPath()%>/user/add" method="post">
		<div class="tile" style="width: 100%; height: 100%; border-radius: 1px;">
			<table style="width: 100%; height: 100%;" border="0">
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">用户名</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="username" placeholder="请输入登录用户名" />
						</div>
					</td>
					<td width="5%"></td>
					<td width="10%" class="input_label">
						<div class="form-group">姓名</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="name" placeholder="请输入姓名" />
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">登录密码</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="password" class="form-control" name="password" placeholder="请输入登录密码" value="123456" />
						</div>
					</td>
					<td width="5%"></td>
					<td width="10%" class="input_label">
						<div class="form-group">身份证号</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="idCard" placeholder="请输入身份证号码" />
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
								name="born"
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
								<option value="MALE" selected="selected">男</option>
								<option value="FEMALE">女</option>
								<option value="SECRECY">保密</option>
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
								<option value="ADMIN">管理员</option>
								<option value="TEACHER">教师</option>
								<option value="STUDENT">学生</option>
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
									<option value="${clazz.id}">${clazz.name}</option>
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
							<input type="text" class="form-control" name="email" placeholder="请输入Email地址" />
						</div>
					</td>
					<td width="5%"></td>
					<td width="10%" class="input_label">
						<div class="form-group">手机号码</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="mobile" placeholder="请输入手机号码" />
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">电话号码</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="tel" placeholder="请输入联系电话号码" />
						</div>
					</td>
					<td width="5%"></td>
					<td width="10%" class="input_label">
						<div class="form-group">QQ</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="qq" placeholder="请输入QQ号码" />
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">微信</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="weixin" placeholder="请输入目前使用微信" />
						</div>
					</td>
					<td width="5%"></td>
					<td width="10%" class="input_label">
						<div class="form-group">微博</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="weibo" placeholder="请输入目前使用微博" />
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">家庭地址</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="address1" placeholder="请输入家庭地址" />
						</div>
					</td>
					<td width="5%"></td>
					<td width="10%" class="input_label">
						<div class="form-group">所在地址</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="address2" placeholder="请输入目前所在地址" />
						</div>
					</td>
				</tr>
			</table>
			<input id="next" type="submit" style="padding:10px 50px;" class="btn btn-primary" value="保&nbsp;&nbsp;存">
		</div>
	</form>
</body>
</html>