<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
		div{
			padding: 15px 50px;
		}
	</style>
</head>
<body>
	<div>
		系统无法打开该文件，请先进行
			<a href="<%=request.getContextPath()%>/context/downloadFile?fileName=${context.context}&id=${context.id}">下载</a>，
			在本地使用其他的软件打开
	</div>
</body>
</html>