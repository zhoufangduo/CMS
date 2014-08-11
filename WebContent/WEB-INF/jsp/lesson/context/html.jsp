<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resource/flat-ui/css/flat-ui.css" rel="stylesheet"> 
	<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/prettify.css" rel="stylesheet"> 
	<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/script/template.js"></script>
	<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shCore.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shAutoloader.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushAppleScript.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushAS3.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushBash.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushColdFusion.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushCpp.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushCSharp.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushCss.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushDelphi.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushDiff.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushErlang.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushGroovy.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushJava.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushJavaFx.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushJScript.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushPerl.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushPhp.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushPlain.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushPowerShell.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushPython.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushRuby.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushSass.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushScala.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushSql.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushVb.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/sh/scripts/shBrushXml.js"></script>
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resource/sh/styles/shCoreDefault.css"/>
	
	<style type="text/css">
		div{
			padding: 15px 50px;
			font-size: 16px;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			
			$("#"+config["${context.type}"].fileType).show();
			
			$("div").filter("[id!="+config["${context.type}"].fileType+"]").remove();
			
			SyntaxHighlighter.all();
			
		});
	</script>
</head>
<body>
	
	<div id="text" style="display: none;">${context.context}</div>
	
	<div id="java" style="display: none;">
		<pre class="brush:java">${context.context}</pre>
	</div>
	
	<div id="url" style="display: none;">
		点击&nbsp;<a href="${context.context}">跳转</a>&nbsp;至:${context.context}
	</div>
	<div id="html" style="display: none;">
		<span id="htmlCtx">
		</span>
		<script type="text/javascript">
		function readHTML(){ 
			$.ajax({ 
				async:false, 
				url : "<%=request.getContextPath()%>/context/downloadFile?fileName=${context.context}&id=${context.id}", 
				success : function(result){ 
 					$("#htmlCtx").html(result);
				} 
			}); 
		} ;
		$(function(){
			readHTML();
		});
		</script>
	</div>
	<div id="select" style="display: none;">
		考试内容:
		<c:forEach items="${papers}" var="paper">
			<c:if test="${paper.id == context.context}">
				${paper.name}
			</c:if>
		</c:forEach>
	</div>
	
	<div id="png" style="display: none;">
		<img alt="" src="<%=request.getContextPath()%>/context/downloadFile?fileName=${context.context}&id=${context.id}">
	</div>

</body>
</html>