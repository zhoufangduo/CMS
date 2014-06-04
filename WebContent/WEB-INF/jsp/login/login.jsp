<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>深圳市易通软件课程教育系统登录</title>
<link href="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resource/flat-ui/css/flat-ui.css" rel="stylesheet"> 
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/html5shiv.js"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-switch.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/bootstrap-select.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-checkbox.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/flatui-radio.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.tagsinput.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.placeholder.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/jquery.stacktable.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/bootstrap/js/google-code-prettify/prettify.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resource/flat-ui/js/application.js" type="text/javascript"></script>
<link href="<%=request.getContextPath()%>/resource/css/all.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resource/css/login.css" rel="stylesheet">
<style type="text/css">
	.error{
		color: #FF0000;
		height: 30px;
		text-align: center;
	}
</style>
</head>
<body>
	<form action="<%=request.getContextPath()%>/login/toLogin" method="POST">
          <div class="login-form" style="margin-top: 18%">
         	  <div style="margin-top:-20px;" align="center">
	             <h6><span style="color: #16A085">登录信息</span></h6>
	          </div>
	          <div class="error">
	             <c:out value="${error}"></c:out>
	          </div>
	          <div class="form-group">
	             <input type="text" class="form-control login-field" id="login-name" 
	             name="username" placeholder="输入登录用户名"  value="admin" />
	             
	             <label class="login-field-icon fui-user" for="login-name">
	            	<span class="input_label">用户名</span>
	             </label>
	          </div>
	          <div class="form-group">
	             <input type="password" class="form-control login-field" id="login-pass" 
	             name="password" placeholder="输入用户名密码" value="123456"   />
	             
	             <label class="login-field-icon fui-lock" for="login-pass">
	             	<span class="input_label">密码</span>
	             </label>
	          </div>
			  <input type="submit" class="btn btn-primary btn-lg btn-block" value="登 录">
	          <a class="login-link" href="#">忘记密码?</a>
         </div>
	</form>
	
	<div class="pub_footer">
        <dl>
   			<dd class="backblue"><a target="_blank" href="http://www.csdn.net/company/about.html">学校简介</a>|
	   			<a target="_blank" href="http://www.csdn.net/company/recruit.html">招贤纳士</a>|
	   			<a target="_blank" href="http://www.csdn.net/company/marketing.html">广告服务</a>|
	   			<a target="_blank" href="http://www.csdn.net/company/account.html">银行汇款帐号</a>|
	   			<a target="_blank" href="http://www.csdn.net/company/contact.html">联系方式</a>|
	   			<a target="_blank" href="http://www.csdn.net/company/statement.html">版权声明</a>|
	   			<a target="_blank" href="http://www.csdn.net/company/layer.html">法律顾问</a>|
	   			<a onclick="window.location.href='mai'+'lto:'+'webma'+'ster@c'+'sdn.n'+'et?subject=Report To CSDN';return false" href="#">问题报告</a>|
	   			<a target="_blank" href="http://www.csdn.net/friendlink.html">合作伙伴</a>|
	   			<a target="_blank" href="http://bbs.csdn.net/forums/Service">论坛反馈</a>
	   		</dd>
   		    <dd>
   				<a class="qq" target="_blank" href="http://wpa.qq.com/msgrd?v=3&amp;uin=2355263776&amp;site=qq&amp;menu=yes">网站客服</a>
   				<a class="qq" target="_blank" href="http://wpa.qq.com/msgrd?v=3&amp;uin=2251809102&amp;site=qq&amp;menu=yes">杂志客服</a>
   				<a class="weibo" target="_blank" href="http://e.weibo.com/csdnsupport/profile">微博客服</a>
			    <a title="联系邮箱" class="email" href="mailto:webmaster@csdn.net">samlinzhang@gmail.com</a>
			    <span title="服务热线" class="phone">0755-85279062</span>
   			</dd>
   			<dd>
   				<a target="_blank" href="http://www.miibeian.gov.cn/">京ICP证070598号</a>&#12288;京公网安备号：110105000969
   			</dd>
   			<dd>
   				<a href="http://www.csdn.net/company/icp.html">电信业务审批[2007]字第380号</a>&#12288;
   				<a href="http://www.csdn.net/company/pifu.html">电信与信息服务业务经营许可证070598号</a>
   			</dd>
   			<dd>深圳市易通软件教育 版权所有</dd>
   			<dd>深圳市东方教育集团 提供商务支持</dd>
   			<dd class="small">Copyright &copy; 1998-2014, CSDN.NET, All Rights Reserved</dd>
  		 </dl>
     </div>
</body>
</html>