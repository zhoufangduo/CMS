<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet">
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
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-radio.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.tagsinput.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.placeholder.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.stacktable.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/simplemodal/js/jquery.simplemodal.js"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/application.js" type="text/javascript"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<style type="text/css">
		.time{
			border-radius:6px;
    		border: 2px solid #BDC3C7;
		}
	</style>
	<style type="text/css">
		html,body{
			margin: auto;
		}
		
		.qtsText{
			border: none;
			border-bottom: solid black 1px;
			width: 180px;
			padding-left: 10px;
		} 
		
		.anText{
			border: none;
			border-bottom: solid black 1px;
			width: 70%;
			padding-left: 10px;
			font-size: 13px;
		} 
		
		.rowTex{
			text-align: center;
		}		
	</style>
	<script type="text/javascript">
		var option = {
				opacity:20,
				minHeight:452.5,
				minWidth:868,
				escClose: true, 
				autoResize: true,
				onClose:function(){
					window.location.reload();
					window.parent.menuFrame.document.location.reload();
				}
		};
		
		function toAdd(){
			var url = "<%=request.getContextPath()%>/questions/toAdd?paperId=${paper.id}&d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
		
		function close(){
			$.modal.close(); 
		}
		
		function showSelect(obj,value,type,id){
			var selects = value.split(";");
			var html = "";
			for(var i = 0; i < selects.length; i ++){
				if(type == 1){
					html += '<label class="radio">'+
						'<input type="radio" name="name$'+id+'" value="'+(i+1)+'" data-toggle="radio">'+selects[i]+'</label>';
						
				}else if(type == 2){
					html += '<label class="checkbox">'+
						'<input type="checkbox" name="name$'+id+'" value="'+(i+1)+'" data-toggle="checkbox">'+selects[i]+'</label>';
				}
			}
			
			$("#"+obj).html(html);
		}
	
		function toBack(){
			window.location = "<%=request.getContextPath()%>/paper/examList";
		}
		
		var endDate ;
		var intervalId;
		function toStart(){
			var times = "${paper.time}".split(":");
			if(times.length == 3){
				var now = new Date();
				var hours = now.getHours() + parseInt(times[0]);
			    var minutes = now.getMinutes() + parseInt(times[1]);
			    var seconds = now.getSeconds()+ parseInt(times[2]);
			    var year = now.getFullYear();
			    var month = now.getMonth() ;
			    var day = now.getDate();
			    
			    endDate= new Date(year,month,day,hours,minutes,seconds);
			    intervalId = window.setInterval(loop, 1000);
			}
		}
		
		function loop(){
			var now = new Date();
		   	var resSeconds = (endDate.getTime()) - (now.getTime());
		    var resDate = new Date(resSeconds);
		    
		    $("#time").html((resDate.getHours()-8) + ":" + resDate.getMinutes() + ":" + resDate.getSeconds());
		    
		    if(parseDate(now) >= parseDate(endDate)){
		    	window.clearInterval(intervalId);
		    	$("#time").html("00:00:00");
		    	alert("交卷");
		    }
		}
		
		function parseDate(date){
			var dateStr = "";
			var hours = date.getHours();
		    var minutes = date.getMinutes() ;
		    var seconds = date.getSeconds();
		    var year = date.getFullYear();
		    var month = date.getMonth() + 1;
		    var day = date.getDate();
			
		    dateStr = year + "-" + month +"-"+ day + " "+ hours + ":" + minutes + ":" + seconds;
		    return dateStr;
		}
		
	</script>
</head>
<body>
	<table border="0" width="100%">
		<thead>
			<tr class="tableBar" style="border: none;">
				<td class="title">
					<span class="fui-play"></span>&nbsp;考试卷模版
				</td>
				<td class="toolBar" colspan="2">
					<input type="button" class="btn btn-sm btn-info" value="开&nbsp;始" onclick="toStart()">
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="返&nbsp;回" onclick="toBack()">
				</td>
			</tr>
			<tr>
				<th colspan="3"><h6  align="center">${paper.name}考试卷</h6></th>
			</tr>
			<tr>
				<th class="rowTex">考员姓名:<input type="text" class="qtsText" value="${sessionScope.user.name}"/></th>
				<th class="rowTex">班级:<input type="text" class="qtsText" value="${sessionScope.user.className}"/></th>
				<th class="rowTex">考试剩余时长:&nbsp;
				<span id="time">
					<c:choose>
						<c:when test="${paper.time == '00:00:00'}">不限</c:when>
						<c:otherwise>${paper.time}</c:otherwise>
					</c:choose>
				</span></th>
			</tr>
		</thead>
	</table>
	<div style="text-align: left;margin-top: 30px;padding-left: 30px;">
		<c:forEach items="${requestScope.questions}" var="qstions" varStatus="st">
			<div style="text-align: left;">
				${st.index + 1}. ${qstions.context}
				<p/>
				<div class="form-group">
					<c:if test="${qstions.type != 3}">
						<span id="${st.index + 1}">
							<script type="text/javascript">
								showSelect(
										'${st.index + 1}',
										'${qstions.answer}',
										'${qstions.type}',
										'${qstions.id}');
							</script>
						</span>
					</c:if>
					<c:if test="${qstions.type == 3}">
						回答 :&nbsp; 
						<textarea rows="1" class="anText" ></textarea>
					</c:if>
				</div>
				<br/>
			</div>
		</c:forEach>
	</div>
</body>
</html>