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
		
		$(function(){
			$("#uploadForm").hide();
			$("#excelFile").hide();
		});
	
		function toBack(){
			window.location = "<%=request.getContextPath()%>/paper/list";
		}
		
		function deleteById(id){
			if(window.confirm("你确认删除此试题?")){
				window.location = "<%=request.getContextPath()%>/questions/deleteById?id="+id;
			}
		}
		
		function toImport(){
			option.maxHeight = 213;
			option.maxWidth = 400;
			$('#uploadForm').modal(option);
		}
		
		function toUpload(){
			
			var excel = $("#excelFile").val();
			excel = excel.substring(excel.lastIndexOf(".")+1); 
			if(excel != "xls"){
				$("#error").html($("#excelFile").val() + "&nbsp;文件格式不对,例如:用户信息.xls");
				return false;
			}
			 
			$("#uploadForm").submit();
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
					<input type="button" class="btn btn-sm btn-info" value="添&nbsp;加" onclick="toAdd()">
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="批量导入" onclick="toImport()">
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="返&nbsp;回" onclick="toBack()">
				</td>
			</tr>
			<tr>
				<th colspan="3"><h6  align="center">${paper.name}考试卷</h6></th>
			</tr>
			<tr>
				<th class="rowTex">考员姓名:<input type="text" class="qtsText"/></th>
				<th class="rowTex">班级:<input type="text" class="qtsText"/></th>
				<th class="rowTex">考试时长:&nbsp;${paper.time}</th>
			</tr>
		</thead>
	</table>
	<div style="text-align: left;margin-top: 30px;padding-left: 30px;">
		<c:forEach items="${requestScope.questions}" var="qstions" varStatus="st">
			<div style="text-align: left;">
				${st.index + 1}. ${qstions.context}
				<span style="margin-left: 20px;">
					[<a href="javascript:deleteById('${qstions.id}')">删除</a>]&nbsp;
				</span>
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
	
	<form action="<%=request.getContextPath()%>/questions/upload" id="uploadForm" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="paperId" value="${paper.id}">
		<div  class="tile">
			<div class="bs-docs-example">
	            <div class="alert alert-info">
	               <strong>温馨提示!</strong>&nbsp;先下载Excel模版，填入问题内容之后，再上传该Excel文件
	             </div>
         	</div>
			<input type="file"  name="excelFile" id="excelFile" onchange="toUpload()">
			<input type="button" class="btn btn-lg btn-success" value="上传文件" onclick="$('#excelFile').click()">
			&nbsp;&nbsp;&nbsp;
			<input type="button" class="btn btn-lg btn-success" value="下载模版" onclick="window.location = '<%=request.getContextPath()%>/questions/download'">
			<br/>&nbsp;
			<span id="error" style="color: red;height: 10px;">
			</span>
		</div>
	</form>
</body>
</html>