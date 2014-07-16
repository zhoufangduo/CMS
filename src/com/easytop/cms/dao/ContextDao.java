package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Context;

@Repository
public class ContextDao extends BaseDaoSupport{

	public void add(Map<String, String> params) {
		insert("easytop.cms.context.add", params);
	}

	public List<Context> list(Map<String, String> params) {
		
		return list("easytop.cms.context.list", params);
	}

	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.context.deleteById", params);
	}

	public Context viewByTechId(Map<String, String> params) {
		
		return getById("easytop.cms.context.viewByTechId", params);
	}

	public Context viewById(Map<String, String> params) {
		
		return getById("easytop.cms.context.viewByTechId", params);
	}

	public void update(Map<String, String> params) {
		update("easytop.cms.context.update", params);
	}

	public void hidden(Map<String, String> params) {
		update("easytop.cms.context.update", params);
	}

}
