package com.freelywx.admin.wx;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.wx.WxKeyword;
import com.freelywx.common.model.wx.WxText;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

 
@Controller
@RequestMapping("/reply/text")
public class TextController {
	@RequestMapping()
	public String init() {
		return "publish/text";
	}
	 
	@RequestMapping(value="edit")
	public String edit(){
		return "publish/text_edit";
	}
	
	 
	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request) {
		
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("uid", user.getUser_id());
		return PageUtil.getPageModel(WxText.class, "sql.publish/getTextPage",request,map);
	}
	 
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(@RequestBody final WxText text){
		try{
			if(null != text.getId() && text.getId() > 0 ){
				D.updateWithoutNull(text);
			}else{
				D.insertAndReturnInteger(text);
			}
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	 
	
	@ResponseBody
	@RequestMapping(value = "getText/{id}")
	public WxText getText(@PathVariable("id") int id) {
		WxText text = D.selectById(WxText.class, id);
		return text;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete/{ids}")
	public boolean delete(@PathVariable("ids") final int[] ids) {
		try {
			D.startTranSaction(new Callable() {
				@Override
				public Object call() throws Exception {
					for (Integer id : ids) {
						D.deleteById(WxText.class, id);
					}
					return true;
				}
			});
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
