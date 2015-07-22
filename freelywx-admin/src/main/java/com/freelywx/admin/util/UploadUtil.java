package com.freelywx.admin.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.freelywx.common.config.Config;

public class UploadUtil {
	public static HashMap<String, String>  uploadFile(HttpServletRequest request)	throws IllegalStateException, IOException {
		HashMap<String, String> map = new HashMap<String, String>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		String path = request.getParameter("path");
		String key = request.getParameter("key");
		if(StringUtils.isEmpty(path)){
			path = "system";
		}
		// 文件保存路径
		String basePath =  "";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String ymd = sdf.format(new Date());
		String extPath = File.separator + path + File.separator + ymd + File.separator;
		basePath = Config.UPLOAD_PATH + extPath;
		// 创建文件夹
		File file = new File(basePath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String srcPath = "";
		String fileName = null;
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			// 上传文件
			MultipartFile mf = entity.getValue();
			fileName = mf.getOriginalFilename();
			String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			// 重命名文件
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
			File uploadFile = new File(basePath + newFileName);
			srcPath = extPath + newFileName;
			// 将\\斜杠改为/斜杠
			srcPath = StringUtils.replace(srcPath, "\\", "/");
			try {
				FileCopyUtils.copy(mf.getBytes(), uploadFile);
				map.put("url", srcPath);
				map.put("previewUrl", Config.SERVER_BASE+ srcPath);
				System.out.println("----------url---------"+srcPath);
				System.out.println("-------previewUrl----------"+Config.SERVER_BASE+ srcPath);
				map.put("status", "1");
			} catch (IOException e) {
				map.put("status", "0");
				map.put("message", "图片上传失败");
				e.printStackTrace();
			}
			if(!StringUtils.isEmpty(key)){
				map.put("key", key);
			}
		}
		return map;
	}
}
