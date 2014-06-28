package com.easytop.cms.utils.converter;

import java.io.IOException;

import org.apache.commons.lang.StringUtils;

import com.easytop.cms.utils.PropertyUtil;

public class HtmlConverterUtils {
	
	private static String[] getCommand(String source,String targetDir) {

		String command = PropertyUtil.get("pdftohtmlBin");
		
		if (StringUtils.isEmpty(command)) {
			throw new IllegalArgumentException("pdftohtmlBin is " + command);
		}
		
		return new String[] {command, source, targetDir};

	}
	
	public static void converter(final String source, final String targetDir){
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				executeCommand(getCommand(source, targetDir));
			}
		});
	}

	private static void executeCommand(String[] command) {
		
		Process process = null;
		
		try {
			process = Runtime.getRuntime().exec(command);
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if (process != null) {
				process.destroy();
			}
		}
	}
}
