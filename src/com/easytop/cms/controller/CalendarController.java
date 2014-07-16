package com.easytop.cms.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.easytop.cms.service.CalendarService;


@Controller
@RequestMapping("/calendar/*")
public class CalendarController extends BaseController {
	
	@Autowired
	private CalendarService calendarService;
	
	public CalendarController(){
		super("calendar/");
	}
	
	@RequestMapping("toAdd")
	public String toAdd(final ModelMap model, @RequestParam Map<String, String> params){
		return getContext(ADD);
	}
	
	
	@RequestMapping("calendar")
	public String calendar(){
		return getContext("calendar");
	}
}
