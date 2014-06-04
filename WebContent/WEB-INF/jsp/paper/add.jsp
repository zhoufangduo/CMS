<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/messages_zh.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/validate_form.js"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<style type="text/css">
		.time{
			width: 60px;
			height: 35px;
			border-radius:6px;
    		border: 2px solid #BDC3C7;
    		text-align: center;
		}
	</style>
		<script type="text/javascript">
		$(function(){
			var validator = $("#addPaperForm").validate({
				success:success,
				ignore: "",
				errorPlacement: showErrorTab,
				rules:{
					"name":{
						required:true
					}
				},
				messages:{
					"name": "考试卷名称不能为空!"
				},
				submitHandler: function(form) {
					$(form).ajaxSubmit({
						dataType	: "json",
						type        : "POST",
						cache       : false,
						success		: function(data){
							
							if(data.result){
								alert("修改考试卷成功!");
								window.parent.parent.parent.mainFrame.close();
							}else{
								alert("修改考试卷成失败，请联系管理员");
							}
						}
					});
				}
			});
		});
	</script>
</head>
<body>
	<form id="addPaperForm" action="<%=request.getContextPath()%>/paper/add" method="post">
		<div class="tile" style="width: 100%; height: 100%; border-radius: 1px;">
			<table style="width: 100%; height: 100%;" border="0">
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">名称</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="name" placeholder="请输入名称" />
						</div>
					</td>
					<td width="5%"></td>
					<td width="10%" class="input_label">
						<div class="form-group">考试时长</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" name="hour" class="time" placeholder="小时"/>
							&nbsp;:&nbsp;
							<input type="text" name="minute" class="time" placeholder="分钟"/>
							&nbsp;:&nbsp;
							<input type="text" name="second" class="time" placeholder="秒"/>
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">介绍</div>
					</td>
					<td width="35%" colspan="4">
						<div class="form-group">
							<textarea rows="3" cols="" class="form-control" name="introduce"></textarea>
						</div>
					</td>
				</tr>
			</table>
			<input type="submit"  value="保&nbsp;存"  class="btn btn-primary" style="padding:10px 50px;margin-top: 100px;margin-bottom: 50px;">
		</div>
	</form>
</body>
</html>