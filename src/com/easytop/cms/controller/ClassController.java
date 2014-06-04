package com.easytop.cms.controller;

import java.util.HashMap;
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

import com.easytop.cms.bean.Clazz;
import com.easytop.cms.service.ClassService;
import com.easytop.cms.service.LessonService;
import com.easytop.cms.service.UserService;
import com.easytop.cms.web.Page;

@Controller
@RequestMapping("/clazz/*")
public class ClassController extends BaseController {
	
	private static Logger logger = Logger.getLogger(ClassController.class);
	
	public ClassController(){
		super("clazz/");
	}
	
	@Autowired
	private ClassService classService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private LessonService lessonService;

	@RequestMapping("toAdd")
	public String toAdd(final ModelMap model,@RequestParam Map<String, String> params) {
		model.addAttribute("teachers", userService.list(getTeacherParams()));
		model.addAttribute("lessons",lessonService.list(params));
		return getContext(ADD);
	}

	@RequestMapping("add")
	public void add(@RequestParam Map<String, String> params, HttpServletRequest request ,HttpServletResponse response) {
		
		try {
			
			this.setWebContext(request, response);
			
			if (params.size() > 0) {
				String id = classService.add(params);
				classService.addLesson(id,params.get("lessons"));
			}
			
			write(TRUE);
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
		
	}

	@RequestMapping("list")
	public String list(final ModelMap model,@RequestParam Map<String, String> params) {
		
		model.addAttribute("page", new Page(classService.getTotal(params), params)) ;
		
		List<Clazz> classs = classService.list(params);
		
		model.addAttribute("clazzs", classs);
		model.addAttribute("teachers", userService.list(getTeacherParams()));
		
		return getContext(LIST);
	}

	private Map<String, String> getTeacherParams() {
		Map<String, String> params2 = new HashMap<String, String>();
		params2.put("roleType", "TEACHER");
		return params2;
	}
	
	@RequestMapping("deleteById")
	public String deleteById(final ModelMap model,@RequestParam Map<String, String> params){
		String id = params.get("id");
		if (StringUtils.isNotEmpty(id)) {
			classService.deleteById(params);
			classService.deleteLesson(id);
		}
		return list(model, params);
	}

	@RequestMapping("view")
	public String toView(final ModelMap model,@RequestParam Map<String, String> params) {
		String id = params.get("id");
		if (StringUtils.isNotEmpty(id)) {
			toAdd(model,params);
			Clazz clazz = classService.view(params);
			model.addAttribute("clazz", clazz);
			model.addAttribute("classLesson", classService.getClassLessons(id));
		}
		
		return getContext(VIEW);
	}

	@RequestMapping("update")
	public void update(final ModelMap model,@RequestParam Map<String, String> params) {
		if (params.size() > 0) {
			classService.update(params);
			classService.deleteLesson(params.get("id"));
			classService.addLesson(params.get("id"), params.get("lessons"));
		}
	}
}
