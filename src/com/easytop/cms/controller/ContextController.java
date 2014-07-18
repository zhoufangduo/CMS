package com.easytop.cms.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
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
		super("lesson/context/");
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
				
				uploadConverFile(uploadFile, params, request);
			}
			
			params.put("creator", getUser().getName());
			
			ctxtService.add(params);
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			result = "false";
		}
		
		write("{\"result\":\""+result+"\"}");
	}

	private boolean getConverType(String type) {
		
		String converFormat = PropertyUtil.get("converFormat");
		
		if (converFormat.equals(type)) {
			return false;
		}
		
		String [] types = PropertyUtil.get("converFile").split(",");
		for(String configType : types){
			
			if (configType.equals(type)) {
				return true;
			}
		}
		
		return false;
	}

	private String converterPdf(HttpServletRequest request, String fileName) {
		File  source = new File(PathTools.getTechPath(fileName));
		File  target = new File(PathTools.getTechPath(fileName + PropertyUtil.get("converFormat")));
		OfficeConverterUtils.converter(request, source, target);
		return target.getName();
	}
	
	@RequestMapping("play")
	public String play(final ModelMap model, @RequestParam Map<String, String> params){
		
		Context context = ctxtService.viewByTechId(params);
		
		if (context != null) {
			
			model.addAttribute("context", context);
			
			String suffix = FileUtil.getFileFormat(context.getSource());
			
			if (context != null && getConverType(suffix)) {
				
				return getContext("play");
			}
			else if ("5".equals(context.getType())) {
				return getContext("media");
			}
			else if ("18".equals(context.getType())) {
				return getContext("all");
			}
			
			if ("10".equals(context.getType())) {
				model.addAttribute("papers", paperService.list(params));
			}
		}
		
		
		return getContext("html");
		
	}
	
	@RequestMapping("menu")
	public String toMenu(final ModelMap model, @RequestParam Map<String, String> params){
		
		list(model, params);
		
		return getContext("menu");
	}
	
	
	@RequestMapping("downloadFile")
	public void downloadFile(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		
		Context context = ctxtService.viewByTechId(params);
		
		String fileName = params.get("fileName");
		
		try {
			
			if (StringUtils.isNotEmpty(fileName)) {
				
				String newFileName = context.getSource();
				if (StringUtils.isNotEmpty(newFileName)) {
					newFileName = new String(newFileName.getBytes("UTF-8"), "ISO-8859-1");
				}else {
					newFileName = fileName;
				}
				
				FileUtil.downloadTechPDFFile(response, fileName, newFileName);
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
		
	}
	
	@RequestMapping("downloadSource")
	public void downloadSource(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		
		Context context = ctxtService.viewByTechId(params);
		
		try {
			
			if (context != null) {
				
				String newFileName = context.getSource();
				
				String fileName = context.getNewFileName();
				
				FileUtil.downloadTechFile(response, fileName, newFileName);
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
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
	
	@RequestMapping("view")
	public String view(final ModelMap model, @RequestParam Map<String, String> params){
		
		String id = params.get("id");
		
		if (StringUtils.isNotEmpty(id)) {
			Context context = ctxtService.viewById(params);
			
			model.put("context", context);
		}
		
		return getContext(VIEW);
	}
	
	@RequestMapping("update")
	public void update(@RequestParam("fileName") Object uploadFile,
			final ModelMap model,@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		this.setWebContext(request, response);
		
		String result  = "true";
		
		try {
			
			if (uploadFile instanceof MultipartFile ) {
				
				uploadConverFile(uploadFile, params, request);
			}
			
			ctxtService.update(params);
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			result = "false";
		}
		
		write("{\"result\":\""+result+"\"}");
	}
	
	
	@RequestMapping("hidden")
	public String hidden(final ModelMap model, @RequestParam Map<String, String> params){
		
		if (StringUtils.isNotEmpty(params.get("id"))) {
			ctxtService.hidden(params);
		}
		
		return list(model, params);
	}
	
	@RequestMapping("sort")
	public void sort(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		this.setWebContext(request, response);
		
		try {
			ctxtService.updateSort(params);
			write(TRUE);
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}

	
	private void uploadConverFile(Object uploadFile,
			Map<String, String> params, HttpServletRequest request) {
		MultipartFile file = (MultipartFile) uploadFile;
		
		String fileName = FileUtil.writeTechFile(file, file.getOriginalFilename());
		
		params.put("newFileName", new File(fileName).getName());
		
		boolean converType = getConverType(FileUtil.getFileFormat(fileName));
		
		if (converType) {
			
			String context = converterPdf(request, fileName);
			
			params.put("context", context);
			
			params.put("source", file.getOriginalFilename());
		}else {
			
			params.put("context", fileName);
			params.put("source", file.getOriginalFilename());
		}
	}

}
