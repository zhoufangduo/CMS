package com.easytop.cms.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

public class SafetyFilter implements Filter {
	
	private final String RESOURCE = "resource";
	
	private String[] filters = {};

	@Override
	public void destroy() {
		if (filters.length > 0) {
			filters = null;
		}
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		
		String servletPath = request.getServletPath();
		
		if (isFilter(servletPath)) {
			chain.doFilter(request, response);
		}else {
			HttpSession session = request.getSession();
			if (session != null && session.getAttribute("user") != null) {
				chain.doFilter(request, response);
			}else {
				response.sendRedirect("../resource/noLogin.jsp");
			}
		}

	}

	private boolean isFilter(String servletPath) {
		
		for(String filter : filters){
			
			if (servletPath.contains(filter)) {
				return true;
			}
		}
		
		return false;
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		String resource = config.getInitParameter(RESOURCE);
		if (StringUtils.isNotEmpty(resource)) {
			this.filters = resource.split(",");
		}
	}

}
