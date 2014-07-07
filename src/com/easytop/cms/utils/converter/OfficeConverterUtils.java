package com.easytop.cms.utils.converter;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.OfficeManager;

public class OfficeConverterUtils  {
	
	public static void converter(final HttpServletRequest request, final File source, final File target) {
		
		new Thread(new Runnable() {
			@Override
			public void run() {
				OfficeManager officeManager = getOfficeManager(request);
				OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);
				converter.convert(source,target);
			}
			
		}).start();
	}
	
	public static void converter(final HttpServletRequest request, final String source, final String target) {
		converter(request,new File(source),new File(target));
	}


	
	private static OfficeManager getOfficeManager(HttpServletRequest request) {
		return (OfficeManager)request.getServletContext().getAttribute("officeManager");
	}
}
