<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="e"  uri="http://www.easytop/tag"%>
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
		
		function close(){
			$.modal.close(); 
		}
		
		$(function(){
			$("#state").selectpicker({style: 'btn-sm btn-primary', menuStyle: 'dropdown-inverse'});
		});
		
		function toAdd(){
			var url = "<%=request.getContextPath()%>/lesson/toAdd?d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
		
		function deleteById(id, name){
			if(window.confirm("确定删除此班级："+ name + "?")){
				var url = "<%=request.getContextPath()%>/lesson/deleteById?id="+ id +"&d="+new Date().getTime();
				window.location = url;
			}
		}
		
		function view(id){
			var url = "<%=request.getContextPath()%>/lesson/toView?id="+id+"&d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
		
		function viewTech(id){
			window.location = "<%=request.getContextPath()%>/lesson/viewTechs?id="+id;
		}
		
	</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/lesson/list" class="form-horizontal" method="post">
		<table style="width: 100%; height: 100%;">
			<tr class="tableBar">
				<td colspan="2" class="title">
					<span class="fui-play"></span>&nbsp;课程查询
				</td>
				<td colspan="4"  class="toolBar">
					<input type="button" class="btn btn-sm btn-info" value="添&nbsp;加" onclick="toAdd()">
					&nbsp;&nbsp;
					<input type="submit" class="btn btn-sm btn-info" value="查&nbsp;询" >
				</td>
			</tr>
			<tr  class="searchBg">
				<td width="10%" class="qlabel">
					课程名称
				</td>
				<td width="20%" >
					<input type="text" class="form-control" name="name" placeholder="请输入查询的课程名称" value="${param.name}" />
				</td>
				<td width="10%" class="qlabel">
					课程状态
				</td>
				<td width="20%" class="ttext">
					<select id="state" name="state" class="select-block">
						<option value="" <c:if test="${param.state == ''}">selected="selected"</c:if>>所有状态</option>
						<option value="1" <c:if test="${param.state == '1'}">selected="selected"</c:if>>初始</option>
						<option value="2" <c:if test="${param.state == '2'}">selected="selected"</c:if>>使用中</option>
						<option value="3" <c:if test="${param.state == '3'}">selected="selected"</c:if>>冻结</option>
					</select>
				</td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<br/>
		<table class="table table-hover" border="0">
           <thead>
             <tr>
               <th class="tlabel" width="15%">名称</th>
               <th class="tlabel" width="8%">状态</th>
               <th class="tlabel" width="15%">创建日期</th>
               <th class="tlabel" width="8%">授课次数</th>
               <th class="tlabel">课程介绍</th>
               <th class="tlabel" width="12%">周期</th>
               <th class="tlabel">操作</th>
             </tr>
          </thead>
          <tbody>
          	<c:forEach items="${lessons}" var="lesson">
          		<tr>
          			<td class="tlabel" title="${lesson.name}">${lesson.name}</td>
          			<td class="tlabel">
          				<c:if test="${lesson.state == '1'}">
          					初始
          				</c:if>
          				<c:if test="${lesson.state == '2'}">
          					使用中
          				</c:if>
          				<c:if test="${lesson.state == '3'}">
          					冻结
          				</c:if>
          			</td>
          			<td class="tlabel" title="${lesson.createTime}">
          				${lesson.createTime}
          			</td>
          			<td class="tlabel" title="${lesson.total}">
          				${lesson.total}
          			</td>
          			<td class="tlabel" title="${lesson.introduce}">
          				${lesson.introduce}
          			</td>
          			<td class="tlabel" title="${lesson.time}">
          				${lesson.time}
          			</td>
          			<td class="tlabel">
          				<c:if test="${lesson.state == '1'}">
          					<a href="<%=request.getContextPath()%>/lesson/update?id=${lesson.id}&state=2">激活</a>&nbsp;
          					<a href="javascript:deleteById('${lesson.id}','${lesson.name}')">删除</a>&nbsp;
          				</c:if>
          				<c:if test="${lesson.state == '2'}">
          					<a href="<%=request.getContextPath()%>/lesson/update?id=${lesson.id}&state=3">冻结</a>&nbsp;
          				</c:if>
          				<c:if test="${lesson.state == '3'}">
          					<a href="<%=request.getContextPath()%>/lesson/update?id=${lesson.id}&state=2">激活</a>&nbsp;
          					<a href="javascript:deleteById('${lesson.id}','${lesson.name}')">删除</a>&nbsp;
          				</c:if>
          				<a href="javascript:view('${lesson.id}')">查看</a>
          				<a href="javascript:viewTech('${lesson.id}')">课时</a>
          			</td>
          		</tr>
          	</c:forEach>
          	<tr>
           		<td colspan="7">
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