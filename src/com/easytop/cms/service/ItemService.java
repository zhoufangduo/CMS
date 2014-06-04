package com.easytop.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easytop.cms.bean.Item;
import com.easytop.cms.dao.ItemDao;

@Service
public class ItemService {
	
	@Autowired
	private ItemDao itemDao;
	
	public int getTotal(Map<String, String> params) {
		return itemDao.getTotal(params);
	}

	public List<Item> list(Map<String, String> params) {
		
		return itemDao.list(params);
	}

	public void add(Map<String, String> params) {
		itemDao.add(params);
	}

	public void deleteById(Map<String, String> params) {
		itemDao.deleteById(params);
	}

}
