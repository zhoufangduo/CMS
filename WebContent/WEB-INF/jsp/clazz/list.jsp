<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		
		function close(){
			$.modal.close(); 
		}
		
		$(function(){
			$("#teacher").selectpicker({style: 'btn-sm btn-primary', menuStyle: 'dropdown-inverse'});
			$("#state").selectpicker({style: 'btn-sm btn-primary', menuStyle: 'dropdown-inverse'});
		});
		
		function toAdd(){
			var url = "<%=request.getContextPath()%>/clazz/toAdd?d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
		
		function deleteById(id, name){
			if(window.confirm("确定删除此班级："+ name + "?")){
				var url = "<%=request.getContextPath()%>/clazz/deleteById?id="+ id +"&d="+new Date().getTime();
				window.location = url;
			}
		}
		
		function toView(id){
			var url = "<%=request.getContextPath()%>/clazz/view?id="+id+"&d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window"  id="viewClazz" src="'+ url +'"></div>').modal(option);
		}
		
	</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/clazz/list" class="form-horizontal" method="post" id="queryForm">
		<table style="width: 100%; height: 100%;">
			<tr class="tableBar">
				<td colspan="2" class="title">
					<span class="fui-play"></span>&nbsp;班级查询
				</td>
				<td colspan="4"  class="toolBar">
					<input type="button" class="btn btn-sm btn-info" value="添&nbsp;加" onclick="toAdd()">
					&nbsp;&nbsp;
					<input type="submit" class="btn btn-sm btn-info" value="查&nbsp;询" >
				</td>
			</tr>
			<tr class="searchBg">
				<td width="10%" class="qlabel">
					授课老师
				</td>
				<td width="20%"  class="ttext" >
					<select id="teacher" name="teacher" class="select-block">
						<option value="" <c:if test="${param.teacher == ''}">selected="selected"</c:if>>所有教师</option>
						<c:forEach items="${teachers}" var="teacher">
							<option value="${teacher.username}" 
								<c:if test="${param.teacher == teacher.username}">selected="selected"</c:if>>
								${teacher.name}
							</option>
						</c:forEach>
					</select>
				</td>
				<td width="10%" class="qlabel">
					班级名称
				</td>
				<td width="20%" >
					<input type="text" class="form-control" name="name" placeholder="请输入查询的班级名称" value="${param.name}" />
				</td>
				<td width="10%" class="qlabel">
					班级状态
				</td>
				<td width="20%" class="ttext">
					<select id="state" name="state" class="select-block">
						<option value="" <c:if test="${param.state == ''}">selected="selected"</c:if>>所有状态</option>
						<option value="1" <c:if test="${param.state == '1'}">selected="selected"</c:if>>初学</option>
						<option value="2" <c:if test="${param.state == '2'}">selected="selected"</c:if>>开学</option>
						<option value="3" <c:if test="${param.state == '3'}">selected="selected"</c:if>>毕业</option>
					</select>
				</td>
			</tr>
	    </table>
	    
	    <br/>
		<table class="table table-hover" border="0">
           <thead>
             <tr>
               <th class="tlabel" width="15%">班级名称</th>
               <th class="tlabel" width="10%">授课老师</th>
               <th class="tlabel" width="8%">状态</th>
               <th class="tlabel" width="15%">开始时间</th>
               <th class="tlabel" width="15%">结束时间</th>
               <th class="tlabel">操作</th>
             </tr>
          </thead>
          <tbody>
          	<c:forEach items="${requestScope.clazzs}" var="clazz">
          		<tr>
          			<td class="tlabel" title="${clazz.name}">
              	 		${clazz.name}
              	 	</td>
              	 	<td class="tlabel" title="${clazz.teacher}">
              	 		${clazz.teacher}
              	 	</td>
              	 	<td class="tlabel">
              	 		<c:if test="${clazz.state == '1'}">
              	 			初学
              	 		</c:if>
              	 		<c:if test="${clazz.state == '2'}">
              	 			开学
              	 		</c:if>
              	 		<c:if test="${clazz.state == '3'}">
              	 			毕业
              	 		</c:if>
              	 	</td>
              	 	<td class="tlabel" title="${clazz.startDate}">
              	 		${clazz.startDate}
              	 	</td>
              	 	<td class="tlabel" title="${clazz.endDate}">
              	 		${clazz.endDate}
              	 	</td>
              	 	<td class="tlabel">
              	 		<a href="javascript:deleteById('${clazz.id}','${clazz.name}')"><span class="fui-cross"></span>删除</a>
              	 		&nbsp;
				            <a href="javascript:toView('${clazz.id}')"><span class="fui-new"></span>查看</a>
				        &nbsp;
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