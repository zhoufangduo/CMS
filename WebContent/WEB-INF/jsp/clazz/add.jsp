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
<script type="text/javascript" src="<%=request.getContextPath()%>/resource/My97DatePicker/WdatePicker.js"></script>
<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
<script type="text/javascript">
	$(function(){
		$("#teacher").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
		$("#state").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
		
		var validator = $("#addClassForm").validate({
			success:success,
			ignore: "",
			errorPlacement: showErrorTab,
			rules:{
				"name":{
					required:true
				},
				"startDate" :{
					required:true,
					date:true
				},
				"endDate":{
					required:true,
					date:true
				}
			},
			messages:{
				"name": "班级名称不能为空!",
				"startDate": {required : "开学日期不能为空!", date: "日期格式不正确,例如: 2000-01-30"},
				"endDate": {required : "毕业日期不能为空!", date: "日期格式不正确,例如: 2000-01-30"}
			},
			submitHandler: function(form) {
				var lessonVal = setVal($("[name=lessons]").filter(':checkbox'));
				$("[name=lessons]").val(lessonVal);
				
				$(form).ajaxSubmit({
					dataType	: "json",
					type        : "POST",
					cache       : false,
					success		: function(data){
						
						if(data.result){
							alert("添加班级成功!");
							window.parent.parent.parent.mainFrame.close();
						}else{
							alert("添加班级失败，请联系管理员");
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
	<form id="addClassForm" action="<%=request.getContextPath()%>/clazz/add" method="post">
		<div class="tabs">
			<ul id="navTab" class="nav nav-tabs" style="font-weight: bold;">
				<li class="active"><a  href="#tab1" data-toggle="tab">班级信息</a></li>
				<li><a href="#tab2" data-toggle="tab">相关课程</a></li>
				<li>
					<input style="margin-left: 380px;height:30px;padding: 3px 20px;margin-top: 3px;position: absolute;" 
					type="submit" class="btn btn-primary" value="保&nbsp;&nbsp;存">
				</li>
			</ul>
			<div id="navTabContent" class="tab-content">
				<div class="tab-pane fade in active" id="tab1">
					<div class="tile" style="width: 100%; height: 100%; border-radius: 1px;">
						<table style="width: 100%; height: 100%;" border="0">
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">班级名称</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" name="name" placeholder="请输入登录用户名" />
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">状态</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<select id="state" name="state" class="select-block">
											<option value="1">初学</option>
											<option value="2">开学</option>
											<option value="3">毕业</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">开学日期</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" readonly="readonly"
											name="startDate"  placeholder="请选择开学日期"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
									</div>
								</td>
								<td width="5%"></td>
								<td width="10%" class="input_label">
									<div class="form-group">毕业日期</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<input type="text" class="form-control" readonly="readonly"
											name="endDate"  placeholder="请选择毕业日期"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
									</div>
								</td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">授课老师</div>
								</td>
								<td width="35%">
									<div class="form-group">
										<select id="teacher" name="teacher" class="select-block">
											<option value="">待定</option>
											<c:forEach items="${teachers}" var="teacher">
												<option value="${teacher.username}">
													${teacher.name}
												</option>
											</c:forEach>
										</select>
									</div>
								</td>
								<td width="5%"></td>
							</tr>
							<tr>
								<td width="10%" class="input_label">
									<div class="form-group">描述</div>
								</td>
								<td width="35%" colspan="4">
									<div class="form-group">
										<textarea rows="3" name="context"  cols="10" class="form-control" placeholder="请输入班级描述"></textarea>
									</div>
								</td>
							</tr>
						</table>
						<p/>&nbsp;
						<input type="submit" value="保&nbsp;存" class="btn btn-primary" style="padding:10px 50px;">
					</div>
				</div>
				
				<div class="tab-pane fade" id="tab2">
					<div class="tile" style="height:395px;border-radius:1px;">
						<div class="powerTitle">
							所有的课程
						</div>
						<div class="userPower" style="width: 835px;">
							<table border="0">
								<c:forEach items="${requestScope.lessons}" var="lesson" varStatus="status" >
									<td style="padding: 5px 10px;">
										<label class="checkbox" >
								             <input type="checkbox" name="lessons"  value="${lesson.id}" data-toggle="checkbox"/>${lesson.name}
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
								style="height: 25px;font-size: 15px;padding: 0px 15px;" onclick="selectAll('lessons')">
							<input type="button" value="全不选"  class="btn btn-primary"
								 style="height: 25px;font-size: 15px;padding: 0px 15px;" onclick="disSelectAll('lessons')">
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>