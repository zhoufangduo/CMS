<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="e" uri="http://www.easytop/tag" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet" type='text/css' >
	<link href="<%=request.getContextPath()%>/resource/flat-ui/css/flat-ui.css" rel="stylesheet" type='text/css' > 
	<link href="<%=request.getContextPath()%>/resource/flat-ui/css/demo.css" rel="stylesheet" type='text/css' > 
	<link href='<%=request.getContextPath()%>/resource/simplemodal/css/basic.css' rel='stylesheet' type='text/css'  />
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/html5shiv.js"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.tagsinput.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.placeholder.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.stacktable.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/simplemodal/js/jquery.simplemodal.js"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/application.js" type="text/javascript"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/script/template.js"></script>
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
		
		
		function close(){
			$.modal.close(); 
		}
		
		function toAdd(){
			var url = "<%=request.getContextPath()%>/template/toAdd?d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
		
		function deleteById(id, name){
			if(window.confirm("你确定删除此模版:"+name+"?")){
				window.location = "<%=request.getContextPath()%>/template/deleteById?id="+id;
			}
		}
		
		function toBack(){
			window.location = "<%=request.getContextPath()%>/technology/list";
		}
	</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/template/list" class="form-horizontal"  method="post">
		<table style="width: 100%; height: 100%;">
			<tr class="tableBar">
				<td colspan="2" class="title">
					<span class="fui-play"></span>&nbsp;课时内容模版
				</td>
				<td colspan="4"  class="toolBar">
					<input type="button" class="btn btn-sm btn-info" value="添&nbsp;加" onclick="toAdd()">
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="返&nbsp;回" onclick="toBack()">
				</td>
			</tr>
	    </table>
	    <br/>
		<table class="table table-hover" border="0" style="table-layout: fixed;overflow: hidden;">
            <thead>
              <tr>
              	<th class="tlabel" width="8%">图标</th>
              	<th class="tlabel" width="6%">ID</th>
                <th class="tlabel" width="12%">名称</th>
                <th class="tlabel" width="10%">模版类型</th>
                <th class="tlabel" width="10%">创建者</th>
                <th class="tlabel" width="15%">创建时间</th>
                <th class="tlabel">描述</th>
                <th class="tlabel" width="15%">操作</th>
             </tr>
            </thead>
            <tbody>
            	<c:forEach items="${requestScope.templates}" var="templ" varStatus="st">
            		<tr>
            			<td class="tlabel">
            				<img alt="" src="" id="img${st.index + 1}"
            				width="30" height="30" />
            				
            			</td>
            			<td class="tlabel">${st.index + 1}</td>
            			<td class="tlabel" title="${templ.name}">${templ.name}</td>
            			<td class="tlabel">
            				<span id="type${st.index + 1}">
            					<script>
            					if("${templ.type}".split(";").length  > 1){
            						setImg($("#img${st.index + 1}"),"<%=request.getContextPath()%>","0");
            						setTypes($("#type${st.index + 1}"),"${templ.type}");
            					}else{
            						setImg($("#img${st.index + 1}"),"<%=request.getContextPath()%>","${templ.type}");
	            					setType($("#type${st.index + 1}"),"${templ.type}");
            					}
            					</script>
            				</span>
            			</td>
            			<td class="tlabel" title="${templ.creator}">${templ.creator}</td>
            			<td class="tlabel" title="${templ.createTime}">${templ.createTime}</td>
            			<td class="tlabel" title="${templ.context}">${templ.context}</td>
            			<td class="tlabel">
            				<a href="javascript:deleteById('${templ.id}','${templ.name}')">删除</a>
            			</td>
            		</tr>
            	</c:forEach>
            	<tr>
	           		<td colspan="8">
	           			<div class="pageBar">
		        	 		<e:page page="${page}" formId="queryForm"></e:page>
		       			 </div>
	           		</td>
	           	</tr>
            </tbody>
	     </table>
	</form>
</body>
</html>