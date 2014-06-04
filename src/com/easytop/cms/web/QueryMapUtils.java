package com.easytop.cms.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class QueryMapUtils {
	
	public static Map<String, Object> getCastParams(Map<String, String> params){
		Map<String, Object> newParams = new HashMap<String, Object>();
		
		Iterator<String> keys = params.keySet().iterator();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			if (key.equals("start") || key.equals("pageSize")) {
				newParams.put(key, Integer.parseInt(params.get(key)));
			}else {
				newParams.put(key, params.get(key));
			}
		}
		
		return newParams;
	}
}
