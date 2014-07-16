package com.easytop.cms.controller;

import java.util.ArrayList;
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
import com.easytop.cms.service.ClassService;
import com.easytop.cms.service.PaperService;
import com.easytop.cms.service.QuestionsService;
import com.easytop.cms.utils.FileUtil;

@Controller
@RequestMapping("/questions/*")
public class QuestionsController extends HSSFController {
	
	private static Logger logger = Logger.getLogger(QuestionsController.class);

	@Autowired
	private QuestionsService qstionsService;

	@Autowired
	private PaperService paperService;
	
	@Autowired
	private ClassService classService;

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
				
				delEndSemicolon(params);
				
				qstionsService.add(params);
				
				write(TRUE);
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}

	private void delEndSemicolon(Map<String, String> params) {
		String answer = params.get("answer");
		if (StringUtils.isNotEmpty(answer) && answer.endsWith(";")) {
			answer = answer.substring(0, answer.length() -1);
			params.put("answer", answer);
		}
		
		String reply = params.get("reply");
		if (StringUtils.isNotEmpty(reply) && reply.endsWith(";")) {
			reply = reply.substring(0, reply.length() -1);
			params.put("reply", reply);
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
	
	@RequestMapping("submit")
	public void submit(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		setWebContext(request, response);
		
		int score = 0;
		
		List<Questions> questions = qstionsService.list(params);
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		for(Questions qtion : questions){
			if (qtion != null) {
				
				String value = params.get(qtion.getId());
				
				if("2".equals(qtion.getType())){
					String[]values = request.getParameterValues(qtion.getId());
					value = StringUtils.join(values, ";");
				}
				
				if (qtion.getReply().equals(value)) {
					score += qtion.getScore();
				}
				
				Map<String, String> newParams = new HashMap<String, String>();
				newParams.put("questionsId", qtion.getId());
				newParams.put("answer", value);
				newParams.put("username", getUser().getUsername());
				
				list.add(newParams);
			}
		}
		
		
		Map<String, String> newParams = new HashMap<String, String>();
		
		newParams.put("paperId", params.get("paperId"));
		newParams.put("total", String.valueOf(score));
		newParams.put("username", getUser().getUsername());
		
		qstionsService.addUserAnswer(list, newParams);

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
		newParams.put("score", getValue(row, 2));
		newParams.put("answer", getValue(row, 3));
		newParams.put("reply", getValue(row, 4));
		newParams.put("paperId", params.get("paperId"));
		delEndSemicolon(newParams);
		return newParams;
	}
	
	
}
