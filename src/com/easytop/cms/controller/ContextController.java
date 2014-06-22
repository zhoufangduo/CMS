package com.easytop.cms.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.easytop.cms.bean.Context;
import com.easytop.cms.service.ContextService;
import com.easytop.cms.service.ItemService;
import com.easytop.cms.service.PaperService;
import com.easytop.cms.service.TemplateService;
import com.easytop.cms.utils.FileUtil;

@Controller
@RequestMapping("context")
public class ContextController extends BaseController {
	
	private static Logger logger = Logger.getLogger(ContextController.class);
	
	@Autowired
	private TemplateService templateService;
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private PaperService paperService;
	
	@Autowired
	private ContextService ctxtService;
	
	public ContextController(){
		super("technology/context/");
	}
	
	@RequestMapping("list")
	public String list(final ModelMap model, @RequestParam Map<String, String> params){
		
		List<Context> contexts = ctxtService.list(params);
		
		model.addAttribute("contexts", contexts);
		
		return getContext(LIST);
	}
	
	@RequestMapping("toAdd")
	public String toAdd(final ModelMap model, @RequestParam Map<String, String> params){
		
		model.addAttribute("templates", templateService.list(params));
		model.addAttribute("papers", paperService.list(params));
		return getContext(ADD);
	}
	
	@RequestMapping("add")
	public void add(@RequestParam("fileName") Object uploadFile,
			final ModelMap model,@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		this.setWebContext(request, response);
		
		try {
			
			if (uploadFile instanceof MultipartFile ) {
				
				MultipartFile file = (MultipartFile) uploadFile;
				
				String fileName = FileUtil.getUploadNewFile(file.getOriginalFilename());
				FileUtil.writeTechFile(file, fileName);
				
				params.put("creator", getUser().getName());
				params.put("context", fileName);
			}
			
			ctxtService.add(params);
			
			
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
		
		write("{\"result\":\"0\"}");
	}

}
