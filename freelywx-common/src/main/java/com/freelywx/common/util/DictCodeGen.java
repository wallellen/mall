package com.freelywx.common.util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

/**
 * 数据库表转换成javaBean对象小工具(已用了很长时间),
 * 1 bean属性按原始数据库字段经过去掉下划线,并大写处理首字母等等.
 * 2 生成的bean带了数据库的字段说明.
 * 3 各位自己可以修改此工具用到项目中去.
 */
public class DictCodeGen {
	public static final String DBDRIVER = "com.mysql.jdbc.Driver" ;
	// 定义MySQL数据库的连接地址
	public static final String DBURL = "jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=utf-8" ;
	// MySQL数据库的连接用户名
	public static final String DBUSER = "root" ;
	// MySQL数据库的连接密码
	public static final String DBPASS = "root" ;
	
	public static  String parseConstant() {
		StringBuffer sb = new StringBuffer();
		sb.append("public class SystemConstant  {\r\n");
		Connection conn = null ;		// 数据库连接
		PreparedStatement pstmt = null ;	// 数据库操作
		//查询t_b_dict并进行处理
		try {
			Class.forName(DBDRIVER) ;	// 加载驱动程序
			String sql = " select * from T_B_DICT where DICT_STATUS = '1' ";
			conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS) ;
			pstmt = conn.prepareStatement(sql) ;	// 实例化PreapredStatement对象
			ResultSet rs = pstmt.executeQuery();
			ResultSetMetaData md = rs.getMetaData(); 
			while(rs.next()){
				//System.out.println(rs.getString("dict_id"));
				String dictName = rs.getString("dict_name");
				String dictId = rs.getString("DICT_ID");
				//生成注释
				sb.append("/**  ");
				sb.append(dictName);
				sb.append("**/\r\n");
				sb.append(" public static class "+initcap(dictId)+"  {\r\n");
				//查询详情
				String sql1 = "select  * from T_B_DICT_DETAIL where DICT_PARAM_STATUS = '1' and DICT_ID = '"+dictId+"'";
				PreparedStatement substmt = conn.prepareStatement(sql1) ;	// 实例化PreapredStatement对象
				ResultSet subrs = substmt.executeQuery();
				while(subrs.next()){
					String paraValue = subrs.getString("dict_param_value");
					String paraName = subrs.getString("dict_param_name");
					String paraNameEn = subrs.getString("dict_param_name_en");
					//生成注释
					sb.append("/** ");
					sb.append(paraName);
					sb.append("**/\r\n");
					sb.append(" public static final String "+paraNameEn+" = \""+paraValue+"\";  \r\n");
				}
				substmt.close();
				sb.append("}\r\n");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sb.append("}\r\n");
		System.out.println(sb.toString());
		return sb.toString();
	}

	
	private static String initcap(String str) {
		String[] nameArr = str.toLowerCase().split("_");
		String result = "";
		for(String  s : nameArr){
			char[] ch = s.toCharArray();
			if (ch[0] >= 'a' && ch[0] <= 'z') {
				ch[0] = (char) (ch[0] - 32);
			}
			result += new String(ch);
		}
		//System.out.println("tablename:"+result);
		return result;
	}
	
	public static void main(String[] args) {
		parseConstant();
	}
}
