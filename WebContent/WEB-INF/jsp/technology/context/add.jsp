<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resource/flat-ui/css/flat-ui.css" rel="stylesheet"> 
	<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/prettify.css" rel="stylesheet"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/html5shiv.js"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/validate/jquery.form.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.tagsinput.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.placeholder.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.stacktable.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/validate_form.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/validate/messages_zh.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/My97DatePicker/WdatePicker.js"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/script/template.js"></script>
	<script src="<%=request.getContextPath()%>/resource/ckeditor/ckeditor.js"></script>
	<style type="text/css">
	
		img{
			width: 80px;
			height: 80px;
		}
		
		.row-fluid{
			margin: 0px;
			width: 100%;
			height: 100%;
		}
		
		li{
			list-style: none;
			border: solid 1px;
			margin: 0px;
			float: left;
			margin: 30px 10px;
		}
		
		.thumbnails{
			cursor: pointer;
			padding: 20px 20px;
		}
		
		.thumbnail{
			width: 90px;
			height: 90px;
			border: solid 1 red;
		}
		
		.thumbnail:HOVER {
			border: solid 2px #3498DB;
		} 
		.form-group{
			display: none;
			text-align: center;
		}
	</style>
	<script type="text/javascript">
		function toAdd(type, id){
			$(".row-fluid").fadeOut("slow");
			$("#context").fadeIn("slow");
			$(".form-group").hide();
			if(type.split(";").length > 1){
				var array = type.split(";");
				for(var i = 0; i < array.length; i ++){
					$("#" + array[i]).fadeIn("slow");
					setCEEditor(array[i]);
				}
			}else{
				$("#"+type).fadeIn("slow");
				setCEEditor(type);
			}
		}
		
		function toBack(){
			$(".row-fluid").fadeIn("slow");
			$("#context").fadeOut("slow");
		}
		
		
		function setCEEditor(type){
			if(config[type].showType == "text"){
				CKEDITOR.replace( 'editor' + type, {
					fullPage: true,
					allowedContent: true,
					extraPlugins: 'wysiwygarea'
				});
			}
		}
		
		$(function(){
			$("#state").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
		});
		
	</script>
</head>
<body>
	<div class="row-fluid">
	  <div align="center" style="font-size: 16px;font-weight:bold;margin-bottom: -15px;margin-top: 20px;">课时内容类型:</div>
      <ul class="thumbnails">
		<c:forEach items="${requestScope.templates}" var="templ" varStatus="st">
	        <li class="thumbnail" onclick="toAdd('${templ.type}',${templ.id})">
	            <div>
	              <img src="" id="img${st.index + 1}">
	              <div class="caption" style="text-align: center;padding-top: 10px;">
	                <span style="font-size: 14px;font-weight: bolder;">${templ.name}</span>
	              </div>
	            </div>
	        </li>
			<script type="text/javascript">
				if("${templ.type}".split(";").length  > 1){
					setImg($("#img${st.index + 1}"),"<%=request.getContextPath()%>","0");
				}else{
					setImg($("#img${st.index + 1}"),"<%=request.getContextPath()%>","${templ.type}");
				} 
			</script>
		</c:forEach>
     </ul>
   </div>
   <div id="context" style="display: none;">
	   <form action="" method="POST">
	   	   <input type="button" value="返&nbsp;回" class="btn btn-sm btn-info" 
	   	   style="margin:15px 10px;"  onclick="toBack()">
	   	   
	   	   <div style="text-align: center;">
			   <div id="1" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="2" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="3" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="4" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="5" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="6" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="7" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="8" class="form-group">
			   		<select id="" class="select-block"></select>
			   		<textarea rows="" cols="" >
			   		
			   		</textarea>
			   </div>
			   <div id="9" class="form-group">
			   		<textarea rows="" cols=""  id="editor9">
				   		<h3>讨论的内容：</h3>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<h3>结论:</h3>
					</textarea>
			   </div>
			   <div id="10" class="form-group">
			   		<select></select>
			   </div>
			   <div id="11" class="form-group">
			   		<textarea rows="" cols="" id="editor11" >
			   			<h3>练习的内容：</h3>
			   			<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
			   		</textarea>
			   </div>
			   <div id="12" class="form-group">
			   		<textarea rows="" cols="" id="editor12">
			   			<h3>测试的内容介绍：</h3>
			   			<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
						<h3>测试环境：</h3>
						<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
						<h3>测试数据：</h3>
						<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
						<h3>测试结果：</h3>
			   		</textarea>
			   </div>
			   <div id="13" class="form-group">
			   		<textarea rows="" cols="" id="editor13" >
			   			<h3>面试的内容：</h3>
			   			<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
						<h3>面试的公司地址：</h3>
			   			<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
						<h3>面试的人员：</h3>
			   			<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
						<h3>面试的结果：</h3>
			   			<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
			   		</textarea>
			   </div>
			   <div id="14" class="form-group">
			   		<textarea rows="" cols="" id="editor14" >
			   			<h3>软件的介绍：</h3>
			   			<h3>&nbsp;&nbsp;</h3>
						<h3>&nbsp;</h3>
						<h3>软件下载地址：</h3>
			   			<h3>&nbsp;&nbsp; <a href="http://www.hao123.com" target="_blank">http://www.hao123.com</a></h3>
						<h3>&nbsp;</h3>
			   		</textarea>
			   </div>
			   <div id="15" class="form-group">
			   		<textarea rows="" cols="" id="editor15">
			   			<h3>代码的片段：</h3>
			   			<h3>&nbsp;&nbsp;</h3>
			   		</textarea>
			   </div>
			   <div id="16" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="17" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
			   <div id="18" class="form-group">
			   		<textarea rows="" cols="" id="editor18"></textarea>
			   </div>
			   <div id="19" class="form-group">
			   		<input type="file" name="fileName">
			   </div>
		  </div>
	   </form>
   </div>
</body>
</html>