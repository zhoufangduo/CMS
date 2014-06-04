<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
		.time{
			width: 250px;
			height: 35px;
			border-radius:6px;
    		border: 2px solid #BDC3C7;
		}
	</style>
	<script type="text/javascript">
		var serNumber = {"1":"A","2":"B","3":"C","4":"D","5":"E","6":"F","7":"G"};
		var total = 1;
		$(function(){
			
			$("#type").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
			
			$("#type").change(function(){
				$("#group").empty();
				if($(this).val() != 3){
					$("#group").append('<div class="form-group" style="text-align: left;">'+		
					'<input type="button" value="增&nbsp;加" class="btn btn-info" onclick="toAdd()"/></div>');
				}else{
					$("#group").append('<div class="form-group" style="text-align: left;">直接作答即可</div>');
				}
				
				total = 1;
			});
			
			var validator = $("#addQstionsForm").validate({
				success:success,
				ignore: "",
				errorPlacement: showErrorTab,
				rules:{
					"context":{
						required:true
					}
				},
				messages:{
					"context": "作答的问题不能为空!"
				},
				submitHandler: function(form) {
					if($("#type").val() != 3){
						var length = $("[name=answer]").length;
						if(length == 0){
							alert("选择的答案不能为空!");
							return ;
						}else{
							var value = "";
							var answers =  $("[name=answer]");
							for(var i = 0; i < length; i ++){
								if($(answers[i]).val() == ""){
									$(answers[i]).focus();
									return ;
								}else{
									value += $(answers[i]).val()+";";
								}
							}
							
							 $("[name=answer]").val(value);
						}
					}
					
					$(form).ajaxSubmit({
						dataType	: "json",
						type        : "POST",
						cache       : false,
						success		: function(data){
							
							if(data.result){
								window.parent.parent.parent.mainFrame.close();
								alert("添加试题成功!");
							}else{
								alert("添加试题失败，请联系管理员");
							}
						}
					});
				}
			});
			
		});
		
		function addSelect(){
			var number =  serNumber[total];
			if(total > 7){
				alert("最多只能添加到7个选项");
				return ;
			}
			total ++;
			return '<div class="form-group" style="text-align: left;">'+number+'.&nbsp;<input type="text" name="answer" class="time"></div>';
		}
		

		function toAdd(){
			$("#group").append(addSelect());
		}
		
	</script>
</head>
<body>
	<form id="addQstionsForm" action="<%=request.getContextPath()%>/questions/add" method="post">
		<input type="hidden" name="paperId" value="${param.paperId}"/>
		<div class="tile" style="width: 100%; height: 100%; border-radius: 1px;">
			<table style="width: 100%; height: 100%;" border="0">
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">问题内容</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<textarea rows="2" name="context"  cols="10" class="form-control" placeholder="请输入作答的问题"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">作答类型</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<select id="type" name="type" class="select-block">
								<option value="1">单选</option>
								<option value="2">多选</option>
								<option value="3">回答</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">回答的内容</div>
					</td>
					<td width="35%" id="group">
						<div class="form-group" style="text-align: left;">
							<input type="button" value="增&nbsp;加" class="btn btn-info" onclick="toAdd()"/>
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