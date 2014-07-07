<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="menus" uri="http://www.easytop/tag"%>
<!DOCTYPE html>
<html>
	<head>
	   <title>深圳市易通软件课程教育系统</title>
	   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	   <meta name="viewport" content="width=device-width, initial-scale=1.0">
	   <link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet">
	   <link href="<%=request.getContextPath()%>/resource/flat-ui/css/flat-ui.css" rel="stylesheet"> 
	   <script src="<%=request.getContextPath()%>/resource/flat-ui/js/html5shiv.js"></script>
	   <script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
	   <script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
	   <script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap.min.js" type="text/javascript"></script>
	   <script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.placeholder.js" type="text/javascript"></script>
	   <script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
	   <link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	   <style type="text/css">
			.menuFrame {
				padding:5px;
				height:92%;
				width:100%;
				margin-top:52px;
				padding-top:10px;
				overflow:hidden;
				overFlow-x:hidden;  
				overFlow-y:hidden;  
				background-color: #fff;
				border: 1px solid #ECF0F1;
				-webkit-border-radius: 6px;
		     	-moz-border-radius: 6px;
		        border-radius: 6px;
		  		-webkit-box-shadow: 0 1px 4px rgba(0,0,0,.065);
		     	-moz-box-shadow: 0 1px 4px rgba(0,0,0,.065);
		        box-shadow: 0 1px 4px rgba(0,0,0,.065);
			}
			
			.mainFrame{
				margin-top:52px;
				height:92%;
				padding:5px;
				padding-top:10px;
				width:100%;
				background-color: #fff;
				border: 1px solid #ECF0F1;
				-webkit-border-radius: 6px;
		     	-moz-border-radius: 6px;
		        border-radius: 6px;
		  		-webkit-box-shadow: 0 1px 4px rgba(0,0,0,.065);
		     	-moz-box-shadow: 0 1px 4px rgba(0,0,0,.065);
		        box-shadow: 0 1px 4px rgba(0,0,0,.065);
			}
			
			.bar {
				width: 1%;
				padding-top: 25%;
				float:left;
				margin-left:-15px;
			}
			
			.table {
				width: 100%;
				height: 99%;
				padding: 0px;
				margin: 0px;
			}
			
		</style>
		<script type="text/javascript">
			function hideMenu(){
				$("#menu").hide();
				$("#mainFrame").css("margin-left","5px");
				$('#bar').html('<span class="fui-arrow-right" style="cursor: pointer;margin-left:5px;" onclick="showMenu()"></span>');
			}
			
			function showMenu(){
				$("#menu").show();
				$("#mainFrame").css("margin-left","0px");
				$('#bar').html('<span class="fui-arrow-left" style="cursor: pointer;" onclick="hideMenu()"></span>');
			}
			
			$(function(){
				hideMenu();
			});
			
		</script>
	</head>
	<menus:menu/>
<body >
	<table class="table">
		<tr>
			<td width="17%" height="99%" id="menu">
				<iframe class="menuFrame" name="menuFrame" id="menuFrame" src="" width="100%" height="100%">
		
				</iframe>
			</td>
			<td width="83%" height="99%" id="main">
				<div id="bar" class="bar" align="center">
					<span class="fui-arrow-left" style="cursor: pointer;" onclick="hideMenu()"></span>
				</div>
				<iframe class="mainFrame" name="mainFrame" id="mainFrame" src="">
		
				</iframe>
			</td>
		</tr>
	</table>
</body>
</html>