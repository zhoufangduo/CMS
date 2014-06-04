package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Technology;
import com.easytop.cms.web.QueryMapUtils;

@Repository
public class TechnologyDao extends BaseDaoSupport{
	
	public void add(Map<String, String> params) {
		insert("easytop.cms.technlg.add", params);
	}

	public int getTotal(Map<String, String> params) {
		return (Integer) getTotal("easytop.cms.technlg.getTotal", params);
	}

	public List<Technology> list(Map<String, String> params) {
		return list("easytop.cms.technlg.list", QueryMapUtils.getCastParams(params));
	}

	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.technlg.deleteById", params);
	}

	public Technology view(Map<String, String> params) {
		return getById("easytop.cms.technlg.view", params);
	}

	public void update(Map<String, String> params) {
		update("easytop.cms.technlg.update", params);
	}

	public void setState(Map<String, String> params) {
		update("easytop.cms.technlg.update", params);
	}

}
