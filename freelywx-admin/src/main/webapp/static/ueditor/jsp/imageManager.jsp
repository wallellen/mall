<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.ServletContext"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<% 
    //仅做示例用，请自行修改
	String path = "tongkaquan";
	String imgStr ="";
	String realpath = "D://dev//nginx-1.4.3//html//"+path;
	String ownPath1 = "http://localhost:8999/tongkaquan/";
	List<File> files = getFiles(realpath,new ArrayList());
	for(File file :files ){
		System.out.println(file.getName()+":"+file.getAbsolutePath().indexOf("tongkaquan"));
		String pathUrl = file.getAbsolutePath(); 
		String str = pathUrl.substring(pathUrl.indexOf("tongkaquan")).replace("\\", "/");
		System.out.println(str);
		imgStr+= str +"ue_separate_ue";
	}
	System.out.println(imgStr);
	if(imgStr!=""){
        imgStr = imgStr.substring(0,imgStr.lastIndexOf("ue_separate_ue")).replace(File.separator, "/").trim();
    }
	System.out.println(imgStr);
	out.print(imgStr);		
%>
<%!
public List getFiles(String realpath, List files) {
	
	File realFile = new File(realpath);
	if (realFile.isDirectory()) {
		File[] subfiles = realFile.listFiles();
		for(File file :subfiles ){
			if(file.isDirectory()){
				getFiles(file.getAbsolutePath(),files);
			}else{
				if(!getFileType(file.getName()).equals("")) {
					files.add(file);
				}
			}
		}
	}
	return files;
}

public String getRealPath(HttpServletRequest request,String path){
	ServletContext application = request.getSession().getServletContext();
	String str = application.getRealPath(request.getServletPath());
	return new File(str).getParent();
}

public String getFileType(String fileName){
	String[] fileType = {".gif" , ".png" , ".jpg" , ".jpeg" , ".bmp"};
	Iterator<String> type = Arrays.asList(fileType).iterator();
	while(type.hasNext()){
		String t = type.next();
		if(fileName.toLowerCase().endsWith(t)){
			return t;
		}
	}
	return "";
}
%>