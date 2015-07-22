package com.freelywx.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class TimeUtil {
	
	public static Date  formatData(String dataVal , String formatVal) {
		SimpleDateFormat  formatter = new SimpleDateFormat (formatVal);
		 ParsePosition pos = new ParsePosition(0);
		java.util.Date cDate= formatter.parse(dataVal,pos);
		return cDate ; 
	}
	
	
	public static String  formatStr(Date date) {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date sDate=new Date(date.getTime());
		return  df.format(sDate);
	}
	
	
	public static String  formatDayStr(Date date) {
		SimpleDateFormat df=new SimpleDateFormat("yyyyMMdd");
		Date sDate=new Date(date.getTime());
		return  df.format(sDate);
	}
	public static String  formatByType(Date date,String parse) {
		SimpleDateFormat df=new SimpleDateFormat(parse);
		Date sDate=new Date(date.getTime());
		return  df.format(sDate);
	}
	
	public static String  formatStrByPattern(Date date,String pattern) {
		SimpleDateFormat df=new SimpleDateFormat(pattern);
		Date sDate=new Date(date.getTime());
		return  df.format(sDate);
	}
	
	public static String getDate(String dateString , int beforeDays) throws ParseException{   
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
		Date inputDate = dateFormat.parse(dateString);    
		Calendar cal = Calendar.getInstance(); 
		cal.setTime(inputDate);    
		int inputDayOfYear = cal.get(Calendar.DAY_OF_YEAR); 
		cal.set(Calendar.DAY_OF_YEAR , inputDayOfYear-beforeDays );  
		return dateFormat.format(cal.getTime());
	}
	
	public static String getDate(int beforeDays) throws ParseException{   
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
		//Date inputDate = dateFormat.parse(dateString);    
		Calendar cal = Calendar.getInstance(); 
		cal.setTime(new Date());    
		int inputDayOfYear = cal.get(Calendar.DAY_OF_YEAR); 
		cal.set(Calendar.DAY_OF_YEAR , inputDayOfYear-beforeDays );  
		return dateFormat.format(cal.getTime());
	}
}
