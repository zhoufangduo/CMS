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

import com.easytop.cms.bean.Clazz;
import com.easytop.cms.bean.User;
import com.easytop.cms.service.ClassService;
import com.easytop.cms.service.UserService;
import com.easytop.cms.utils.FileUtil;
import com.easytop.cms.web.Page;

@Controller
@RequestMapping("/user/*")
public class UserController extends HSSFConstroler {

	private static Logger logger = Logger.getLogger(UserController.class);

	public UserController() {
		super("user/");
	}

	@Autowired
	private UserService userService;

	@Autowired
	private ClassService classService;

	@RequestMapping("toAdd")
	public String toAdd(final ModelMap model, @RequestParam Map<String, String> params) {

		model.addAttribute("clazzs", classService.list(params));
		return getContext(ADD);
	}

	@RequestMapping("add")
	public void add(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response) {

		this.setWebContext(request, response);

		try {

			if (params.size() > 0) {

				User user = userService.view(params);
				if (user != null) {
					write("{\"result\":\"2\"}");
				}else {
					userService.add(params);
					write("{\"result\":\"1\"}");
				}
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write("{\"result\":\"0\"}");
		}

	}
	
	
	@RequestMapping("validate")
	public void validate(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response) {
		
		this.setWebContext(request, response);
		
		User user = userService.view(params);
		if (user != null) {
			write("false");
		}else {
			write("true");
		}
	}
	

	@RequestMapping("list")
	public String list(final ModelMap model, @RequestParam Map<String, String> params) {

		model.addAttribute("page", new Page(userService.getTotal(params), params));

		List<User> users = userService.list(params);

		model.addAttribute("users", users);
		model.addAttribute("clazzs", classService.list(params));

		return getContext(LIST);
	}

	@RequestMapping("deleteById")
	public void deleteById(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response) {

		this.setWebContext(request, response);

		try {

			String id = params.get("username");
			if (StringUtils.isNotEmpty(id)) {
				userService.deleteById(params);
				write(TRUE);
			}

		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}

	}
	
	@RequestMapping("deleteSelect")
	public String deleteSelect(final ModelMap model, @RequestParam Map<String, String> params){
		
		String ids = params.get("ids");
		if(StringUtils.isNotEmpty(ids)){
			if (ids.endsWith(",")) {
				ids = ids.substring(0, ids.length() -1 );
			}
			
			userService.batchDelete(ids.split(","));
		}
		
		return list(model, params);
	}

	@RequestMapping("toView")
	public String toView(final ModelMap model,
			@RequestParam Map<String, String> params) {

		String username = params.get("username");

		if (StringUtils.isNotEmpty(username)) {
			model.addAttribute("clazzs", classService.list(params));
			User user = userService.view(params);
			model.addAttribute("user", user);
		}

		return getContext(VIEW);
	}

	@RequestMapping("update")
	public void update(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response) {

		this.setWebContext(request, response);

		try {

			if (params.size() > 0) {
				this.userService.update(params);
				write(TRUE);
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
	}

	@RequestMapping("toUpdatePwd")
	public String toUpdatePwd(HttpServletRequest request) {
		setWebContext(request, null);
		return getContext("updatePwd");
	}

	@RequestMapping("updatePwd")
	public void updatePwd(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response) {

		this.setWebContext(request, response);

		String result = TRUE;

		try {
			if (userService.validatePwd(params.get("oldpassword"),
					params.get("username"))) {
	
				result = "{\"result\":\"pwderror\"}";
			}else {
				String password = params.get("password");
				String newpassword = params.get("newpassword");
				if (null != password && password.equals(newpassword)) {
					if (!password.equals(params.get("oldpassword"))) {
						userService.updatePwd(params);
					}else {
						result = "{\"result\":\"allGrade\"}";
					}
				} else {
					result = "{\"result\":\"notGrade\"}";
				}
			}
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			result = FALSE;
		}

		write(result);
	}
	
	@RequestMapping("download")
	public void downloadTempl(HttpServletRequest request, HttpServletResponse response){
		FileUtil.downloadTemplate(response, "用户信息.xls", "user.xls");
	}
	
	@RequestMapping("upload")
	public String uploadUser(final ModelMap model,@RequestParam Map<String, String> params,
			@RequestParam("excelFile") Object excelFile ,
			HttpServletRequest request, HttpServletResponse response){
		
		try {
			
			this.setWebContext(request, response);
			
			if (excelFile instanceof MultipartFile ) {
				
				readFile(excelFile);
				
				for(int rownum = firstRow + 1; rownum <= lastRow; rownum ++ ){
					HSSFRow row = sheet.getRow(rownum);
					
					if (StringUtils.isNotEmpty(getValue(row, 0))) {
						userService.add(getParams(row, params));
					}
					
				}
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
		
		return list(model, params);
	}


	private Map<String, String> getParams(HSSFRow row, Map<String, String> params) {
		
		Map<String, String> newParams = new HashMap<String, String>();
		newParams.put("username", getValue(row,0));
		newParams.put("password", "123456");
		newParams.put("name", getValue(row,1));
		newParams.put("idCard", getValue(row,2));
		newParams.put("born", getValue(row,3));
		
		String sex = getValue(row,4);
		if ("男".equals(sex)) {
			sex = "MALE";
		}else if ("女".equals(sex)) {
			sex = "FEMALE";
		}else {
			sex = "SECRECY";
		}
		newParams.put("sex", sex);
		
		String roleType = getValue(row, 5);
		if ("管理员".equals(roleType)) {
			roleType = "ADMIN";
		}else if ("教师".equals(roleType)) {
			roleType = "TEACHER";
		}else {
			roleType = "STUDENT";
		}
		newParams.put("roleType", roleType);
		
		List<Clazz> clazzs = classService.list(params);
		String className = getValue(row,6);
		String classId = "TODO";
		if (StringUtils.isNotEmpty(className)) {
			for(Clazz clazz : clazzs){
				if (clazz.getName().equals(className)) {
					classId = clazz.getId();
				}
			}
		}
		newParams.put("classNo", classId);
		
		newParams.put("email", getValue(row,7));
		newParams.put("mobile", getValue(row,8));
		newParams.put("tel", getValue(row,9));
		newParams.put("qq", getValue(row,10));
		newParams.put("weixin", getValue(row,11));
		newParams.put("weibo", getValue(row,12));
		newParams.put("address1", getValue(row,13));
		newParams.put("address2", getValue(row,14));
		
		return newParams;
	}
	
}
