<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet" type='text/css' >
	<link href="<%=request.getContextPath()%>/resource/flat-ui/css/flat-ui.css" rel="stylesheet" type='text/css' > 
	<link href="<%=request.getContextPath()%>/resource/flat-ui/css/demo.css" rel="stylesheet" type='text/css' > 
	<link href='<%=request.getContextPath()%>/resource/simplemodal/css/basic.css' rel='stylesheet' type='text/css'  />
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<style type="text/css">
		ul{
			list-style: none;
			margin-left:-35px;
			text-align: center;
			margin-right: 5px;
			margin-top: 40px;
		}
		
		li{
			border: solid 1.5px #BDC3C7;
			border-radius:3px;
			margin-bottom: 10px;
			overflow: hidden;
			background-color: #ECF0F1;
			color: #34495E;
			cursor: pointer;
		}
		
		li:HOVER{
			background-color: #3498DB;
			color: #FFFFFF;
		}
		.title{
			border-radius:3px;
			text-align:center;
			background-color:#3498DB;
			height: 30px;
			color: #FFFFFF;
		}
		
		#active{
			white-space:nowrap;	
			text-overflow:ellipsis;
			overflow: hidden;
			width: 200px;
		}
	</style>
	<script type="text/javascript">
	
		function toPlay(id, name){
			var  url = "<%=request.getContextPath()%>/context/play?id="+id;
			parent.mainFrame.location = url;
			$("#active").html("当前活动项:&nbsp;"+name);
		}
		
		function toBack(){
			parent.menuFrame.location = "../resource/blank_menu.jsp";
			parent.mainFrame.location = "<%=request.getContextPath()%>/context/list?techId=${param.techId}";
			parent.hideMenu();
		}
		
	</script>
</head>
<body>
	<div class="title">
		<div id="active">
			当前活动项:&nbsp;${contexts.get(0).name}
		</div>
		<input type="button" value="返回" onclick="toBack()" class="btn btn-block btn-sm btn-info" >
	</div>
	<ul>
		<c:forEach items="${requestScope.contexts}" var="context" varStatus="st">
			<li title="${context.name}" onclick="toPlay('${context.id}','${context.name}')">
				${context.name}
			</li>
			<c:if test="${context.id == param.id}">
				<script type="text/javascript">
					$("#active").html("当前活动项:&nbsp;${context.name}");
				</script>
			</c:if>
		</c:forEach>
	</ul>
</body>
</html>