<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet" type='text/css' >
	<link href="<%=request.getContextPath()%>/resource/flat-ui/css/flat-ui.css" rel="stylesheet" type='text/css' > 
	<link href="<%=request.getContextPath()%>/resource/flat-ui/css/demo.css" rel="stylesheet" type='text/css' > 
	<link href='<%=request.getContextPath()%>/resource/simplemodal/css/basic.css' rel='stylesheet' type='text/css'  />
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/html5shiv.js"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-select.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-checkbox.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.tagsinput.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.placeholder.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.stacktable.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/simplemodal/js/jquery.simplemodal.js"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/application.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/validate_form.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/messages_zh.js"></script>
	<script src="<%=request.getContextPath()%>/resource/validate/jquery.form.js" type="text/javascript"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<script type="text/javascript">
		$(function(){
			var validator = $("#addItemForm").validate({
				success:success,
				ignore: "",
				errorPlacement: showErrorTab,
				rules:{
					"name":{
						required:true
					},
					"downloadAddr":{
						required:false,
						url: true
					}
				},
				messages:{
					"name": "项目名称不能为空!"
				},
				submitHandler: function(form) {
					$(form).ajaxSubmit({
						dataType	: "json",
						type        : "POST",
						cache       : false,
						success		: function(data){
							if(data.result){
								alert("添加项目成功!");
								window.parent.parent.parent.mainFrame.close();
							}else{
								alert("添加项目失败，请联系管理员");
							}
						}
					});
				}
			});
		});
	</script>
</head>
<body>
	<form id="addItemForm" action="<%=request.getContextPath()%>/item/add" method="post" enctype="multipart/form-data">
		<div class="tile" style="width: 100%; height: 100%; border-radius: 1px;">
			<table style="width: 100%; height: 100%;" border="0">
				<tr>
					<td width="13%" class="input_label">
						<div class="form-group">项目名称</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="name" placeholder="请输入项目的名称" />
						</div>
					</td>
					<td width="4%"></td>
					<td width="13%" class="input_label">
						<div class="form-group">项目源码</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="file" name="uploadFile"  placeholder="请输入选择上传源码压缩包 " />
						</div>
					</td>
				</tr>
				<tr>
					<td width="13%" class="input_label">
						<div class="form-group">其他下载地址</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="downloadAddr" placeholder="请输入项目源码其他下载地址" />
						</div>
					</td>
					<td width="4%"></td>
					<td width="15%" class="input_label">
						<div class="form-group">开发周期</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="devTime" placeholder="请输入项目开发的周期" />
						</div>
					</td>
				</tr>
				<tr>
					<td width="13%" class="input_label">
						<div class="form-group">开发的团队</div>
					</td>
					<td width="35%" colspan="5">
						<div class="form-group">
							<textarea rows="1" name="group"  class="form-control" placeholder="请输入项目开发团队的名称或者是相关的开发人员"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">描述</div>
					</td>
					<td width="35%" colspan="4">
						<div class="form-group">
							<textarea rows="4" name="context"  cols="10" class="form-control" placeholder="请输入项目相关描述"></textarea>
						</div>
					</td>
				</tr>
			</table>
			<br/>&nbsp;
			<br/>&nbsp;
			<input type="submit" value="保&nbsp;存" class="btn btn-primary" style="padding:10px 50px;">
		</div>
	</form>
</body>
</html>