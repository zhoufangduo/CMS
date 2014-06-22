package com.easytop.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easytop.cms.bean.Context;
import com.easytop.cms.dao.ContextDao;

@Service
public class ContextService {
	
	@Autowired
	private ContextDao ctxDao;

	public void add(Map<String, String> params) {
		ctxDao.add(params);
	}

	public List<Context> list(Map<String, String> params) {
	
		return ctxDao.list(params);
	}
	
}
