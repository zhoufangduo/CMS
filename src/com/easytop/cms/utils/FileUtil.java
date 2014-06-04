package com.easytop.cms.utils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

public abstract class FileUtil {
	
	public static String writeItemFile(MultipartFile file, String fileName) {
		
		File  newFile = new File(PathTools.getItemPath(System.currentTimeMillis() 
				+ getFileType(fileName)));
		
		return transerToFile(file, newFile);
	}

	private static String transerToFile(MultipartFile file, File newFile) {
		try {
			
			if (!newFile.exists()) {
				newFile.createNewFile();
			}
			file.transferTo(newFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return newFile.getName();
	}
	
	public static String getFileType(String fileName){
		if (fileName != null) {
			int beginIndex = fileName.lastIndexOf(".");
			if (beginIndex > 0) {
				return fileName.substring(beginIndex);
			}
		}
		
		return "";
	}

	public static void deleteItemFile(String newFileName) {
		File file = new File(PathTools.getItemPath(newFileName));
		
		if (file != null && file.exists()) {
			file.delete();
		}
	}
	
	public static void deleteTechFile(String newFileName) {
		File file = new File(PathTools.getTechPath(newFileName));
		
		if (file != null && file.exists()) {
			file.delete();
		}
	}
	
	public static void downloadItemFile(HttpServletResponse response,String newFileName,String fileName){
		
		File newFile = new File(PathTools.getItemPath(newFileName)); 
		writeToResponse(response, fileName, newFile);
	}
	
	public static void downloadTechFile(HttpServletResponse response,String newFileName,String fileName){
		
		File newFile = new File(PathTools.getTechPath(newFileName)); 
		writeToResponse(response, fileName, newFile);
	}


	private static void writeToResponse(HttpServletResponse response,
			String fileName, File newFile) {
		byte[]data = getFileData(newFile);
		
		response.reset();  
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
		response.addHeader("Content-Length", "" + data.length);  
		response.setContentType("application/octet-stream;charset=UTF-8");  
		OutputStream outputStream = null;
		try {
			outputStream = new BufferedOutputStream(response.getOutputStream());  
			outputStream.write(data);
			outputStream.flush();  
		} catch (IOException e) {
			e.printStackTrace();
		}  finally{
			
			try {
				outputStream.close();  
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	private static byte[] getFileData(File newFile) {
		try {
			return FileUtils.readFileToByteArray(newFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return new byte[0];
	}

	public static String writeTechFile(MultipartFile file, String fileName) {
	
		File  newFile = new File(PathTools.getTechPath(
				System.currentTimeMillis()  + getFileType(fileName)));
		
		return transerToFile(file, newFile);
	}
	
	public static void downloadTemplate(HttpServletResponse response,String newFileName,String fileName){
		File newFile = new File(PathTools.getTemplatePath(fileName)); 
		
		try {
			newFileName = new String(newFileName.getBytes("UTF-8"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		
		writeToResponse(response, newFileName, newFile);
	}
}
