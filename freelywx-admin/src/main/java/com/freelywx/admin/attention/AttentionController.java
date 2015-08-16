package com.freelywx.admin.attention;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.pub.TPubAttention;
import com.rps.util.D;

/**
 * 关注控制器类
 */
@Controller
@RequestMapping("/attention")
public class AttentionController {
	
	
	@RequestMapping("/init")
	public String init() { 
		return "attention/attention";
	}
	
	

	@ResponseBody
	@RequestMapping("/list")
	public TPubAttention list() throws Exception
	{   
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal(); 
		return D.sql("select * from t_pub_attention where uid =?").oneOrNull(TPubAttention.class, loginUser.getUser_id());
		 
	}
	
	
	
	
	/*
	 * 修改新增
	 */
	@ResponseBody
	@RequestMapping(value = "/save")
	public boolean save(@RequestBody TPubAttention tPubAttention){
		System.out.println("FFFFFFFFFFFF");
		
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		tPubAttention.setUid(loginUser.getUser_id());
		tPubAttention.setWx_id(loginUser.getWxInfo().getWx_id()); 
		if(tPubAttention.getId()!=null)
		{
			return D.updateWithoutNull(tPubAttention)>0;
		}
		else
		{
			return D.insertWithoutNull(tPubAttention)>0;
		}
		
	}
	
	
	
}
