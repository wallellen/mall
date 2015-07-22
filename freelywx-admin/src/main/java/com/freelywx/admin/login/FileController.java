package com.freelywx.admin.login;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.util.UploadUtil;

@Controller
@RequestMapping("/file")
public class FileController {
	@ResponseBody
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public HashMap<String, String> uploadNewsImg(HttpServletRequest request) {
		HashMap<String, String> map = new HashMap<String, String>();
		try {
			map = UploadUtil.uploadFile(request );
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;
	}
}
