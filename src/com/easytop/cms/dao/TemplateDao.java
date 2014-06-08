package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Template;
import com.easytop.cms.web.QueryMapUtils;

@Repository
public class TemplateDao extends BaseDaoSupport {

	public int getTotal(Map<String, String> params) {
		
		return getTotal("easytop.cms.template.getTotal",params);
	}

	public List<Template> list(Map<String, String> params) {
		
		return list("easytop.cms.template.list", QueryMapUtils.getCastParams(params));
	}

	public void add(Map<String, String> params) {
		insert("easytop.cms.template.add",params);
	}

	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.template.deleteById", params);
	}

}
