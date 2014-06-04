package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Paper;
import com.easytop.cms.web.QueryMapUtils;

@Repository
public class PaperDao extends BaseDaoSupport{

	public int getTotal(Map<String, String> params) {
		
		Integer total = (Integer) getTotal("easytop.cms.paper.getTotal", params);
		if (total == null) {
			total = 0;
		}
		return  total;
	}

	public List<Paper> list(Map<String, String> params) {
		return list("easytop.cms.paper.list", QueryMapUtils.getCastParams(params));
	}

	public Paper view(String id) {
		return (Paper) getById("easytop.cms.paper.view", id);
	}

	public void add(Map<String, String> params) {
		insert("easytop.cms.paper.add", params);
	}
	
	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.paper.deleteById", params);
	}

	public void update(Map<String, String> params) {
		update("easytop.cms.paper.update", params);
	}
	
}
