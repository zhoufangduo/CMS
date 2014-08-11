<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">   
	<meta http-equiv="cache-control" content="no-cache, must-revalidate"> 
	<style type="text/css">
		div{
			padding: 15px 50px;
			height: 100%;
		}
	</style>
</head>
<body>
	 <div id="mp4">
	  	 <!--[if !IE]> -->
            <video class="video-js" controls preload="auto" width="100%" height="100%" poster="images/video/poster.jpg" data-setup="{}">
              <source src="<%=request.getContextPath()%>/context/downloadSource?id=${context.id}" type="video/mp4">
              <source src="<%=request.getContextPath()%>/context/downloadSource?id=${context.id}" type="video/webm">
            </video>
          <!-- <![endif]-->

          <!--[if IE]>
            <video class="video-js" controls preload="auto" width="100%" height="100%" poster="http://video-js.zencoder.com/oceans-clip.jpg" data-setup="{}">
              <source src="<%=request.getContextPath()%>/context/downloadSource?id=${context.id}" type='video/mp4'/>
              <source src="<%=request.getContextPath()%>/context/downloadSource?id=${context.id}" type='video/webm'/>
            </video>
          <![endif]-->
	 </div>
</body>
</html>