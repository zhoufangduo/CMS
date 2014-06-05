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
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.easytop.cms.bean.Technology;
import com.easytop.cms.service.ItemService;
import com.easytop.cms.service.PaperService;
import com.easytop.cms.service.TechnologyService;
import com.easytop.cms.utils.FileUtil;
import com.easytop.cms.web.Page;

@Controller
@RequestMapping("/technology/*")
public class TechnologyController extends BaseController {
	
	private static Logger logger = Logger.getLogger(TechnologyController.class);
	
	@Autowired
	private TechnologyService technologyService;
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private PaperService paperService;
	
	public TechnologyController(){
		super("technology/");
	}
	
	@RequestMapping("toAdd")
	public String toAdd(final ModelMap model, @RequestParam Map<String, String> params){
		model.addAttribute("technologies", technologyService.list(params));
		return getContext(ADD);
	}
	
	@RequestMapping("add")
	public void add(@RequestParam Map<String, String> params, HttpServletResponse response){
			
		this.setWebContext(request, response);
		
		try {
			
			if (params.size() > 0) {
				technologyService.add(params);
				write(TRUE);
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
		
	}
	
	@RequestMapping("update")
	public void update(@RequestParam Map<String, String> params, HttpServletResponse response){
		
		this.setWebContext(request, response);
		
		try {
			
			if (params.size() > 0) {
				
				technologyService.update(params);
				write(TRUE);
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
		
	}

	private void uploadDocFile(Map<String, String> params, Object object) {
		
		CommonsMultipartFile file = null;
		
		if (object instanceof CommonsMultipartFile ) {
			file = (CommonsMultipartFile) object;
		}
		
		if (file != null && file.getSize() > 0) {
			String fileName = file.getOriginalFilename();
			String newFileName = FileUtil.writeTechFile(file,fileName);
			params.put("docFile", fileName);
			params.put("docNewFile", newFileName);
		}
		
	}

	private void uploadVideo(Map<String, String> params, Object object) {
		
		CommonsMultipartFile file = null;
		
		if (object instanceof CommonsMultipartFile ) {
			file = (CommonsMultipartFile) object;
		}
		
		if (file != null && file.getSize() > 0) {
			String fileName = file.getOriginalFilename();
			String newFileName = FileUtil.writeTechFile(file,fileName);
			params.put("videoFile", fileName);
			params.put("videoNewFile", newFileName);
		}
	}
	
	@RequestMapping("list")
	public String list(final ModelMap model,@RequestParam Map<String, String> params){
		
		model.addAttribute("page", new Page(technologyService.getTotal(params), params)) ;
		
		List<Technology> technologies = technologyService.list(params);
		
		model.addAttribute("technologies", technologies);
		
		return getContext(LIST);
	}
	
	@RequestMapping("deleteById")
	public String deleteById(final ModelMap model,@RequestParam Map<String, String> params){
		
		String video =  params.get("video");
		if (StringUtils.isNotEmpty(video)) {
			FileUtil.deleteTechFile(video);
		}
		
		String doc = params.get("doc");
		if (StringUtils.isNotEmpty(doc)) {
			FileUtil.deleteTechFile(doc);
		}
		
		technologyService.deleteById(params);
		
		return list(model, params);
	}
	
	@RequestMapping("toView")
	public String toView(final ModelMap model, @RequestParam Map<String, String> params){
		
		Technology technology = technologyService.view(params);
		model.addAttribute("technology", technology);
		
		return getContext(VIEW);
	}
	
	@RequestMapping("download")
	public void downloadFile(@RequestParam Map<String, String> params,HttpServletResponse response){
		this.setWebContext(null, response);
		
		FileUtil.downloadTechFile(response, params.get("newFileName"), params.get("fileName"));
	}
	
	
	@RequestMapping("setState")
	public String setState(final ModelMap model, @RequestParam Map<String, String> params){
		
		String id = params.get("id");
		if (StringUtils.isNotEmpty(id)) {
			technologyService.setState(params);
		}
		
		params.remove("state");
		
		return list(model, params);
	}
	
	@RequestMapping("manage")
	public String manage(final ModelMap model, @RequestParam Map<String, String> params){
		
		return getContext("manage");
	}
	
}
