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
		
		function toExamList(id){
			window.location = "<%=request.getContextPath()%>/questions/examList?paperId="+id;
		}
		
	</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/paper/examList" class="form-horizontal" method="post">
		<table style="width: 100%; height: 100%;">
			<tr class="tableBar">
				<td colspan="2" class="title">
					<span class="fui-play"></span>&nbsp;试卷管理查询
				</td>
				<td colspan="4"  class="toolBar">
					<input type="submit" class="btn btn-sm btn-info" value="查&nbsp;询" >
				</td>
			</tr>
			<tr class="searchBg">
				<td width="10%" class="qlabel">
					试卷名称
				</td>
				<td width="20%" class="ttext" style="padding: 10px;" >
					<input type="text" class="form-control" name="name" placeholder="请输入查询的试卷名称支持模糊查询" value="${param.name}" style="width: 400px;" />
				</td>
				<td width="10%" class="qlabel">
					&nbsp;
				</td>
				<td width="20%" class="qlabel" >
					&nbsp;
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
	    </table>
	    <br/>
		<table class="table table-hover" border="0">
           <thead>
             <tr>
               <th class="tlabel" width="6%">序列ID</th>
               <th class="tlabel">试卷名称</th>
               <th class="tlabel" width="12%">考试时长</th>
               <th class="tlabel" width="10%" >试题个数</th>
               <th class="tlabel" width="18%">创建时间</th>
               <th class="tlabel" width="10%">考试得分</th>
               <th class="tlabel" width="22%">操作</th>
             </tr>
          </thead>
          <tbody>
          	<c:forEach items="${requestScope.papers}" var="paper" varStatus="st">
          		<tr>
          			<td class="tlabel">
              	 		${st.index + 1}
              	 	</td>
              	 	<td class="tlabel" title="${paper.name}">
              	 		${paper.name}
              	 	</td>
              	 	<td class="tlabel" title="${paper.time}">
              	 		<c:choose>
              	 			<c:when test="${paper.time == '00:00:00' }">不限</c:when>
              	 			<c:otherwise>
		              	 		${paper.time}
              	 			</c:otherwise>
              	 		</c:choose>
              	 	</td>
              	 	<td class="tlabel" title="${paper.qstionsTotal}">
              	 		${paper.qstionsTotal}
              	 	</td>
              	 	<td class="tlabel" title="${paper.createTime}">
              	 		${paper.createTime}
              	 	</td>
              	 	<td class="tlabel" title="">
              	 		
              	 	</td>
              	 	<td class="tlabel">
				         <a href="javascript:toExamList('${paper.id}')"><span class="fui-new"></span>&nbsp;前往考试</a>
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