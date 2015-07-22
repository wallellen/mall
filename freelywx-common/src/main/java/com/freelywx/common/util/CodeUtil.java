package com.freelywx.common.util;

import java.util.Date;
import java.util.Random;


public class CodeUtil {
	/**
	 * 计算贷款信息的code 贷款ID规则：总计16位
	 * 
	 * @return
	 */
	public static String generatorProdCode(int loadId) {
		String prev = "MW";
		// prev 3 bits is “DK”
		// middle 4 bits is date to convert
		// last bits is order convert to hex
		StringBuilder loanCode = new StringBuilder();
		// String custStr = appendSpace(prev,2).toString();
		loanCode.append(prev);
		loanCode.append("-");
		// convent date to hex
		// SimpleDateFormat df=new SimpleDateFormat("yy-MM-dd");
		String dateStr = TimeUtil.formatStr(new Date());
		String str = dateStr.substring(2, 10);
		String[] array = str.split("-");
		Integer year = Integer.valueOf(array[0]);
		Integer month = Integer.valueOf(array[1]);
		Integer day = Integer.valueOf(array[2]);
		char f = 'F';
		if (year > 15) {
			char a = (char) (f + year - 15);
			loanCode.append(a);
		} else {
			loanCode.append(Integer.toHexString(year));
		}
		String dayBit = Integer.toHexString(day);
		loanCode.append(Integer.toHexString(month)).append(appendSpace(dayBit, 2).toString());
		StringBuffer loanSequence = new StringBuffer(Long.toHexString(loadId));
		loanSequence = appendSpace(loanSequence.toString(), 8);
		loanSequence.insert(2, "-");
		loanCode.append(loanSequence);
		//System.out.println("id:"+parseLoanCode(loanCode.toString().toUpperCase()));
		return loanCode.toString().toUpperCase();
	}

	/**
	 * convert Loan code to Loan id
	 * 
	 * @param LoanCode
	 * @return
	 */
	public static Long parseLoanCode(String loanCode) {
		if (loanCode == null || loanCode.length() < 8) {
			return null;
		}
		String str = loanCode.substring(7, loanCode.length()).replace("-", "");
		return Long.valueOf(str, 16);
	}

	private static StringBuffer appendSpace(String src, int length) {
		StringBuffer buff = new StringBuffer();
		for (int i = 0; i < length - src.length(); ++i) {
			buff.append("0");
		}
		buff.append(src);
		return buff;
	}
	
	public static String getRandomString(int length){  
        String str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";  
        Random random = new Random();  
        StringBuffer sb = new StringBuffer();  
        for(int i = 0 ; i < length; ++i){  
            int number = random.nextInt(62);//[0,62)  
            sb.append(str.charAt(number));  
        }  
        return sb.toString();  
    }  
	public static void main(String[] args) {
//		System.out.println(generatorLoanCode(12121L));
		// System.out.println(parseLoanCode(generatorLoanCode(2345280l,
		// 18717215l)));
		// System.out.println(generatorCategoryCode(454l));
		// System.out.println(parseCategoryCode(generatorCategoryCode(454l)));
		// System.out.println(Long.toHexString(10));
		//
		// System.out.println(generatorProductCode(123l, 434341l));
		// System.out.println(parseProductCode(generatorProductCode(123l,
		// 434341l)));
		// System.out.println(parseLoanCode("820-D9180F4-E31"));
	}
}
