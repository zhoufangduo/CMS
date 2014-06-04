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
		
		$("#state").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
		var items = "${technology.items}".split(";");
		for(var i = 0; i < items.length; i ++){
			if($("#i"+items[i]) != undefined){
				$("#i"+items[i]).checkbox('check'); 
			}
		}
		
		var papers = "${technology.papers}".split(";");
		for(var i = 0; i < papers.length; i ++){
			if($("#p"+papers[i]) != undefined){
				$("#p"+papers[i]).checkbox('check');
			}
		}
		
		var validator = $("#addUserForm").validate({
			success:success,
			ignore: "",
			errorPlacement: showErrorTab,
			rules:{
				"name":{
					required: true
				},
				"exercise":{
					required: true
				},
				"videoAddr":{
					required: false,
					url: true
				},
				"docAddr": {
					required: false,
					url: true
				}
			},
			messages:{
				"name": "课时名称不能为空!",
				"exercise":"练习内容不能为空!"
			},
			submitHandler: function(form) {
				
				var itemVal = setVal($("[name=items]").filter(':checkbox'));
				var paperVal = setVal($("[name=papers]").filter(':checkbox'));
				
				$("[name=papers]").val(paperVal);
				$("[name=items]").val(itemVal);
				
				$(form).ajaxSubmit({
					dataType	: "json",
					type        : "POST",
					cache       : false,
					success		: function(data){								
						if(data.result){
							alert("修改课时成功!");
							window.parent.parent.parent.mainFrame.close();
						}else{
							alert("修改课时失败，请联系管理员");
						}
					}
				});
			}
		});
	});
	
	function selectAll(name){
		$("[name="+name+"]").filter(':checkbox').checkbox('check');
	}
	
	function disSelectAll(name){
		$("[name="+name+"]").filter(':checkbox').checkbox('uncheck');
	}
	
	function setVal(array){
		
		var val = "";
		
		for(var i = 0; i < array.length; i ++){
			val += $(array[i]).val() + ";";
		}
		
		return val;
	}
	
</script>
</head>
<body>
	<form id="addUserForm" action="<%=request.getContextPath()%>/technology/update" method="post">
		<input type="hidden" name="id" value="${technology.id}">
		<div class="tabs">
			<ul id="navTab" class="nav nav-tabs" style="font-weight: bold;">
				<li class="active"><a  href="#tab1" data-toggle="tab">课时信息</a></li>
				<li><a href="#tab2" data-toggle="tab">相关的实战项目</a></li>
				<li><a href="#tab3" data-toggle="tab">相关的考试内容</a></li>
				<li>
					<input style="margin-left: 300px;height:30px;padding: 3px 20px;margin-top: 3px;position: absolute;" 
					type="submit" class="btn btn-primary" value="保&nbsp;&nbsp;存">
				</li>
			</ul>
			<div id="navTabContent" class="tab-content">
				<div class="tab-pane fade in active" id="tab1">
					<div class="tile" style="border-radius: 1px;">
						<table style="width: 100%; height: 100%;" border="0">
							<tr>
								<td width="12%" class="input_label">
									<div class="form-group">名称</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="name" placeholder="请输入课时名称" value="${technology.name}"/>
									</div>
								</td>
								<td width="3"></td>
								<td width="15%" class="input_label">
									<div class="form-group">练习</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="exercise" placeholder="请输入课时的练习题目" value="${technology.exercise}" />
									 </div>
								</td>
							</tr>
							<tr title="视频">
								<td width="12%" class="input_label">
									<div class="form-group">视频文件</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="file" name="videoFile" placeholder="请选择上传的视频文件" value="${technology.videoFile}"/>
										<span>${technology.videoFile}</span>
									</div>
								</td>
								<td width="3"></td>
								<td width="15%" class="input_label">
									<div class="form-group">其他下载地址</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="videoAddr" placeholder="请输入其他下载视频的地址" value="${technology.videoAddr}"/>
									</div>
								</td>
							</tr>
							<tr title="文档">
								<td width="12%" class="input_label">
									<div class="form-group">相关的文档</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="file" name="docFile" placeholder="请输入身份证号码" value="${technology.docFile}" />
										<span>${technology.docFile}</span>
									</div>
								</td>
								<td width="3"></td>
								<td width="15%" class="input_label">
									<div class="form-group">其他下载地址</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="docAddr" placeholder="请输入其他下载文档的地址"  value="${technology.docAddr}"/>
									</div>
								</td>
							</tr>
							<tr>
								<td width="12%" class="input_label">
									<div class="form-group">知识点</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<textarea rows="2"  name="knowledge" class="form-control">${technology.knowledge}</textarea>
									</div>
								</td>
								<td width="3"></td>
								<td width="15%" class="input_label">
									<div class="form-group">经典代码片段</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<textarea rows="2"  cols="29" name="code" class="form-control">${technology.code}</textarea>
									</div>
								</td>
							</tr>
							<tr>
								<td width="12%" class="input_label">
									<div class="form-group">测验</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="test" placeholder="请输入测验的内容" value="${technology.test}" />
									</div>
								</td>
								<td width="3"></td>
								<td width="15%" class="input_label">
									<div class="form-group">状态</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<select id="state" name="state" class="select-block">
											<option value="1" <c:if test="technology.state == '1'">selected="selected"</c:if>>初始</option>
											<option value="2" <c:if test="technology.state == '2'">selected="selected"</c:if>>使用中</option>
											<option value="3" <c:if test="technology.state == '3'">selected="selected"</c:if>>冻结</option>
										</select>
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
				</div>
				<div  class="tab-pane fade" id="tab2">
					<div class="tile" style="width: 100%;height:395px;border-radius:1px;">
						<div class="powerTitle">
							所有的实战项目
						</div>
						<div class="userPower">
							<table border="0">
								<c:forEach items="${requestScope.items}" var="item" varStatus="status" >
									<td style="padding: 5px 10px;">
										<label class="checkbox" for="i${item.id}">
								             <input type="checkbox" id="i${item.id}" name="items" value="${item.id}" data-toggle="checkbox"/>
								             ${item.name}
								        </label>
									</td>
									<c:if test="${status.count % 5 ==0}">
										<tr/>
									</c:if>
								</c:forEach>
							</table>
						</div>
						<div class="toolbar2">
							<input type="button" value="全 &nbsp;选"  class="btn btn-primary" 
								style="height: 25px;font-size: 15px;padding: 0px 15px;" onclick="selectAll('items')">
							<input type="button" value="全不选"  class="btn btn-primary"
								 style="height: 25px;font-size: 15px;padding: 0px 15px;" onclick="disSelectAll('items')">
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="tab3">
					<div class="tile" style="width: 100%;height:395px;border-radius:1px;">
						<div class="powerTitle">
							所有的试卷
						</div>
						<div class="userPower">
							<table border="0">
								<c:forEach items="${requestScope.papers}" var="paper" varStatus="status" >
									<td style="padding: 5px 10px;">
										<label class="checkbox" for="p${paper.id}">
								             <input type="checkbox" id="p${paper.id}" name="papers" value="${paper.id}" data-toggle="checkbox"/>
								             ${paper.name}
								        </label>
									</td>
									<c:if test="${status.count % 5 ==0}">
										<tr/>
									</c:if>
								</c:forEach>
							</table>
						</div>
						<div class="toolbar2">
							<input type="button" value="全 &nbsp;选"  class="btn btn-primary" 
								style="height: 25px;font-size: 15px;padding: 0px 15px;" onclick="selectAll('papers')">
							<input type="button" value="全不选"  class="btn btn-primary"
								 style="height: 25px;font-size: 15px;padding: 0px 15px;" onclick="disSelectAll('papers')">
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>