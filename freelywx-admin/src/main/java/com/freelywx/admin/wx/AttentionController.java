package com.freelywx.admin.wx;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.wx.WxAttention;
import com.rps.util.D;

/**
 * 关注控制器类
 */
@Controller
@RequestMapping("/attention")
public class AttentionController {

	@RequestMapping("")
	public String init() {
		return "attention/attention";
	}

	@ResponseBody
	@RequestMapping("/list")
	public WxAttention list() throws Exception {
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return D.sql("select * from t_wx_attention where uid =?").oneOrNull(WxAttention.class, loginUser.getUser_id());

	}

	/*
	 * 修改新增
	 */
	@ResponseBody
	@RequestMapping(value = "/save")
	public boolean save(@RequestBody WxAttention wxAttention) {

		if (wxAttention.getAttention_id() != null) {
			return D.updateWithoutNull(wxAttention) > 0;
		} else {
			return D.insertWithoutNull(wxAttention) > 0;
		}

	}

}
