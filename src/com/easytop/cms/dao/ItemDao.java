package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Item;
import com.easytop.cms.web.QueryMapUtils;

@Repository
public class ItemDao extends BaseDaoSupport{

	public int getTotal(Map<String, String> params) {
		return getTotal("easytop.cms.item.getTotal", params);
	}

	public List<Item> list(Map<String, String> params) {
		return list("easytop.cms.item.list", QueryMapUtils.getCastParams(params));
	}

	public void add(Map<String, String> params) {
		insert("easytop.cms.item.add", params);
	}

	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.item.deleteById", params);
	}

}
