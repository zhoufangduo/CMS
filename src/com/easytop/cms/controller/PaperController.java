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

import com.easytop.cms.bean.Paper;
import com.easytop.cms.service.PaperService;
import com.easytop.cms.web.Page;

@Controller
@RequestMapping("/paper/*")
public class PaperController extends BaseController {
	
	private static Logger logger = Logger.getLogger(PaperController.class);

	public PaperController() {
		super("paper/");
	}

	@Autowired
	private PaperService paperService;
	
	@RequestMapping("toAdd")
	public String toAdd(){
		return getContext(ADD);
	}
	
	@RequestMapping("add")
	public void add(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		this.setWebContext(request, response);
		
		try {
			
			if (params.size() > 0) {
				
				params.put("time", getTime(params));
				params.put("creator", getUser().getName());
				
				paperService.add(params);
			}
			
			write(TRUE);
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}

	private String getTime(Map<String, String> params) {
		
		StringBuffer buffer = new StringBuffer();
		
		String hour = params.get("hour");
		if (StringUtils.isNotEmpty(hour)) {
			buffer.append(hour);
		}else {
			buffer.append("00");
		}
		
		buffer.append(":");
		
		String minute = params.get("minute");
		if (StringUtils.isNotEmpty(minute)) {
			buffer.append(minute);
		}else {
			buffer.append("00");
		}
		
		buffer.append(":");
		
		String second = params.get("second");
		if (StringUtils.isNotEmpty(second)) {
			buffer.append(second);
		}else {
			buffer.append("00");
		}
		
		return buffer.toString();
	}

	@RequestMapping("list")
	public String list(final ModelMap model, @RequestParam Map<String, String> params) {

		model.addAttribute("page", new Page(paperService.getTotal(params), params));

		List<Paper> papers = paperService.list(params);

		model.addAttribute("papers", papers);

		return getContext(LIST);
	}

	@RequestMapping("deleteById")
	public String deleteById(final ModelMap model,@RequestParam Map<String, String> params) {
		
		String id = params.get("id");
		
		if (StringUtils.isNotEmpty(id)) {
			paperService.deleteById(params);
		}
		
		return list(model, params);
	}

	@RequestMapping("toView")
	public String toView(final ModelMap model, @RequestParam("id") String id) {

		if (StringUtils.isNotEmpty(id)) {
			Paper paper = paperService.view(id);
			model.addAttribute("paper", paper);
		}

		return getContext(VIEW);
	}
	
	@RequestMapping("update")
	public void update(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		this.setWebContext(request, response);
		
		try {
			
			if (params.size() > 0) {
				
				params.put("time", getTime(params));
				
				paperService.update(params);
			}
			
			write(TRUE);
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}

}