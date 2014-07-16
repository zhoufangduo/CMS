package com.easytop.cms.controller;

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

import com.easytop.cms.bean.Lesson;
import com.easytop.cms.service.ItemService;
import com.easytop.cms.service.LessonService;
import com.easytop.cms.web.Page;

@Controller
@RequestMapping("/lesson/*")
public class LessonController extends BaseController {
	
	private static Logger logger = Logger.getLogger(LessonController.class);
	
	@Autowired
	private LessonService lessonService;
	
	@Autowired
	private ItemService itemService;

	public LessonController() {
		super("lesson/");
	}

	@RequestMapping("toAdd")
	public String toAdd(final ModelMap model, @RequestParam Map<String, String> params) {
		
		params.put("state", "2");
		
		model.addAttribute("items", itemService.list(params));
		
		return getContext(ADD);
	}
	
	@RequestMapping("add")
	public void add(final ModelMap model, @RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		try {
			
			this.setWebContext(request, response);
			
			if (params.size() > 0) {
				params.put("creator", getUser().getName());
				lessonService.add(params);
				write(TRUE);
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}
	
	@RequestMapping("list")
	public String list(final ModelMap model, @RequestParam Map<String, String> params){
		
		model.addAttribute("page", new Page(lessonService.getTotal(params), params)) ;
		
		List<Lesson> lessons = lessonService.list(params);
		
		model.addAttribute("lessons", lessons);
		
		return getContext(LIST);
	}
	
	@RequestMapping("deleteById")
	public String deleteById(final ModelMap model, @RequestParam Map<String, String> params){
		
		String id = params.get("id");
		
		if(StringUtils.isNotEmpty(id)){
			lessonService.deleteById(params);
		}
		
		return list(model, params);
	}
	
	@RequestMapping("toView")
	public String toView(final ModelMap model, @RequestParam Map<String, String> params){
		
		String id = params.get("id");
		if (StringUtils.isNotEmpty(id)) {
			
			Lesson lesson = lessonService.view(params);
			
			toAdd(model, params);
			
			model.addAttribute("lesson", lesson);
		}
		
		return getContext(VIEW);
	}
	
	@RequestMapping("update")
	public void update(final ModelMap model, @RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		this.setWebContext(request, response);
		
		try {
			
			if (params.size() > 0) {
				lessonService.update(params);
				write(TRUE);
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}
	
	@RequestMapping("state")
	public String state(final ModelMap model, @RequestParam Map<String, String> params){
			
		if (params.size() > 0) {
			lessonService.updateState(params);
		}
		
		return  list(model, params);
	}
	
	
	@RequestMapping("viewTechs")
	public String viewTechs(final ModelMap model, @RequestParam Map<String, String> params){
		
		String id = params.get("id");
		if (StringUtils.isNotEmpty(id)) {
			
			Lesson lesson = lessonService.view(params);
			model.addAttribute("lesson", lesson);
		}
		
		return getContext("techs");
	}
	
}
