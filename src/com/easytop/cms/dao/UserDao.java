package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.User;
import com.easytop.cms.web.QueryMapUtils;

@Repository
public class UserDao extends BaseDaoSupport {

	public void add(Map<String, String> params) {
		insert("easytop.cms.user.add", params);
	}

	public User view(Map<String, String> params) {
		return getById("easytop.cms.user.view", params);
	}

	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.user.deleteById", params);
	}

	public void update(Map<String, String> params) {
		update("easytop.cms.user.update", params);
	}
	
	public List<User> list(Map<String, String> params) {
		return list("easytop.cms.user.list", QueryMapUtils.getCastParams(params));
	}
	
	public int getTotal(Map<String, String> params) {
		return getTotal("easytop.cms.user.getTotal", params);
	}

	public void updatePwd(Map<String, String> params) {
		update("easytop.cms.user.updatePwd", params);
	}

	@SuppressWarnings("deprecation")
	public void batchDelete(List<String> list) {
		getSqlMapClientTemplate().delete("easytop.cms.user.batchDelete", list);
	}

}
