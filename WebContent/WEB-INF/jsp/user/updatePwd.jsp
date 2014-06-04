<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<style type="text/css">
		.form-control{
			width: 350px;
		}
		.ttext{
			text-align: right;
		}
	</style>
	<script type="text/javascript">
	$(function(){
		
		var validator = $("#updatePwdForm").validate({
			success:success,
			ignore: "",
			errorPlacement: showErrorPlacement,
			rules:{
				"oldpassword":{
					required:true,
					rangelength:[6,20]
				},
				"password" :{
					required:true,
					rangelength:[6,20]
				},
				"newpassword":{
					required:true,
					rangelength:[6,20]
				}
			},
			messages:{
				"oldpassword": {required : "原始密码不能为空", rangelength: "长度为6-20个字符"},
				"password": {required : "新的登录密码!", rangelength: "长度为6-20个字符"},
				"newpassword": {required : "确认密码不能为空!", rangelength: "长度为6-20个字符"}
			},
			submitHandler: function(form) {
				var newpassword = $("[name=password]").val();
				var newpassword2 = $("[name=newpassword]").val();
				if(newpassword != newpassword2){
					alert("新的登录密码和确认密码不一致");
					return false;
				}else{
					$(form).ajaxSubmit({
						dataType	: "json",
						type        : "POST",
						cache       : false,
						success		: function(data){
							
							if(data.result == "pwderror"){
								alert("旧的密码输入不正确!");
								$("[name=oldpassword]").focus();
							}else if(data.result == "notGrade"){
								alert("新的登录密码和确认密码不一致!");
								$("[name=newpassword]").focus();
							}else if(data.result == "allGrade"){
								alert("新的登录密码和新的登录密码是一样,不能进行修改!");
								$("[name=password]").focus();
							}else if(data.result){
								alert("修改登录密码成功!");
								window.location = "<%=request.getContextPath()%>/user/toUpdatePwd";
							}
							else{
								alert("修改登录失败，请联系管理员!");
							}
						}
					});
				}
			}
		});
	});
	</script>
</head>
<body>
	<form id="updatePwdForm" action="<%=request.getContextPath()%>/user/updatePwd" class="form-horizontal" method="post">
		<input type="hidden" name="username" value="${sessionScope.user.username}">
		<table style="width: 98.8%; height: 100%;">
			<tr class="tableBar">
				<td  class="title" colspan="2">
					<span class="fui-play"></span>&nbsp;修改登录密码
				</td>
				<td class="toolBar">
					
				</td>
			</tr>
			<tr>
				<td width="5%"></td>
				<td width="10%" class="tlabel" style="padding-top: 40px;">
					<div class="form-group">
						原始密码
					</div>
				</td>
				<td width="30%" style="padding-top: 40px;">
					<div class="form-group">
						<input type="password" class="form-control" name="oldpassword" placeholder="请输入登录的原密码" value="" />
					</div>
				</td>
			</tr>
			<tr>
				<td width="5%"></td>
				<td width="10%" class="tlabel">
					<div class="form-group">
						新的密码
					</div>
				</td>
				<td width="20%" >
					<div class="form-group">
						<input type="password" class="form-control" name="password" placeholder="请输入新的登录密码" value=""/>
					</div>
				</td>
			</tr>
			<tr>
				<td width="5%"></td>
				<td width="10%" class="tlabel">
					<div class="form-group">
						新的确认密码
					</div>
				</td>
				<td width="20%" class="ttext">
					<div class="form-group">
						<input type="password" class="form-control" name="newpassword" placeholder="请输入确认密码" value=""/>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td style="padding-top: 60px;" >
					 <input type="submit" class="btn btn-lg btn-primary" style="width: 100px;" value="保 &nbsp;存" >
				</td>
			</tr>
	    </table>
	</form>
</body>
</html>