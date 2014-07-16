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
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-select.js" type="text/javascript"></script>
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
		
		
		.thumbnails{
			cursor: pointer;
			padding: 20px 20px;
		}
		
		.thumbnail{
			width: 90px;
			height: 90px;
			border: solid 1 red;
			list-style: none;
			float: left;
			margin: 30px 10px;
		}
		
		.thumbnail:HOVER {
			border: solid 2px #3498DB;
		} 
		
		form{
			display: none;
		}
		
	</style>
	<script type="text/javascript">
		function toAdd(type,id){
			init();
			if(config[type].showType == "file"){
				$("#"+config[type].showType).fadeIn("slow");
				$("#fileType").html("(文件类型:" + config[type].fileType+")");
			}else{
				$("#"+type).fadeIn("slow");
				if(config[type].showType == "select"){
					$("#context").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
				}
			}
			
			$("[name=tempId]").val(id);
			
			setCEEditor(type);
		}
		
		function init(){
			$(".row-fluid").fadeOut("slow");
			$("#formContext").fadeIn("slow");
		}
		
		function toBack(){
			$(".row-fluid").fadeIn("slow");
			$("#formContext").fadeOut("slow");
			$("form").hide();
			$("#filePath").html("");
		}
		
		
		function setCEEditor(type){
			if(config[type].showType == "text"){
				CKEDITOR.replace( 'editor' + type, {
					fullPage: true,
					allowedContent: true
				});
			}
		}
		
		function selectFileType(obj){
			$("#filePath").html("&nbsp;&nbsp;"+$(obj).val());
		}
		
		$(function(){
			var forms = $("form");
			for(var i = 0; i < forms.length; i ++){
				bindForm($(forms[i]));
			}
		});
		
		function bindForm(bindForm){
			var validator = $(bindForm).validate({
				success:success,
				ignore: "",
				errorPlacement: showErrorPlacement,
				rules:{
					"name":{
						required: true
					}
				},
				messages:{
					"name": "名称不能为空!"
				},
				submitHandler: function(form) {
					
		            for (instance in CKEDITOR.instances){
		                CKEDITOR.instances[instance].updateElement();
		            }
		            
		            
					$(form).ajaxSubmit({
						dataType	: "json",
						type        : "POST",
						cache       : false,
						success		: function(data){								
							if(data.result){
								alert("添加课时内容成功!");
								window.parent.parent.parent.mainFrame.close();
							}else{
								alert("添加课时内容失败，请联系管理员!");
							}
						}
					});
				}
			});
		}
		
	</script>
</head>
<body>
	<div class="row-fluid">
	  <div align="center" style="font-size: 16px;font-weight:bold;margin-bottom: -15px;margin-top: 20px;">课时内容类型:</div>
	  <c:if test="${requestScope.templates.size() == 0}">
	  	<div style="margin-top: 30px;text-align: center;">
	   		请先创建客户类别模版
	  	</div>
  	  </c:if>
      <ul class="thumbnails">
		<c:forEach items="${requestScope.templates}" var="templ" varStatus="st">
	        <li class="thumbnail" onclick="toAdd('${templ.type}','${templ.id}')">
	            <div>
	              <img src="" id="img${st.index + 1}">
	              <div class="caption" style="text-align: center;padding-top: 10px;">
	                <span style="font-size: 14px;font-weight: bolder;">${templ.name}</span>
	              </div>
	            </div>
	        </li>
			<script type="text/javascript">
				setImg($("#img${st.index + 1}"),"<%=request.getContextPath()%>","${templ.type}");
			</script>
		</c:forEach>
     </ul>
   </div>
   <div id="formContext" style="display: none;"  class="tile" style="border-radius: 1px;">
   		
	   	<form id="file" action="<%=request.getContextPath()%>/context/add" method="POST" enctype="multipart/form-data" >
	   	   <input type="hidden" name="lessonId" value="${param.lessonId}">
	   	   <input type="hidden" name="tempId" value="">
		   <table style="width: 100%; height: 100%;" border="0">
	   	   	   <tr>
		   	   		<td width="8%" class="input_label"><div class="form-group">名称</div></td>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="name" placeholder="请输入名称" />
						</div>
					</td>
	   	   		</tr>
	   	   		<tr>
	   	   			<td width="12%" class="input_label"><div class="form-group">文件</div></td>
	   	   			<td style="text-align: left;">
		   	   			<div class="form-group">
		   	   				<input type="button" class="btn btn-sm btn-success" value="上传文件" 
		   	   				onclick="$('#fileName').click()" >
		   	   				<span id="fileType"></span>
		   	   				
			   	   			<input type="file" id="fileName" name="fileName" style="display: none;" 
			   	   				onchange="selectFileType(this)">
			   	   			<span id="filePath"></span>
		   	   			</div>
	   	   			</td>
	   	   		</tr>
	   	   		<tr>
	   	   			<td colspan="2">
	   	   					<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   	   			   style="margin:15px 10px;width: 100px;">
	   	   	   			   	&nbsp;&nbsp;&nbsp;
	   	   	   			    <input type="button" value="返&nbsp;回" class="btn btn-default"
	   	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
	   	   	   		</td>
	   	   		</tr>
	   	   	</table>
	   	</form>		
	   	
	   	<form id="6" action="<%=request.getContextPath()%>/context/add" method="POST" >
	   	   <input type="hidden" name="lessonId" value="${param.lessonId}">
	   	   <input type="hidden" name="tempId" value="">
	   	   <input type="file" name="fileName" style="display: none;"/>
		   <table style="width: 100%; height: 100%;" border="0">   	  
	   		 <tr>
	   	   		<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
   	   		 </tr> 		
		   	 <tr>
		   	   	<td width="12%" class="input_label">
		   	   		<div class="form-group">超链接URL地址</div>
		   	   	</td>
		   	   	<td>
   	   				<div class="form-group">
					   	<input type="text" class="form-control" name="context" id="linkURL">
					 </div>
   	   			</td>
		   	</tr>
		   	<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
		 </table>
   	 </form>
   	 
	 <form id="8" action="<%=request.getContextPath()%>/context/add" method="POST" >
	 	<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">   
		   <tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>	   
		    <tr>
	   	   		<td colspan="2">
   	   				<div class="form-group">
				   		<textarea rows="" cols="" id="editor8" name="context">
				   			<p><strong>项目的需求：</strong></p><p/>
							<p><strong>需求评估:</strong></p><p/>
							<p><strong>开发周期:</strong></p><p/>
							<p><strong>开发环境:</strong></p><p/>
				   		</textarea>
				   </div>
	   	   		</td>
   	   		 </tr>
   	   		 <tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	   	</table>
   	 </form>
   	 
   	 <form id="9" action="<%=request.getContextPath()%>/context/add" method="POST" >
   	 	<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>	    	 
   	   		<tr>
   	   			<td colspan="2">
   	   				<div class="form-group">
				   		<textarea rows="" cols=""  id="editor9" name="context">
					   		<p><strong>讨论的内容：<strong></strong>
							<p>&nbsp;</p>
							<p>&nbsp;</p>
							<p><strong>结论:</strong></p>
						</textarea>
				   </div>
   	   			</td>
   	   		</tr>
   	   		<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	   	</table>
   	 </form>
   	 
   	 <form id="10" action="<%=request.getContextPath()%>/context/add" method="POST" >
   	 	<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>	
   	   		<tr>
   	   			<td width="8%" class="input_label"><div class="form-group">考试卷</div></td>
   	   			<td>
   	   				<div class="form-group" style="width: 400px;">
				   		<select id="context" class="select-block"  name="context">
				   			<c:forEach items="${papers}" var="paper">
				   				<option value="${paper.id}">${paper.name}</option>
				   			</c:forEach>
				   		</select>
				     </div>
   	   			</td>
   	   		</tr>
   	   		<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	 	</table>
   	 </form>
   	 
   	 <form id="11" action="<%=request.getContextPath()%>/context/add" method="POST" >
   	 	<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>
   	   		<tr>
   	   			<td colspan="2">
   	   				 <div class="form-group">
				   		<textarea rows="" cols="" id="editor11" name="context">
				   			<p><strong>练习的内容：</strong></p>&nbsp;&nbsp;
				   		</textarea>
				    </div>
   	   			</td>
   	   		</tr>
   	   		<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	   	</table>
   	 </form>
   	 
   	 <form id="12" action="<%=request.getContextPath()%>/context/add" method="POST" >
   	 	<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>
   	   		<tr>
   	   			<td colspan="2">
   	   				<div class="form-group">
				   		<textarea rows="" cols="" id="editor12"  name="context">
				   			<p><strong>测试的内容介绍：</strong></p>&nbsp;&nbsp;
							<p><strong>测试环境：<p><strong>&nbsp;&nbsp;
							<p><strong>测试数据：<p><strong>&nbsp;&nbsp;
							<p><strong>测试结果：<p><strong>
				   		</textarea>
				   </div>
   	   			</td>
   	   		</tr>
   	   		<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	   	</table>
   	 </form>
   	 
   	 <form id="13" action="<%=request.getContextPath()%>/context/add" method="POST" >
   	 	<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>
   	   		<tr>
   	   			<td colspan="2">
   	   				<div class="form-group">
				   		<textarea rows="" cols="" id="editor13"  name="context">
				   			<p><strong>面试的内容：</strong></p>&nbsp;&nbsp;
							<p><strong>面试的公司地址：</strong></p>&nbsp;&nbsp;
							<p><strong>面试的人员：</strong></p>&nbsp;&nbsp;
							<p><strong>面试的结果：</strong></p>&nbsp;&nbsp;
				   		</textarea>
				   </div>
   	   			</td>
   	   		</tr>
   	   		<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	   	</table>
   	 </form>
	 
	 <form id="14" action="<%=request.getContextPath()%>/context/add" method="POST" >
	 	<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>	
   	   		<tr>
   	   			<td colspan="2">
   	   				 <div  class="form-group">
				   		<textarea rows="" cols="" id="editor14"  name="context">
				   			<p><strong>软件的介绍：</strong><p/>&nbsp;&nbsp; 
							<p><strong>软件下载地址：</strong><p/>&nbsp;&nbsp; 
				   		</textarea>
				   </div>
   	   			</td>
   	   		</tr>
   	   		<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	   	</table>
   	 </form>
   	 
   	 <form id="15" action="<%=request.getContextPath()%>/context/add" method="POST" >
   	 	<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>	
   	   		<tr>
   	   			<td colspan="2">
   	   				 <div  class="form-group">
				   		<textarea rows="" cols="" id="editor15"  name="context">
				   			<strong><p>代码的片段：</strong></p>&nbsp;&nbsp;
				   		</textarea>
				    </div>
   	   			</td>
   	   		</tr>
   	   		<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px;width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px;  width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	   	</table>
   	 </form>
	 
	<form id="17" action="<%=request.getContextPath()%>/context/add" method="POST" >
		<input type="hidden" name="lessonId" value="${param.lessonId}">
	   	<input type="hidden" name="tempId" value="">
	    <input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" />
					</div>
				</td>
	   	   	</tr>	
   	   		<tr>
   	   			<td colspan="2">
		   	   		<div class="form-group">
				   		<textarea rows="" cols="" id="editor17" name="context"></textarea>
				   </div>
   	   			</td>
   	   		</tr>
   	   		<tr>
   	   			<td colspan="2">
	   				<input type="submit" value="保&nbsp;存" class="btn btn-primary"
	   	   			   style="margin:15px 10px; width: 100px;">
 	   	   			   
 	   	   			&nbsp;&nbsp;&nbsp;
 	   	   			<input type="button" value="返&nbsp;回" class="btn btn-default"
 	   	   			   style="margin:15px 10px; width: 100px;"  onclick="toBack()">
   	   	   		</td>
	   	   	</tr>
   	   	</table>
   	 </form>
   </div>
</body>
</html>