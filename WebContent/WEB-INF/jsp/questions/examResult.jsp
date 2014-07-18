<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<script type="text/javascript">
		function showSelect(obj,value,type,id){
			var selects = value.split(";");
			var html = "";
			for(var i = 0; i < selects.length; i ++){
				if(type == 1){
					html += '<label class="radio">'+
						'<input type="radio" name="'+id+'" value="'+(selects[i])+'" data-toggle="radio">'+selects[i]+'</label>';
						
				}else if(type == 2){
					html += '<label class="checkbox">'+
						'<input type="checkbox" name="'+id+'" value="'+(selects[i])+'" data-toggle="checkbox">'+selects[i]+'</label>';
				}
			}
			
			$("#"+obj).html(html);
		}
	
	</script>
</head>
<body>
	<table border="0" width="100%">
		<thead>
			<tr class="tableBar" style="border: none;">
				<td class="title">
					<span class="fui-play"></span>&nbsp;考试卷
				</td>
				<td class="toolBar" colspan="2">
					<span id="subBtn" style="display: none;">
						<input type="submit"  class="btn btn-sm btn-info" value="交&nbsp;卷">
						&nbsp;&nbsp;
					</span>
					<span  id="startBtn">
						<input type="button" class="btn btn-sm btn-info" value="开&nbsp;始" onclick="toStart()">
						&nbsp;&nbsp;
					</span>
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
	<div style="text-align: left;margin-top: 30px;padding-left: 30px;display: none;" id="quests">
			<c:forEach items="${requestScope.questions}" var="qstions" varStatus="st">
				<div style="text-align: left;">
					${st.index + 1}. ${qstions.context}
					<span style="margin-left: 30px;">[&nbsp;分数:${qstions.score}&nbsp;]</span>
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
							<textarea rows="1" class="anText" name="${qstions.id}"></textarea>
						</c:if>
					</div>
					<br/>
				</div>
			</c:forEach>
		</div>
</body>
</html>