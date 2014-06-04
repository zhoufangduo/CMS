<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="e" uri="http://www.easytop/tag" %>
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
			
			function toAdd(){
				var url = "<%=request.getContextPath()%>/user/toAdd?d="+new Date().getTime();
				$('<div id="basic-modal-content"><iframe class="window"  id="addUser" src="'+ url +'"></div>').modal(option);
			}
			
			function deleteById(username){
				var url = "<%=request.getContextPath()%>/user/deleteById?d="+new Date().getTime();
				if(window.confirm("确定删除该用户:"+ username +"?")){
					$.post(url,{'username':username},function(data){
						if(data.result){
							parent.mainFrame.location.reload();
							parent.menuFrame.location.reload();
						}else{
							alert("出现异常，请联系管理员!");
						}
					},"json");
				}
			}
			
			function toView(username,isView){
				var url  = '<%=request.getContextPath()%>/user/toView?username='+ username +"&isView="+ isView +"&d="+new Date();
				$('<div id="basic-modal-content"><iframe class="window" id="viewUser" src="'+ url +'"></div>').modal(option);
			}
			
			function deleSelect(){
				var checkboxs = $("input:checked");
				if(checkboxs.length == 0){
					alert("请选择删除的用户");
					return ;
				}
				
				var delIds = "";
				for(var i = 0 ;i < checkboxs.length; i ++){
					var val = $(checkboxs[i]).val();
					if(val != "all"){
						delIds += (val+",");
					}
				}
				
				window.location = "<%=request.getContextPath()%>/user/deleteSelect?ids="+delIds;
				
			}
			
			function close(){
				$.modal.close(); 
			}
			
			$(function(){
				$("#roleType").selectpicker({style: 'btn-sm btn-primary', menuStyle: 'dropdown-inverse'});
				$("#teacher").selectpicker({style: 'btn-sm btn-primary', menuStyle: 'dropdown-inverse'});
				$("#classNo").selectpicker({style: 'btn-sm btn-primary', menuStyle: 'dropdown-inverse'});
				$("#uploadForm").hide();
				$("#excelFile").hide();
			});
			
			function toImport(){
				option.maxHeight = 213;
				option.maxWidth = 400;
				$('#uploadForm').modal(option);
			}
			
			function toUpload(){
				
				var excel = $("#excelFile").val();
				excel = excel.substring(excel.lastIndexOf(".")+1); 
				if(excel != "xls"){
					$("#error").html($("#excelFile").val() + "&nbsp;文件格式不对,例如:用户信息.xls");
					return false;
				}
				 
				$("#uploadForm").submit();
			}
			
		</script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/user/list" class="form-horizontal" id="queryForm">
		<table style="width: 100%; height: 100%;" >
			<tr class="tableBar">
				<td colspan="2" class="title">
					<span class="fui-play"></span>&nbsp;用户信息查询
				</td>
				<td colspan="4"  class="toolBar">
					<input type="submit" class="btn btn-sm btn-info" value="查&nbsp;询" >
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="添&nbsp;加" onclick="toAdd()">
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="删除" onclick="deleSelect()">
					&nbsp;&nbsp;
					<input type="button" class="btn btn-sm btn-info" value="批量导入" onclick="toImport()">
				</td>
			</tr>
			<tr class="searchBg">
				<td width="10%" class="qlabel">
					用户名
				</td>
				<td width="20%" >
					<input type="text" class="form-control" name="username" placeholder="请输入查询的用户名" value="${param.username}" />
				</td>
				<td width="10%" class="qlabel">
					姓名
				</td>
				<td width="20%" >
					<input type="text" class="form-control" name="name" placeholder="请输入查询的用户姓名" value="${param.name}" />
				</td>
				<td width="10%" class="qlabel">
					班级
				</td>
				<td width="20%" class="ttext">
					<select id="classNo" name="classNo" class="select-block">
						<option value="" <c:if test="${param.teacher == ''}">selected="selected"</c:if>>所有班级</option>
						<c:forEach items="${clazzs}" var="clazz">
							<option value="${clazz.id}" <c:if test="${param.classNo == clazz.id}">selected="selected"</c:if>>
								${clazz.name}
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr class="searchBg">
				<td width="10%" class="qlabel">
					角色
				</td>
				<td width="20%"  class="ttext" >
					<select id="roleType" class="select-block" name="roleType">
						<option value="" <c:if test="${param.roleType ==''}">selected="selected"</c:if>>所有角色</option>
						<option value="ADMIN" <c:if test="${param.roleType =='ADMIN'}">selected="selected"</c:if>>管理员</option>
						<option value="TEACHER" <c:if test="${param.roleType =='TEACHER'}">selected="selected"</c:if>>教师</option>
						<option value="STUDENT" <c:if test="${param.roleType =='STUDENT'}">selected="selected"</c:if>>学生</option>
					</select>
				</td>
				<td width="10%" class="tlabel">
				</td>
				<td width="20%"  class="ttext" >
					
				</td>
				<td width="10%" class="tlabel">
					
				</td>
				<td width="20%"  class="ttext" >
					
				</td>
			</tr>
	    </table>
		<br/>
		<table class="table table-hover" border="0">
            <thead>
              <tr>
                <th width="1%">
                	  <label class="checkbox" for="checkbox1">
	            	 	 <input type="checkbox" id="checkbox1" onchange="selectAll(this)" data-toggle="checkbox"/>
	          		  </label>
                </th>
                <th class="tlabel" width="8%">用户名</th>
                <th class="tlabel" width="8%">姓名</th>
                <th class="tlabel" width="5%">性别</th>
                <th class="tlabel" width="9%">班级</th>
                <th class="tlabel" width="9%">权限角色</th>
                <th class="tlabel" width="9%">手机号码</th>
                <th class="tlabel" width="14%">创建时间</th>
                <th class="tlabel" width="6%">状态</th>
                <th class="tlabel" width="16%">操作</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${requestScope.users}" var="user">
              	 <tr ondblclick="toView('${user.username}')" >
              	 	<td>
	              	 	<c:if test="${user.username != sessionScope.user.username}">
	                  	  <label class="checkbox" for="checkbox1">
				             <input type="checkbox" value="${user.username}" data-toggle="checkbox">
				          </label>
					    </c:if>
              	 	</td>
              	 	<td class="tlabel" title="${user.username}">
              	 		${user.username}
              	 	</td>
              	 	<td class="tlabel" title="${user.name}">
              	 		${user.name}
              	 	</td>
              	 	<td class="tlabel">
              	 		<c:choose>
              	 			<c:when test="${user.sex == 'MALE'}">男</c:when>
              	 			<c:when test="${user.sex == 'FEMALE'}">女</c:when>
              	 			<c:otherwise>保密</c:otherwise>
              	 		</c:choose>
              	 	</td>
              	 	<td class="tlabel">
              	 		<c:forEach items="${clazzs}" var="clazz">
							<c:if test="${user.classNo == clazz.id}">
								${clazz.name}
							</c:if>
						</c:forEach>
              	 	</td>
              	 	<td class="tlabel">
              	 		<c:choose>
              	 			<c:when test="${user.roleType == 'STUDENT'}">学生</c:when>
              	 			<c:when test="${user.roleType == 'TEACHER'}">老师</c:when>
              	 			<c:when test="${user.roleType == 'ADMIN'}">管理员</c:when>
              	 			<c:otherwise>未知</c:otherwise>
              	 		</c:choose>
              	 	</td>
              	 	<td class="tlabel" title="${user.mobile}">
              	 		${user.mobile}
              	 	</td>
              	 	<td class="tlabel" title="${user.createtime}">
              	 		${user.createtime}
              	 	</td>
              	 	<td class="tlabel">
              	 		<c:choose>
              	 			<c:when test="${user.state == '0'}">初始</c:when>
              	 			<c:when test="${user.state == '1'}">正常</c:when>
              	 			<c:when test="${user.state == '2'}">冻结</c:when>
              	 			<c:otherwise>未知</c:otherwise>
              	 		</c:choose>
              	 	</td>
              	 	<td class="tlabel">
              	 		<c:choose>
              	 			<c:when test="${user.username == sessionScope.user.username}">
              	 				&nbsp;
			                   		<a href="javascript:toView('${user.username}',true)"><span class="fui-new"></span>详情</a>
			                	&nbsp;
              	 			</c:when>
              	 			<c:otherwise>
              	 				<a href="javascript:deleteById('${user.username}')"><span class="fui-cross"></span>删除</a>
					            <c:if test="${user.state == 1}">
				                  	&nbsp;
				                    <a href="javascript:toView('${user.username}',false)"><span class="fui-new"></span>修改</a>
					            </c:if>
              	 			</c:otherwise>
              	 		</c:choose>
              	 	</td>
              	 </tr>
              	</c:forEach>
              	<tr>
              		<td colspan="10">
              			<div class="pageBar">
				        	 <e:page page="${page}" formId="queryForm"></e:page>
				        </div>
              		</td>
              	</tr>
              </tbody>
         </table>
	</form>
	
	<form action="<%=request.getContextPath()%>/user/upload" id="uploadForm" method="POST" enctype="multipart/form-data">
		<div  class="tile">
			<div class="bs-docs-example">
	            <div class="alert alert-info">
	               <strong>温馨提示!</strong>&nbsp;先下载Excel模版，填入用户信息之后，再上传该Excel文件
	             </div>
         	</div>
			<input type="file"  name="excelFile" id="excelFile" onchange="toUpload()">
			<input type="button" class="btn btn-lg btn-success" value="上传文件" onclick="$('#excelFile').click()">
			&nbsp;&nbsp;&nbsp;
			<input type="button" class="btn btn-lg btn-success" value="下载模版" onclick="window.location = '<%=request.getContextPath()%>/user/download'">
			<br/>&nbsp;
			<span id="error" style="color: red;height: 10px;">
			</span>
		</div>
	</form>
</body>
</html>