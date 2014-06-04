package com.easytop.cms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.easytop.cms.bean.Questions;
import com.easytop.cms.service.PaperService;
import com.easytop.cms.service.QuestionsService;
import com.easytop.cms.utils.FileUtil;

@Controller
@RequestMapping("/questions/*")
public class QuestionsController extends HSSFConstroler {
	
	private static Logger logger = Logger.getLogger(QuestionsController.class);

	@Autowired
	private QuestionsService qstionsService;

	@Autowired
	private PaperService paperService;

	public QuestionsController() {
		super("questions/");
	}

	@RequestMapping("toAdd")
	public String toAdd() {
		return getContext(ADD);
	}

	@RequestMapping("add")
	public void add(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response) {
		
		this.setWebContext(request, response);
		
		try {
			
			if (params.size() > 0) {
				String answer = params.get("answer");
				if (StringUtils.isNotEmpty(answer) && answer.endsWith(";")) {
					answer = answer.substring(0, answer.length() -1);
					params.put("answer", answer);
				}
				
				qstionsService.add(params);
				
				write(TRUE);
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}

	@RequestMapping("list")
	public String list(final ModelMap model, @RequestParam Map<String, String> params) {

		model.addAttribute("paper", paperService.view(params.get("paperId")));

		List<Questions> questions = qstionsService.list(params);
		
		model.addAttribute("questions", questions);

		return getContext(LIST);
	}
	
	@RequestMapping("examList")
	public String examList(final ModelMap model, @RequestParam Map<String, String> params) {

		model.addAttribute("paper", paperService.view(params.get("paperId")));

		List<Questions> questions = qstionsService.list(params);
		
		model.addAttribute("questions", questions);

		return getContext("examList");
	}
	
	
	@RequestMapping("deleteById")
	public String deleteById(final ModelMap model,
			@RequestParam Map<String, String> params) {

		String id = params.get("id");
		if (StringUtils.isNotEmpty(id)) {
			qstionsService.deleteById(params);
		}

		return list(model, params);
	}
	
	@RequestMapping("download")
	public void downloadTempl(HttpServletRequest request, HttpServletResponse response){
		FileUtil.downloadTemplate(response, "问题问卷.xls", "questions.xls");
	}
	
	@RequestMapping("upload")
	public String upload(final ModelMap model, @RequestParam Map<String, String> params,
			@RequestParam("excelFile") Object excelFile ,
			HttpServletRequest request, HttpServletResponse response){
		
		try {
			
			this.setWebContext(request, response);
			
			if (excelFile instanceof MultipartFile ) {
				readFile(excelFile);
				for(int rownum = firstRow + 1; rownum <= lastRow; rownum ++ ){
					HSSFRow row = sheet.getRow(rownum);
					if (StringUtils.isNotEmpty(getValue(row, 0))) {
						qstionsService.add(getParams(row, params));
					}
				}
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
		
		return list(model, params);
	}

	private Map<String, String> getParams(HSSFRow row,
			Map<String, String> params) {
		
		Map<String, String> newParams = new HashMap<String, String>();
		
		newParams.put("context", getValue(row, 0));
		
		String type = getValue(row, 1);
		if ("单选".equals(type)) {
			type = "1";
		}else if ("多选".equals(type)) {
			type = "2";
		}else {
			type = "3";
		}
		newParams.put("type", type);
		
		String answer = getValue(row, 2);
		if (StringUtils.isNotEmpty(answer) && answer.endsWith(";")) {
			answer = answer.substring(0, answer.length() - 1);
		}
		newParams.put("answer", answer);
		
		newParams.put("paperId", params.get("paperId"));
		return newParams;
	}
}
