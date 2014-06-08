package com.easytop.cms.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.easytop.cms.bean.Template;
import com.easytop.cms.service.TemplateService;
import com.easytop.cms.web.Page;

@Controller
@RequestMapping("template")
public class TemplateController extends BaseController {
	
	private static Logger logger = Logger.getLogger(TemplateController.class);
	
	@Autowired
	private TemplateService templateService;
	
	
	public TemplateController(){
		super("technology/template/");
	}
	
	@RequestMapping("toAdd")
	public String toAdd(){
		return getContext(ADD);
	}
	
	
	@RequestMapping("add")
	public void add(@RequestParam Map<String, String> params, HttpServletResponse response){
		
		try {
			
			setWebContext(request, response);
			
			if (params.size() > 0) {
				templateService.add(params);
			}
			
			write(TRUE);
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}
	
	
	@RequestMapping("list")
	public String list(final ModelMap model,@RequestParam Map<String, String> params){
		
		model.addAttribute("page", new Page(templateService.getTotal(params), params)) ;
		
		List<Template> templates = templateService.list(params);
		
		model.addAttribute("templates", templates);
		
		return getContext(LIST);
	}
	
	@RequestMapping("deleteById")
	public String delete(final ModelMap model,@RequestParam Map<String, String> params){
		
		String id = params.get("id");
		if (StringUtils.isNotEmpty(id)) {
			templateService.deleteById(params);
		}
		
		return list(model, params);
	}
	
}
