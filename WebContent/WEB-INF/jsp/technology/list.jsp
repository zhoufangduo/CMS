<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
				minWidth:890,
				escClose: true, 
				autoResize: true,
				onClose:function(){
					window.location.reload();
					window.parent.menuFrame.document.location.reload();
				}
		};
		$(function(){
			$("#state").selectpicker({style: 'btn-sm btn-primary', menuStyle: 'dropdown-inverse'});
		});
		
		function close(){
			$.modal.close(); 
		}
		
		function toAdd(){
			var url = "<%=request.getContextPath()%>/technology/toAdd?d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window" style="width:872px;"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
		
		function selectAll(obj){
			var check = $(obj).attr("checked");
			
			if(check =="checked"){
				check = "check";
			}else{
				check = "uncheck";
			}
			
			var checkboxs = $(":checkbox");
			for(var i = 1;i < checkboxs.length; i ++){
				var checkbox = checkboxs[i];
				$(checkbox).checkbox(check);
			}
		}
		
		function toDelete(id, name, video, doc){
			if(window.confirm("你确定需要删除此课时:"+name+"?")){
				window.location = "<%=request.getContextPath()%>/technology/deleteById?id="+id+"&video="+video+"&doc="+doc;
			}
		}
		
		function toView(id){
			var url = "<%=request.getContextPath()%>/technology/toView?id="+id+"&d="+new Date().getTime();
			$('<div id="basic-modal-content"><iframe class="window" style="width:872px;"  id="addClazz" src="'+ url +'"></div>').modal(option);
		}
	</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/technology/list" class="form-horizontal"  method="post">
		<table style="width: 100%; height: 100%;">
			<tr class="tableBar">
				<td colspan="2" class="title">
					<span class="fui-play"></span>&nbsp;课时查询
				</td>
				<td colspan="4"  class="toolBar">
					<input type="button" class="btn btn-sm btn-info" value="添&nbsp;加" onclick="toAdd()">
					&nbsp;&nbsp;
					<input type="submit" class="btn btn-sm btn-info" value="查&nbsp;询" >
				</td>
			</tr>
			<tr class="searchBg">
				<td width="10%" class="qlabel">
					课时名称
				</td>
				<td width="20%" >
					<input type="text" class="form-control" name="name" placeholder="请输入查询的班级名称" value="${param.name}" />
				</td>
				<td width="10%" class="qlabel">
					相关知识点
				</td>
				<td width="20%" >
					<input type="text" class="form-control" name="knowledge" placeholder="请输入查询的班级名称" value="${param.name}" />
				</td>
				<td width="10%" class="qlabel">
					状态
				</td>
				<td width="20%" class="ttext">
					<select id="state" name="state" >
						<option value="" <c:if test="${param.state == ''}">selected="selected"</c:if>>所有状态</option>
						<option value="1" <c:if test="${param.state == '1'}">selected="selected"</c:if>>初始</option>
						<option value="2" <c:if test="${param.state == '2'}">selected="selected"</c:if>>使用中</option>
						<option value="3" <c:if test="${param.state == '3'}">selected="selected"</c:if>>冻结</option>
					</select>
				</td>
			</tr>
	    </table>
	    <br/>
		<table class="table table-hover" border="0" style="table-layout: fixed;overflow: hidden;">
            <thead>
              <tr>
                <th width="4%">
                	<label class="checkbox" for="checkbox1">
	             		<input type="checkbox" id="checkbox1" onchange="selectAll(this)" data-toggle="checkbox"/>
	         	 	</label>
                </th>
                <th class="tlabel" width="12%">名称</th>
                <th class="tlabel" width="12%">相关视频</th>
                <th class="tlabel" width="12%">相关的文档</th>
                <th class="tlabel" width="12%">知识点</th>
                <th class="tlabel" width="15%">练习</th>
                <th class="tlabel" width="14%">测试</th>
                <th class="tlabel" width="6%">状态</th>
                <th class="tlabel" >操作</th>
             </tr>
            </thead>
            <tbody>
            	<c:forEach items="${requestScope.technologies}" var="tech">
            		<tr>
            			<td width="4%">
		                	  <label class="checkbox" for="checkbox2">
			            	 	 <input type="checkbox" id="checkbox2" data-toggle="checkbox"/>
			          		  </label>
		                </td>
            			<td class="tlabel" title="${tech.name}">${tech.name}</td>
            			<td class="tlabel">
            				<c:if test="${tech.videoFile != null && tech.videoFile != ''}">
            					<a href="<%=request.getContextPath()%>/technology/download?newFileName=${tech.videoNewFile}&fileName=${tech.videoFile}">下载视频</a>&nbsp;
            				</c:if>
            				<c:if test="${tech.videoAddr != null && tech.videoAddr != ''}">
            					<a href="${tech.videoAddr}" title="${tech.videoAddr}">跳转至下载</a>&nbsp;
            				</c:if>
            			</td>
            			<td class="tlabel">
            				<c:if test="${tech.docFile != null && tech.docFile != ''}">
            					<a href="<%=request.getContextPath()%>/technology/download?newFileName=${tech.docNewFile}&fileName=${tech.docFile}">下载文档</a>&nbsp;
            				</c:if>
            				<c:if test="${tech.docAddr != null && tech.docAddr != ''}">
            					<a href="${tech.docAddr}" title="${tech.docAddr}">跳转至下载</a>&nbsp;
            				</c:if>
            			</td>
            			<td class="tlabel" title="${tech.knowledge}">${tech.knowledge}</td>
            			<td class="tlabel" title="${tech.exercise}">${tech.exercise}</td>
            			<td class="tlabel" title="${tech.test}">${tech.test}</td>
            			<td class="tlabel">
            				<c:if test="${tech.state == '1'}">
            					初始
            				</c:if>
            				<c:if test="${tech.state == '2'}">
            					使用中
            				</c:if>
            				<c:if test="${tech.state == '3'}">
            					冻结
            				</c:if>
            			</td>
            			<td class="tlabel">
            				<c:if test="${tech.state == '1'}">
	           					<a href="javascript:toDelete('${tech.id}','${tech.name}',
	           					'${tech.videoNewFile}','${tech.docNewFile}')">删除 </a>
	           					
	           					<a href="javascript:toView('${tech.id}')">查看 </a>
	           					
	           					<a href="<%=request.getContextPath()%>/technology/setState?id=${tech.id}&state=2">激活 </a>
            				</c:if>
            				<c:if test="${tech.state == '2'}">
            					<a href="<%=request.getContextPath()%>/technology/setState?id=${tech.id}&state=3">冻结</a>
            				</c:if>
            				<c:if test="${tech.state == '3'}">
            					<a href="javascript:toDelete('${tech.id}','${tech.name}',
	           					'${tech.videoNewFile}','${tech.docNewFile}')">删除 </a>
	           					
            					<a href="<%=request.getContextPath()%>/technology/setState?id=${tech.id}&state=2">激活 </a>
            				</c:if>
            			</td>
            		</tr>
            	</c:forEach>
            	<tr>
	           		<td colspan="9">
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