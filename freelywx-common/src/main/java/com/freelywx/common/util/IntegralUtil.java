package com.freelywx.common.util;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;

import com.freelywx.common.config.SystemConstant;

public class IntegralUtil {
	public static List<IntegralVo> getReturnDetail(int totalNum,String cycleId,int cycleNum){
		List<IntegralVo> mapList = new  ArrayList<IntegralVo>();
		MathContext mc = new MathContext(16, RoundingMode.HALF_DOWN);  
		BigDecimal profitIntegral = new BigDecimal(0);
		DateTime datetime = DateTime.now();
		for(int i = 0 ; i< cycleNum -1  ; i++ ){
			IntegralVo vo = new IntegralVo();
			BigDecimal facter =  new BigDecimal(totalNum).divide(new BigDecimal(cycleNum),mc);
			int num = facter.multiply(new BigDecimal(100)).intValue();
			profitIntegral = profitIntegral.add(facter.setScale(2,  BigDecimal.ROUND_HALF_UP));
			vo.setDate(getDate(i+1, datetime, cycleId));
			vo.setIntegerNum(num);
			mapList.add(vo);
		}
		
		//最后一个的处理
		IntegralVo vo1 = new IntegralVo();
		BigDecimal after = new BigDecimal(totalNum).subtract(profitIntegral);
		int num1 = after.setScale(2,  BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)).intValue();
		vo1.setDate(getDate(cycleNum, datetime, cycleId));
		vo1.setIntegerNum(num1);
		mapList.add(vo1);
		
		System.out.println(mapList);
		return mapList;
	}
	
	
	
	public static Date getDate(int interval,DateTime datetime,String cycleId){
		Date date = new Date(); 
		if(StringUtils.equals(cycleId, SystemConstant.DateType.DAY)){
			date = getDay(interval, datetime);
		}else if(StringUtils.equals(cycleId, SystemConstant.DateType.WEEK)){
			date = getWeekDay(interval, datetime);
		}else if(StringUtils.equals(cycleId, SystemConstant.DateType.MONTH)){
			date = getMonthDay(interval, datetime);
		}
		return date;
	}
	
	//根绝间隔获取天数
	private static Date getDay(int interval,DateTime datetime){
		DateTime date = datetime.plusDays(interval);
		return date.toDate();
	}
	
	//根绝间隔获取月份的第一天
	private static Date getMonthDay(int interval,DateTime datetime){
		DateTime date = datetime.plusMonths(interval).dayOfMonth().setCopy(1);
		return date.toDate();
	}

	//根绝间隔获取周的第一天
	private static  Date getWeekDay(int interval,DateTime datetime){
		DateTime date = datetime.plusWeeks(interval).dayOfWeek().setCopy("星期一");
		return date.toDate();
	}
	
	
	
	public static void main(String[] args) {
		getReturnDetail(100, "3", 12);
	}
}
