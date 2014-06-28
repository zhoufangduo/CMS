package com.easytop.cms.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
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
import com.easytop.cms.utils.PathTools;
import com.easytop.cms.utils.PropertyUtil;
import com.easytop.cms.utils.converter.HtmlConverterUtils;
import com.easytop.cms.utils.converter.OfficeConverterUtils;

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
		
		String result  = "true";
		
		try {
			
			if (uploadFile instanceof MultipartFile ) {
				
				MultipartFile file = (MultipartFile) uploadFile;
				
				String fileName = FileUtil.writeTechFile(file, file.getOriginalFilename());
				
				String context = converterHtml(request, fileName);
				
				params.put("context", context);
				params.put("source", fileName);
			}
			
			params.put("creator", getUser().getName());
			ctxtService.add(params);
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			result = "false";
		}
		
		write("{\"result\":\""+result+"\"}");
	}

	private String converterHtml(HttpServletRequest request, String fileName) {
		File target = converterPdf(request, fileName);
		
		String targetDir = PathTools.getTechPath(fileName) + File.separator;
		
		HtmlConverterUtils.converter(target.getPath(), targetDir);
		
		return targetDir;
	}

	private File converterPdf(HttpServletRequest request, String fileName) {
		File  source = new File(PathTools.getTechPath(fileName));
		File  target = new File(PathTools.getTechPath(fileName + PropertyUtil.get("converFormat")));
		OfficeConverterUtils.converter(request, source, target);
		return target;
	}
	
	@RequestMapping("play")
	public String play(final ModelMap model, @RequestParam Map<String, String> params){
		
		List<Context> contexts = ctxtService.list(params);
		
		model.addAttribute("contexts", contexts);
		
		return getContext("play");
	}
	
	@RequestMapping("downloadFile")
	public void downloadFile(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		String fileName = params.get("fileName");
		if (StringUtils.isNotEmpty(fileName)) {
			
			FileUtil.downloadTechFile(response, fileName, fileName);
		}

	}
	
	@RequestMapping("deleteById")
	public String deleteById(final ModelMap model, @RequestParam Map<String, String> params){
		
		String id = params.get("id");
		if (StringUtils.isNotEmpty(id)) {
			
			ctxtService.deleteById(params);
			
		}
		
		return list(model, params);
	}

}
