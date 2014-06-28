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
				minWidth:845,
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
			var url = "<%=request.getContextPath()%>/context/toAdd?techId=${param.id}&d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window" style="width:828px;"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
		
		function deleteById(id){
			if(window.confirm("你确定删除内容?")){
				var url = "<%=request.getContextPath()%>/context/deleteById?id=" + id + "&techId=${param.id}";
				window.location = url;
			}
		}
		
		function toBack(){
			window.location = "<%=request.getContextPath()%>/technology/list";
		}
		
		function toPlay(){
			window.location = "<%=request.getContextPath()%>/context/play";
		}
		
	</script>
</head>
<body>
	<form action="" class="form-horizontal"  method="post">
		<table style="width: 100%; height: 100%;">
			<tr class="tableBar">
				<td colspan="2" class="title">
					<span class="fui-play"></span>&nbsp;课时内容列表
				</td>
				<td colspan="4"  class="toolBar">
					<c:if test="${contexts.size() > 0 }">
						&nbsp;&nbsp;
						<input type="button" class="btn btn-sm btn-info" value="开&nbsp;课" onclick="toPlay()">
					</c:if>
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="添&nbsp;加" onclick="toAdd()">
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="返&nbsp;回" onclick="toBack()">
				</td>
			</tr>
			<tr class="searchBg">
				
			</tr>
	    </table>
	    <br/>
		<table class="table table-hover" border="0" style="table-layout: fixed;overflow: hidden;">
            <thead>
              <tr>
                <th class="tlabel" width="8%">序列</th>
                <th class="tlabel">名称</th>
                <th class="tlabel">类型</th>
                <th class="tlabel">创建者</th>
                <th class="tlabel">创建时间</th>
                <th class="tlabel">操作</th>
             </tr>
            </thead>
            <tbody>
            	<c:forEach items="${requestScope.contexts}" var="context" varStatus="st">
            		<tr>
            			<td class="tlabel">${st.index + 1}</td>
            			<td class="tlabel">${context.name}</td>
            			<td class="tlabel">${context.tempName}</td>
            			<td class="tlabel">${context.creator}</td>
            			<td class="tlabel">${context.createTime}</td>
            			<td class="tlabel">
            				<a href="javascript:deleteById('${context.id}')">删除</a>
            				<a href="">开课</a>
            				<a href="">修改</a>
            			</td>
            		</tr>
            	</c:forEach>
            </tbody>
        </table>
	</form>
</body>
</html>