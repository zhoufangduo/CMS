package com.easytop.cms.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	
	private static SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	
	public static String getFileNameTime(){
		Date date = new Date();
		return format.format(date);
	}
	
}
