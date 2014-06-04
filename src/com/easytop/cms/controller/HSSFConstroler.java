package com.easytop.cms.controller;

import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

public class HSSFConstroler extends BaseController {
	
	protected int firstRow;
	
	protected int lastRow ;
	
	protected HSSFSheet sheet;
	
	public HSSFConstroler(String dirPath){
		super(dirPath);
	}
	
	
	private HSSFSheet getWorkSheet(MultipartFile file) throws IOException {
		HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
		HSSFSheet sheet = workbook.getSheetAt(0);
		return sheet;
	}
	
	
	protected String getValue(HSSFRow row, int cellnum) {
		
		HSSFCell cell = row.getCell((short) cellnum);
		if (cell != null) {
			return cell.toString();
		}
		
		return null;
	}
	
	protected void readFile(Object excelFile) throws IOException{
		
		MultipartFile file = (MultipartFile)excelFile; 
		
		this.sheet = getWorkSheet(file);
		
		this.firstRow = sheet.getFirstRowNum();
		this.lastRow = sheet.getLastRowNum();
	}
	
}
