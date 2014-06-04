<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
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
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-select.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-checkbox.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.tagsinput.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.placeholder.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.stacktable.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/resource/simplemodal/js/jquery.simplemodal.js"></script>
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/application.js" type="text/javascript"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
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
			var url = "<%=request.getContextPath()%>/item/toAdd?d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
		
		function close(){
			$.modal.close(); 
		}
		
		function deleteById(id,name,newFileName){
			if(window.confirm("你确定删除此项目:"+ name + "?")){
				window.location = "<%=request.getContextPath()%>/item/deleteById?id="+ id +"&newFileName=" + newFileName;
			}
		}
		
		function toDownload(newFileName,fileName,downloadAddr){
			
			if(newFileName != "" && newFileName != null){
				
				window.location = "<%=request.getContextPath()%>/item/download?newFileName=" + newFileName
						+ "&fileName=" + fileName;
			}else{
				window.location = downloadAddr; 
			}
		}
	</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/item/list" class="form-horizontal" method="post">
		<table style="width: 100%; height: 100%;">
			<tr class="tableBar">
				<td colspan="2" class="title">
					<span class="fui-play"></span>&nbsp;项目查询
				</td>
				<td colspan="4"  class="toolBar">
					<input type="button" class="btn btn-sm btn-info" value="添&nbsp;加" onclick="toAdd()">
					&nbsp;&nbsp;
					<input type="submit" class="btn btn-sm btn-info" value="查&nbsp;询" >
				</td>
			</tr>
			<tr class="searchBg">
				<td width="10%" class="qlabel">
					项目名称
				</td>
				<td width="20%" class="ttext">
					<input type="text" class="form-control" name="name" placeholder="请输入查询的项目名称" value="${param.name}" />
				</td>
				<td width="10%" class="qlabel">
					文件名称
				</td>
				<td width="20%" class="ttext">
					<input type="text" class="form-control" name="fileName" placeholder="请输入查询的文件名称" value="${param.fileName}" />
				</td>
				<td></td>
				<td></td>
			</tr>
			<tr class="searchBg">
				<td width="10%" colspan="6" height="8">
					
				</td>
			</tr>
	    </table>
	    <br/>
		<table class="table table-hover" border="0">
           <thead>
             <tr>
               <th class="tlabel" width="10%">项目名称</th>
               <th class="tlabel" width="12%">源代码包下载</th>
               <th class="tlabel" width="13%">开发团队</th>
               <th class="tlabel" width="10%">开发周期</th>
               <th class="tlabel" width="10%">描述</th>
               <th class="tlabel" width="13%">操作</th>
             </tr>
          </thead>
          <tbody class="wrap">
          	<c:forEach items="${requestScope.items}" var="item">
          		<tr>
          			<td class="tlabel" width="10%" title="${item.name}">
              	 		${item.name}
              	 	</td>
              	 	<td class="tlabel" width="12%">
              	 		<c:if test="${item.fileName != null && item.fileName != '' }">
              	 			${item.fileName}&nbsp;
              	 		</c:if>
              	 		<c:if test="${item.downloadAddr != null && item.downloadAddr != ''}">
              	 			${item.downloadAddr}
              	 		</c:if>
              	 	</td>
              	 	<td class="tlabel" width="13%" title="${item.group}">
              	 		${item.group}
              	 	</td>
              	 	<td class="tlabel" width="10%" title="${item.devTime}" >
              	 		${item.devTime}
              	 	</td>
              	 	<td class="tlabel" title="${item.context}">
              	 		${item.context}
              	 	</td>
              	 	<td class="tlabel"  width="13%">
              	 		<a href="javascript:deleteById('${item.id}','${item.name}','${item.newFileName}')">
              	 			<span class="fui-cross"></span>删除
              	 		</a>
              	 		&nbsp;
              	 		<c:if test="${item.fileName != null && item.fileName != '' || 
              	 		item.downloadAddr != null && item.downloadAddr != ''}">
	              	 		<a href="javascript:toDownload('${item.newFileName}','${item.fileName}','${item.downloadAddr}')">
	              	 			<span class="fui-location"></span>下载源码
	              	 		</a>
              	 		</c:if>
              	 	</td>
          		</tr>
          	</c:forEach>
         	<tr>
           		<td colspan="6">
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