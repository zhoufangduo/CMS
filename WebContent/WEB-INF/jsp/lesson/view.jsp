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
		});
	</script>
</head>
<body>
	<form id="addLessonForm" action="<%=request.getContextPath()%>/lesson/update" method="post">
		<input type="hidden" name="id" value="${lesson.id}">
		<div class="tile" style="border-radius: 1px;">
			<table style="width: 100%; height: 100%;" border="0">
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">名称</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="name" value="${lesson.name}"/>
						</div>
					</td>
					<td width="5"></td>
					<td width="15%" class="input_label">
						<div class="form-group">状态</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<select id="state" name="state" class="select-block">
								<option value="1" <c:if test="${lesson.state == '1'}">selected="selected"</c:if>>初始</option>
								<option value="2" <c:if test="${lesson.state == '2'}">selected="selected"</c:if>>使用中</option>
								<option value="3" <c:if test="${lesson.state == '3'}">selected="selected"</c:if>>冻结</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">课程介绍</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<textarea rows="2"  name="introduce" class="form-control" >${lesson.introduce}</textarea>
						</div>
					</td>
					<td width="5"></td>
					<td width="10%" class="input_label">
						<div class="form-group">课程内容</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<textarea rows="2"  class="form-control"  name="context">${lesson.context}</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<td width="15%" class="input_label">
						<div class="form-group">实现项目描述</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<textarea rows="2"  class="form-control"  name="itemDesc" >${lesson.itemDesc}</textarea>
						</div>
					</td>
					<td width="5"></td>
					<td width="15%" class="input_label">
						<div class="form-group">招生目标</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<textarea rows="2"  class="form-control"  name="target" >${lesson.target}</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">开发周期</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="time"  value="${lesson.time}" />
						</div>
					</td>
					<td width="5"></td>
					<td width="15%" class="input_label">
						<div class="form-group">课程目标</div>
					</td>
					<td width="35%">
						<div class="form-group">
							<input type="text" class="form-control" name="objective" value="${lesson.objective}" />
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" class="input_label">
						<div class="form-group">&nbsp;</div>
					</td>
					<td width="35%">
						<div class="form-group">
						</div>
					</td>
					<td width="5"></td>
					<td width="15%" class="input_label">
						<div class="form-group"></div>
					</td>
					<td width="35%">
						<div class="form-group">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<input id="next" type="submit" style="padding:10px 50px;" 
						class="btn btn-primary" value="保&nbsp;&nbsp;存">
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>