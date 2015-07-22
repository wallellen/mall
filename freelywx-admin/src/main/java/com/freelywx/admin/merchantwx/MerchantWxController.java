package com.freelywx.admin.merchantwx;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.user.TPMerchantWx;
import com.freelywx.common.util.CodeUtil;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 用户控制器类
 * 方法上的注释为页面中Button的标题
 */
@Controller
@RequestMapping("/merchantwx/")
public class MerchantWxController {
	@RequestMapping("init")
	public String init() {
		
	//	ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
	//	return user.getMerchantWx();
		
		return "merchantwx/merchantwx";
	}
	
	

	@ResponseBody
	@RequestMapping("list")
	public PageModel SearchEmployees(HttpServletRequest request) throws Exception
	{ 		
		return PageUtil.getPageModel(TPMerchantWx.class, "sql.merchantwx/getPageMerchantWx",request);
	}
	
	
	
	/**
	 * 新增之前向表单填 入几个值
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="add_getdata")
	public TPMerchantWx add_getdata(){
		TPMerchantWx tpm=new TPMerchantWx();
		tpm.setToken(CodeUtil.getRandomString(10));
		tpm.setEncodekey(CodeUtil.getRandomString(43));
		return tpm;
	}
	
	
	
	
	@RequestMapping(value="add")
	public String toAdd(){
		return "merchantwx/merchantwx_add";
	}
	
	
	

	@RequestMapping(value="edit")
	public String edit(){
		return "merchantwx/merchantwx_edit";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "delete/{wx_id}")
	public int delete(@PathVariable("wx_id") Integer wx_id) {
		System.out.println(wx_id);
		return D.deleteById(TPMerchantWx.class, wx_id);
		 
	}
	
	
	/*
	 * 修改用户（之前）-查询用户信息
	 */
	@ResponseBody
	@RequestMapping(value = "{wx_id}")
	public TPMerchantWx get(@PathVariable("wx_id") Integer wx_id) {
		TPMerchantWx u = D.selectById(TPMerchantWx.class, wx_id);
		return u;
	}
	
	
	
	
	

	/*
	 * 添加
	 */
	@ResponseBody
	@RequestMapping(value = "addsubmit")
	public boolean addsubmit(@RequestBody final TPMerchantWx tp){
		System.out.println("VVVV");
		int wxId=D.insertAndReturnInteger(tp);
		if(wxId>0)
		{
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		//	String serverIp = IpUtil.getServerIp();
			tp.setPort_url("http://27.54.237.27/system/wxService?wxid="+wxId);
			tp.setUser_id(user.getUser_id());
			D.updateWithoutNull(tp); 
			return true;
		}
		else
		{
			return false;
		}
		
		
	}
	
	
	
	/*
	 * 修改
	 */
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(@RequestBody final TPMerchantWx user){
		try{
			if(null != user.getWx_id() && user.getWx_id() > 0 ){ 
				D.updateWithoutNull(user);
			}else{ 
				D.insert(user);
			} 
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	
	
	
	/*
	 * 修改
	 */
	@ResponseBody
	@RequestMapping("updata")
	public boolean update(@RequestBody TPMerchantWx tPMerchantWx){
		try{
			//System.out.println(tmmember.getOpen_id());
			D.updateWithoutNull(tPMerchantWx);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
}
