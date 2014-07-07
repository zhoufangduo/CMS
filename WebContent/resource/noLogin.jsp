<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<title>温馨提示</title>
	<style type="text/css">
		html,body{
			font-size: 16px;
			font-family:'微软雅黑';
			text-align: center;
			padding: 10%;
		}
	</style>
	<script type="text/javascript">
		function toLogin(){
			var url = "<%=request.getContextPath()%>/login/login";
			window.parent.location = url;
		}
		$(function(){
			var intervalId = null ;
			intervalId = window.setInterval(function(){
				window.clearTimeout(intervalId);
				toLogin();
			},3*1000);
		});
	</script>
</head>
<body>
	<div>
		你没有进行登录或者是会话超时，3秒钟之后自动跳至<a href="javascript:toLogin()">登录</a>
	</div>
</body>
</html>