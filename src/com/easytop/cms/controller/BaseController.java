package com.easytop.cms.controller;


import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.support.RequestContext;

import com.easytop.cms.bean.User;

public abstract class BaseController {
	
	protected HttpServletRequest request;
	
	protected HttpServletResponse response;
	
	protected HttpSession session ;
	
	protected ServletContext context;
	
	protected final String ADD = "add";
	
	protected final String VIEW = "view";
	
	protected final String LIST = "list";
	
	protected final String UPDATE = "update";
	
	protected final String SUCCESS = "success";
	
	protected final String TRUE = "{\"result\":true}";
	
	protected final String FALSE = "{\"result\":false}";
	
	protected String dirPath ;
	
	protected BaseController(String dirPath ){
		this.dirPath = dirPath;
	}
	
	protected BaseController(){
		
	}
	
	protected String getContext(String jspName){
		return dirPath + jspName;
	}
	
	
	public void setWebContext(HttpServletRequest request, HttpServletResponse response){
		this.request = request;
		this.response = response;
		
		if (request != null) {
			this.session = request.getSession();
			this.context = this.session.getServletContext();
		}
	} 
	

	public String getText(String key) {
		RequestContext requestContext = new RequestContext(request);
		return requestContext.getMessage(key);
	}
	
	
	public String getText(String key, HttpServletRequest request) {
		RequestContext requestContext = new RequestContext(request);
		return requestContext.getMessage(key);
	}
	
	public void write(String json){
		try {
			
			response.reset();
			
			response.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public User getUser(){
		if (session != null) {
			return (User) session.getAttribute("user");
		}
		
		return new User();
	}
}
