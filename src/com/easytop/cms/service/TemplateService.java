package com.easytop.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easytop.cms.bean.Template;
import com.easytop.cms.dao.TemplateDao;

@Service
@Transactional
public class TemplateService {
	
	@Autowired
	private TemplateDao templateDao;

	public int getTotal(Map<String, String> params) {
		return templateDao.getTotal(params);
	}

	public List<Template> list(Map<String, String> params) {
		return templateDao.list(params);
	}

	public void add(Map<String, String> params) {
		templateDao.add(params);
	}

	public void deleteById(Map<String, String> params) {
		templateDao.deleteById(params);
	}

}
