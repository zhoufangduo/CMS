package com.easytop.cms.utils;

import java.io.File;

public abstract class PathTools {
	
	public static String getItemPath(String resource){
		
		File file =  new File(getCurrentPath() + "/upload/item/");
		
		return getFilePath(resource, file);
	}

	private static String getFilePath(String resource, File file) {
		
		if (!file.exists()) {
			file.mkdirs();
		}
		
		return file.getPath() + File.separator +  resource;
	}
	
	public static String getResoucePath(String resource){
		return Thread.currentThread().getContextClassLoader().
				getResource(resource).getPath();
	}
	
	public static String getCurrentPath(){
		return getResoucePath("");
	}

	public static String getTechPath(String resource) {
		
		File file =  new File(getCurrentPath() + "/upload/tech/");
		
		return getFilePath(resource, file);
	}

	public static String getTemplatePath(String fileName) {
		return getResoucePath(fileName);
	}
}
