package com.easytop.cms.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropertyUtil {
	
	private static final String CONFIG_FILE = "app_config.properties";
	
	private static Properties properties = new Properties();
	
	static{
		try {
			properties.load(new FileInputStream(PathTools.getResoucePath(CONFIG_FILE)));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public static String get(String key){
		
		return properties.getProperty(key);
	}
	
	public static String get(String key, String defaultVal){
		return properties.getProperty(key,defaultVal);
	}
	
	
	public static boolean getBoolean(String key){
		
		return Boolean.parseBoolean(properties.getProperty(key));
	}
	
	public static boolean getBoolean(String key, boolean defaultVal){
		return Boolean.parseBoolean(properties.getProperty(key,String.valueOf(defaultVal)));
	}
	
	public static int getInt(String key){
		return Integer.parseInt(properties.getProperty(key));
	}
	
	public static int getInt(String key, int defaultVal){
		return Integer.parseInt(properties.getProperty(key,String.valueOf(defaultVal)));
	}
	
	public static long getLong(String key){
		return Long.parseLong(properties.getProperty(key));
	}
	
	public static long getLong(String key, long defaultVal){
		return Long.parseLong(properties.getProperty(key,String.valueOf(defaultVal)));
	}
	
}
