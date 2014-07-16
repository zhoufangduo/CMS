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
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.tagsinput.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.stacktable.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/simplemodal/js/jquery.simplemodal.js"></script>
	<script src="<%=request.getContextPath()%>/resource/script/calendar.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/My97DatePicker/WdatePicker.js"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<style type="text/css">
		ul{
			list-style: none;
			padding: 0px;
			margin: 0px;
		}
		li{
			margin: 0px;
		}
		
		#curTime{
			font-size: 16px;
			font-weight: bold;
			font-family: '微软雅黑';
		}
		
		#curDate{
			font-size: 16px;
			font-weight: bold;
			font-family: '微软雅黑';
			margin-right: 15px;
			border: none;
			height:20px;
			width: 100px;
		}
	</style>
</head>
<body>
	<div class="btn-toolbar" style="margin-left: 3px;margin-right: 3px;">
        <span class="btn-group">
            <a class="btn btn-sm btn-default" href="javascript:toLastMonth()">
             	&nbsp;<span class="fui-arrow-left"></span>&nbsp;
            </a>
            <a class="btn btn-sm btn-default" href="javascript:show()">
             	&nbsp;<span class="fui-location"></span>&nbsp;
            </a>
            <a class="btn btn-sm btn-default" href="javascript:toNexMonth()">
             	&nbsp;<span class="fui-arrow-right"></span>&nbsp;
            </a>
        </span>
        <span style="margin-left: 25%;width: 200px;" title="点击选择切换的日期">
        
       		<span class="fui-calendar-solid" onclick="cleanInterval()"></span>&nbsp;
       		
       		<input type="text" id="curDate" readonly="readonly" onclick="cleanInterval()">&nbsp;&nbsp;
       		
       		<span class="fui-time"></span>&nbsp;
       		
       		<span id="curTime"></span>
        </span>
        <span class="btn-group" style="float: right; display: none;">
            <a class="btn btn-sm btn-default" href="javascript:toLast()">
             	&nbsp;月&nbsp;
            </a>
            <a class="btn btn-sm btn-default" href="#fakelink">
             	&nbsp;周&nbsp;
            </a>
            <a class="btn btn-sm btn-default" href="javascript:toLast()">
             	&nbsp;日&nbsp;
            </a>
        </span>
     </div> 
	<table class="table-bordered" width="100%" height="92%">
		<tr>
			<th class="wenked">星期天</th>
			<th>星期一</th>
			<th>星期二</th>
			<th>星期三</th>
			<th>星期四</th>
			<th>星期五</th>
			<th class="wenked">星期六</th>
		</tr>
		<c:forEach begin="0" end="5" var="index">
			<tr>
				<td class="wenked" id="${index * 7 + 1}"></td>
				<td id="${index * 7 + 2}"></td>
				<td id="${index * 7 + 3}"></td>
				<td id="${index * 7 + 4}"></td>
				<td id="${index * 7 + 5}"></td>
				<td id="${index * 7 + 6}"></td>
				<td class="wenked" id="${index * 7 + 7}"></td>
			</tr>
		</c:forEach>
	</table>
	
	<form action="" id="addEventForm">
		
	</form>
</body>
</html>