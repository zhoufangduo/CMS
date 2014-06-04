<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<style type="text/css">
		.arrows{font-size: 15px;font-weight: bolder;cursor: pointer;}
	</style>
	<script type="text/javascript">
		function toBack(){
			window.location = "<%=request.getContextPath()%>/lesson/list";
		}
	</script>
</head>
<body>
	<form action="">
		<table style="width: 100%; height: 100%;">
			<tr class="tableBar">
				<td class="title">
					<span class="fui-play"></span>&nbsp;课时管理
				</td>
				<td class="toolBar">
					<input type="submit" class="btn btn-sm btn-info" value="保&nbsp;存" >
					<input type="button" class="btn btn-sm btn-info" value="返&nbsp;回" onclick="toBack()" >
				</td>
			</tr>
		</table>
		<br/>
		<table class="table table-hover" border="0" >
	           <thead>
	             <tr>
	               <th class="tlabel" width="12%">名称</th>
	               <th class="tlabel" width="12%">相关视频</th>
	               <th class="tlabel" width="12%">相关的文档</th>
	               <th class="tlabel" width="12%">知识点</th>
	               <th class="tlabel" width="15%">练习</th>
	               <th class="tlabel" width="14%">测试</th>
	               <th class="tlabel" width="6%">状态</th>
	               <th class="tlabel" >操作</th>
	            </tr>
	           </thead>
	           <tbody>
	           	<c:forEach items="${requestScope.techs}" var="tech">
	           		<tr>
	           			<td class="tlabel" title="${tech.name}">${tech.name}</td>
	           			<td class="tlabel">
	           				<c:if test="${tech.videoFile != null && tech.videoFile != ''}">
	           					<a href="<%=request.getContextPath()%>/technology/download?newFileName=${tech.videoNewFile}&fileName=${tech.videoFile}">下载视频</a>&nbsp;
	           				</c:if>
	           				<c:if test="${tech.videoAddr != null && tech.videoAddr != ''}">
	           					<a href="${tech.videoAddr}" title="${tech.videoAddr}">跳转至下载</a>&nbsp;
	           				</c:if>
	           			</td>
	           			<td class="tlabel">
	           				<c:if test="${tech.docFile != null && tech.docFile != ''}">
	           					<a href="<%=request.getContextPath()%>/technology/download?newFileName=${tech.docNewFile}&fileName=${tech.docFile}">下载文档</a>&nbsp;
	           				</c:if>
	           				<c:if test="${tech.docAddr != null && tech.docAddr != ''}">
	           					<a href="${tech.docAddr}" title="${tech.docAddr}">跳转至下载</a>&nbsp;
	           				</c:if>
	           			</td>
	           			<td class="tlabel" title="${tech.knowledge}">${tech.knowledge}</td>
	           			<td class="tlabel" title="${tech.exercise}">${tech.exercise}</td>
	           			<td class="tlabel" title="${tech.test}">${tech.test}</td>
	           			<td class="tlabel">
	           				<c:if test="${tech.state == '1'}">
	           					初始
	           				</c:if>
	           				<c:if test="${tech.state == '2'}">
	           					使用中
	           				</c:if>
	           				<c:if test="${tech.state == '3'}">
	           					冻结
	           				</c:if>
	           			</td>
	           			<td class="tlabel">
	           				<c:if test="${tech.state eq '1' || tech.state eq '3'}">
	           					删除
	           				</c:if>
	           				<a class="arrows">
	           					<img alt="" src="<%=request.getContextPath()%>/resource/images/up.png" style="height: 15px;">
	           				</a>
	           				&nbsp;
	           				<a class="arrows">
	           					<img alt="" src="<%=request.getContextPath()%>/resource/images/down.png" style="height: 15px;">
	           				</a>
	           			</td>
	           		</tr>
	           	</c:forEach>
	           </tbody>
	     </table>
   	</form>
</body>
</html>