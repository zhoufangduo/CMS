package com.easytop.cms.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.easytop.cms.service.TemplateService;

@Controller
@RequestMapping("context")
public class ContextController extends BaseController {
	
	@Autowired
	private TemplateService templateService;
	
	public ContextController(){
		super("technology/context/");
	}
	
	@RequestMapping("list")
	public String list(final ModelMap model, @RequestParam Map<String, String> params){
		
		return getContext(LIST);
	}
	
	@RequestMapping("toAdd")
	public String toAdd(final ModelMap model, @RequestParam Map<String, String> params){
		
		model.addAttribute("templates", templateService.list(params));
		return getContext(ADD);
	}

}
