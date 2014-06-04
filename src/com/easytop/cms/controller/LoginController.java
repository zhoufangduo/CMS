package com.easytop.cms.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.easytop.cms.bean.User;
import com.easytop.cms.service.LoginServcie;

@Controller
@RequestMapping("/login/*")
public class LoginController extends BaseController{

	@Autowired
	private LoginServcie loginServcie;

	@RequestMapping("login")
	public String login() {
		return "login/login";
	}
	
	@RequestMapping("toLogin")
	public String toLogin(final ModelMap model, @RequestParam Map<String,String> params,HttpServletRequest request){
		
		this.setWebContext(request, null);
		
		User user = loginServcie.login(params);

		if (user == null) {
			model.addAttribute("error", getText("login.error"));
			return "login/login";
		}
		
		this.session.setAttribute("user", user);
		this.session.setAttribute("userPower", loginServcie.getLoginUserPower(user.getRoleType()));
		
		return "welcome/index";
	}

	@RequestMapping("logout")
	public String logout(final ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		this.setWebContext(request, response);
		
		this.session.removeAttribute("user");
		
		return "login/login";
	}
}
