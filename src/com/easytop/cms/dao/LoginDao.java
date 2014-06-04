package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Menu;
import com.easytop.cms.bean.User;

@Repository
public class LoginDao extends BaseDaoSupport {

	public User login(Map<String, String> params){
		return getById("easytop.cms.login.login", params);
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	public List<Menu> getLoginUserPower(String roleType) {
		return getSqlMapClientTemplate().queryForList("easytop.cms.login.userTypePower", roleType);
	}

}
