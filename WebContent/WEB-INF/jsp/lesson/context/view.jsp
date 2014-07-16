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
		$(function(){
			
			var type = "${context.type}";
			
			if(config[type].showType == "file"){
				
				$("#"+config[type].showType).show();
				$("#fileType").html("(文件类型:" + config[type].fileType+")");
				
				///$("form").filter("[id!="+config["${context.type}"].showType+"]").remove();
			}else{
				$("#"+type).show();
				
				if(config[type].showType == "select"){
					$("#context").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
				}
				
				setCEEditor(type);
			}
			
			var forms = $("form");
			for(var i = 0; i < forms.length; i ++){
				bindForm(forms[i]);
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
								alert("修改课时内容成功!");
								window.parent.parent.parent.mainFrame.close();
							}else{
								alert("修改课时内容失败，请联系管理员!");
							}
						}
				   });
				}
			});
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
		
		function downloadFile(id){
			window.location ="<%=request.getContextPath()%>/context/downloadSource?id="+id;
		}
		
		function toBack(){
			parent.close();
		}
		
	</script>
</head>
<body>
	<div id="formContext" class="tile" style="border-radius: 1px;">
	   	<form id="file" action="<%=request.getContextPath()%>/context/update" method="POST" enctype="multipart/form-data" >
	   	   <input type="hidden" name="id" value="${context.id}">
		   <table style="width: 100%; height: 100%;" border="0">
	   	   	   <tr>
		   	   		<td width="8%" class="input_label"><div class="form-group">名称</div></td>
					<td>
						<div class="form-group">
							<input type="text" class="form-control" name="name"
							 placeholder="请输入名称" value="${context.name}" />
							 
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
	   	   			<td width="12%" class="input_label"><div class="form-group">源文件</div></td>
	   	   			<td style="text-align: left;">
		   	   			<div class="form-group">
			   	   			<a href="javascript:downloadFile('${context.id}')">${context.source}</a>&nbsp;
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
	   	
	   	<form id="6" action="<%=request.getContextPath()%>/context/update" method="POST" >
	   	   <input type="hidden" name="id" value="${context.id}">
	   	   <input type="file" name="fileName" style="display: none;"/>
		   <table style="width: 100%; height: 100%;" border="0">   	  
	   		 <tr>
	   	   		<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name"
						 placeholder="请输入名称" value="${context.name}"/>
						 
					</div>
				</td>
   	   		 </tr> 		
		   	 <tr>
		   	   	<td width="12%" class="input_label">
		   	   		<div class="form-group">超链接URL地址</div>
		   	   	</td>
		   	   	<td>
   	   				<div class="form-group">
					   	<input type="text" class="form-control" name="context" id="linkURL"  value="${context.context}">
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
   	 
	 <form id="8" action="<%=request.getContextPath()%>/context/update" method="POST" >
	 	<input type="hidden" name="id" value="${context.id}">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">   
		   <tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称"
						 value="${context.name}"/>
						 
					</div>
				</td>
	   	   	</tr>	   
		    <tr>
	   	   		<td colspan="2">
   	   				<div class="form-group">
				   		<textarea rows="" cols="" id="editor8" name="context">${context.context}</textarea>
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
   	 
   	 <form id="9" action="<%=request.getContextPath()%>/context/update" method="POST" >
   	 	<input type="hidden" name="id" value="${context.id}">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" 
						value="${context.name}"/>
					</div>
				</td>
	   	   	</tr>	    	 
   	   		<tr>
   	   			<td colspan="2">
   	   				<div class="form-group">
				   		<textarea rows="" cols=""  id="editor9" name="context">${context.context}</textarea>
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
   	 
   	 <form id="10" action="<%=request.getContextPath()%>/context/update" method="POST" >
   	  	<input type="hidden" name="id" value="${context.id}">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" 
						value="${context.name}"/>
					</div>
				</td>
	   	   	</tr>	
   	   		<tr>
   	   			<td width="8%" class="input_label"><div class="form-group">考试卷</div></td>
   	   			<td>
   	   				<div class="form-group" style="width: 400px;">
				   		<select id="context" class="select-block"  name="context">
				   			<c:forEach items="${papers}" var="paper">
				   				<option value="${paper.id}"
				   					<c:if test="${context.context == paper.id}">selected="selected"</c:if>
				   				>${paper.name}</option>
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
   	 
   	 <form id="11" action="<%=request.getContextPath()%>/context/update" method="POST" >
   	 	<input type="hidden" name="id" value="${context.id}">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" 
						value="${context.name}"/>
					</div>
				</td>
	   	   	</tr>
   	   		<tr>
   	   			<td colspan="2">
   	   				 <div class="form-group">
				   		<textarea rows="" cols="" id="editor11" name="context">${context.context}</textarea>
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
   	 
   	 <form id="12" action="<%=request.getContextPath()%>/context/update" method="POST" >
   	 	<input type="hidden" name="id" value="${context.id}">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" 
						value="${context.name}"/>
						
					</div>
				</td>
	   	   	</tr>
   	   		<tr>
   	   			<td colspan="2">
   	   				<div class="form-group">
				   		<textarea rows="" cols="" id="editor12"  name="context">${context.context}</textarea>
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
   	 
   	 <form id="13" action="<%=request.getContextPath()%>/context/update" method="POST" >
   	 	<input type="hidden" name="id" value="${context.id}">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称"
						 value="${context.name}" />
					</div>
				</td>
	   	   	</tr>
   	   		<tr>
   	   			<td colspan="2">
   	   				<div class="form-group">
				   		<textarea rows="" cols="" id="editor13"  name="context">${context.context}</textarea>
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
	 
	 <form id="14" action="<%=request.getContextPath()%>/context/update" method="POST" >
	 	<input type="hidden" name="id" value="${context.id}">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称" 
						value="${context.name}"/>
					</div>
				</td>
	   	   	</tr>	
   	   		<tr>
   	   			<td colspan="2">
   	   				 <div  class="form-group">
				   		<textarea rows="" cols="" id="editor14"  name="context">${context.context}</textarea>
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
   	 
   	 <form id="15" action="<%=request.getContextPath()%>/context/update" method="POST" >
   	 	<input type="hidden" name="id" value="${context.id}">
	   	<input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称"
						 value="${context.name}"/>
					</div>
				</td>
	   	   	</tr>	
   	   		<tr>
   	   			<td colspan="2">
   	   				 <div  class="form-group">
				   		<textarea rows="" cols="" id="editor15"  name="context">${context.context}</textarea>
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
	 
	<form id="17" action="<%=request.getContextPath()%>/context/update" method="POST" >
		<input type="hidden" name="id" value="${context.id}">
	    <input type="file" name="fileName" style="display: none;"/>
		<table style="width: 100%; height: 100%;" border="0">  
			<tr>
		   	   	<td width="8%" class="input_label"><div class="form-group">名称</div></td>
				<td>
					<div class="form-group">
						<input type="text" class="form-control" name="name" placeholder="请输入名称"
						 value="${context.name}"/>
					</div>
				</td>
	   	   	</tr>	
   	   		<tr>
   	   			<td colspan="2">
		   	   		<div class="form-group">
				   		<textarea rows="" cols="" id="editor17" name="context">${context.context}</textarea>
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