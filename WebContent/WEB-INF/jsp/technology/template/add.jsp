<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-radio.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-radio.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-switch.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-select.js" type="text/javascript"></script>
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
		///$("#type").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
		
		var validator = $("#addTemplForm").validate({
			success:success,
			ignore: "",
			errorPlacement: showErrorTab,
			rules:{
				"name":{
					required: true
				}
			},
			messages:{
				"name": "课时名称不能为空!"
			},
			submitHandler: function(form) {
				
				var types = $("[name=type]").filter("input:checked");
				var values = "";
				for(var i = 0; i < types.length; i ++){
					values += $(types[i]).val() + ";";
				}
				
				values = values.substr(0, values.length - 1);
				$("[name=type]").val(values);
				
				
				$(form).ajaxSubmit({
					dataType	: "json",
					type        : "POST",
					cache       : false,
					success		: function(data){								
						if(data.result){
							alert("添加模版成功!");
							window.parent.parent.parent.mainFrame.close();
						}else{
							alert("添加模版失败，请联系管理员");
						}
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<form id="addTemplForm" action="<%=request.getContextPath()%>/template/add" method="post">
		<input type="hidden" name="creator" value="${user.name}">
		<div class="tile" style="border-radius: 1px;">
			<table style="width: 100%; height: 100%;" border="0">
				<tr>
					<td width="12%" class="input_label">
						<div class="form-group">名称</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="name" placeholder="请输入模版名称" />
						</div>
					</td>
					<td width="3"></td>
					<td width="15%" class="input_label">
						<div class="form-group">描述</div>
					</td>
					<td width="35%" >
						<div class="form-group">
							<textarea rows="1" style="width: 90%"  name="context" class="form-control"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<td width="15%" class="input_label">
						<div class="form-group">类型</div>
					</td>
					<td width="35%" colspan="4" style="text-align: left;">
						<div class="form-group" style="border-radius:6px;background-color: white;">
							 <div style="padding: 5px 20px;width: 180px;float: left;" title="基本">
								<label class="radio"><input type="radio" name="type" value="1" data-toggle="radio">Office(Word)</label>
								<label class="radio"><input type="radio" name="type" value="2" data-toggle="radio">Office(Excel)</label>
								<label class="radio"><input type="radio" name="type" value="3" data-toggle="radio">Office(PPT)</label>
								<label class="radio"><input type="radio" name="type" value="4" data-toggle="radio">图片</label>
								<label class="radio"><input type="radio" name="type" value="5" data-toggle="radio">视频</label>
								<label class="radio"><input type="radio" name="type" value="6" data-toggle="radio">超链接</label>
								<label class="radio"><input type="radio" name="type" value="7" data-toggle="radio">Html文件</label>
							</div>
							<div style="padding: 5px 10px;margin-left: 200px;width: 180px;" title="专业">
								<label class="radio"><input type="radio" name="type" value="8" data-toggle="radio">实战项目</label>
								<label class="radio"><input type="radio" name="type" value="9" data-toggle="radio">组内讨论</label>
								<label class="radio"><input type="radio" name="type" value="10" data-toggle="radio">考试</label>
								<label class="radio"><input type="radio" name="type" value="11" data-toggle="radio">练习</label>
								<label class="radio"><input type="radio" name="type" value="12" data-toggle="radio">测验</label>
								<label class="radio"><input type="radio" name="type" value="13" data-toggle="radio">面试</label>
								<label class="radio"><input type="radio" name="type" value="14" data-toggle="radio">常用软件讲解</label>
							</div>
							<div style="padding: 5px 10px;position:absolute;width: 180px;margin-top: -251px;margin-left: 370px;" title="专业">
								<label class="radio"><input type="radio" name="type" value="15" data-toggle="radio">经典代码讲解</label>
								<label class="radio"><input type="radio" name="type" value="16" data-toggle="radio">Java文件</label>
								<label class="radio"><input type="radio" name="type" value="17" data-toggle="radio">压缩包</label>
								<label class="radio"><input type="radio" name="type" value="18" data-toggle="radio">文本</label>
								<label class="radio"><input type="radio" name="type" value="19" data-toggle="radio">文件</label>
								<label class="radio"><input type="radio" name="type" value="20" data-toggle="radio">PDF文件</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<br/>
						<input id="next" type="submit" style="padding:10px 50px;" 
						class="btn btn-primary" value="保&nbsp;&nbsp;存">
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>