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

}