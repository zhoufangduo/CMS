package com.easytop.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easytop.cms.bean.Technology;
import com.easytop.cms.dao.TechnologyDao;

@Service
public class TechnologyService {
	
	@Autowired
	private TechnologyDao technologyDao;
	
	public void add(Map<String, String> params) {
		technologyDao.add(params);
	}

	public int getTotal(Map<String, String> params) {
		return technologyDao.getTotal(params);
	}

	public List<Technology> list(Map<String, String> params) {
		
		return technologyDao.list(params);
	}

	public void deleteById(Map<String, String> params) {
		technologyDao.deleteById(params);
	}

	public Technology view(Map<String, String> params) {
		
		return technologyDao.view(params);
	}

	public void update(Map<String, String> params) {
		technologyDao.update(params);
	}

	public void setState(Map<String, String> params) {
		technologyDao.setState(params);
	}

}
