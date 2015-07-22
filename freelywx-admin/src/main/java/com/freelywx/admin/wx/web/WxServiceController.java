package com.freelywx.admin.wx.web;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.freelywx.admin.wx.utils.SignUtil;
import com.freelywx.common.model.user.TPMerchantWx;
import com.rps.util.D;

 
@Controller
@RequestMapping("/wxService")
public class WxServiceController {
	private static final Logger logger = LoggerFactory.getLogger(WxServiceController.class);
	 
	@RequestMapping(method = RequestMethod.GET)
	public void getService(HttpServletRequest req,HttpServletResponse res) throws Exception {
		String signature = req.getParameter("signature");// 微信加密签名
		String timestamp = req.getParameter("timestamp");// 时间戳
		String nonce = req.getParameter("nonce");// 随机数
		String echostr = req.getParameter("echostr");// 随机字符串
		String wxid = req.getParameter("wxid");// 随机字符串
		TPMerchantWx merchantWx = D.selectById(TPMerchantWx.class, Integer.parseInt(wxid));
		if(merchantWx != null ){
			PrintWriter out = res.getWriter();
			if (SignUtil.checkSignature(signature,timestamp,nonce,merchantWx.getToken())) {
				out.print(echostr);
			} else {
				logger.info("微信接入失败");
			}
			out.close();
		}
	} 

	@RequestMapping(method = RequestMethod.POST)
	public void postService(HttpServletRequest req, HttpServletResponse res) throws Exception {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		out.print(WxHandler.handleRequest(req));
		out.close();
	}
}
