<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
		div{
			padding: 15px 50px;
		}
	</style>
</head>
<body>
	 <div id="mp4">
		<video controls preload="none" width="100%" height="100%"
     		 poster="http://video-js.zencoder.com/oceans-clip.png"
     		 data-setup="{}">
	    	<source src="<%=request.getContextPath()%>/context/downloadFile?fileName=${context.context}&id=${context.id}" type='video/mp4' />
	    	<track kind="captions" src="demo.captions.vtt" srclang="en" label="English"></track>
	    	<track kind="subtitles" src="demo.captions.vtt" srclang="en" label="English"></track>
	    	<p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that 
	    	<a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
	  	</video>
	 </div>
</body>
</html>