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
import org.springframework.web.multipart.MultipartFile;

import com.easytop.cms.bean.Item;
import com.easytop.cms.service.ItemService;
import com.easytop.cms.utils.FileUtil;
import com.easytop.cms.web.Page;

@Controller
@RequestMapping("/item/*")
public class ItemController extends BaseController {
	
	private static Logger logger = Logger.getLogger(ItemController.class);
	
	@Autowired
	private ItemService itemService;
	
	public ItemController(){
		super("item/");
	}
	
	@RequestMapping("toAdd")
	public String toAdd(){
		return getContext(ADD);
	}
	
	@RequestMapping("add")
	public void add(@RequestParam("uploadFile") Object  object , 
			@RequestParam Map<String, String> params, HttpServletResponse response,
			HttpServletRequest request){
		
		this.setWebContext(request, response);
		
		try {
			
			MultipartFile file = null;
			
			if (object instanceof MultipartFile ) {
				file = (MultipartFile) object;
			}
			
			if (file != null && file.getSize() > 0) {
				
				String fileName = file.getOriginalFilename();
				
				String newFileName = FileUtil.writeItemFile(file,fileName);
				params.put("fileName", fileName);
				params.put("newFileName", newFileName);
			}
			
			itemService.add(params);
			write(TRUE);
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write(FALSE);
		}
		
	}
	
	@RequestMapping("list")
	public String list(final ModelMap model, @RequestParam Map<String, String> params){
		
		model.addAttribute("page", new Page(itemService.getTotal(params), params)) ;
		
		List<Item> items = itemService.list(params);
		
		model.addAttribute("items", items);
		
		return getContext(LIST);
	}
	
	@RequestMapping("deleteById")
	public String deleteById(final ModelMap model, @RequestParam Map<String, String> params){
		
		String newFileName = params.get("newFileName");
		if (StringUtils.isNotEmpty(newFileName)) {
			FileUtil.deleteItemFile(newFileName);
		}
		
		itemService.deleteById(params);
		
		return list(model, params);
	}
	
	@RequestMapping("download")
	public void download(HttpServletResponse response, @RequestParam Map<String, String> params){
		FileUtil.downloadItemFile(response, params.get("newFileName"), params.get("fileName"));
	}
	
}
