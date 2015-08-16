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
import com.freelywx.common.model.pub.TPubImg;
import com.freelywx.common.model.pub.TPubKeyword;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

 
@Controller
@RequestMapping("/reply/img")
public class ImgNewsController {
	@RequestMapping()
	public String init() {
		return "publish/imgNews";
	}
	 
	@RequestMapping(value="edit")
	public String edit(){
		return "publish/imgNews_edit";
	}
	
	
	
	@RequestMapping(value="select_url_tree")
	public String select_context_temp(){
		return "publish/select_url_tree";
	}
	
	
	 
	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("uid", user.getUser_id()); 
		
		return PageUtil.getPageModel(TPubImg.class, "sql.publish/getImgPage",request,map);
	}
	 
	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(String keyword,String id) {
		if(!StringUtils.isEmpty(id)){
			int keyId = Integer.parseInt(id);
			TPubImg key = D.selectById(TPubImg.class, keyId);
			if(StringUtils.equals(key.getKeyword(), keyword)){
				return true;
			}
		} 
		List<TPubKeyword> list = D.sql("select * from T_PUB_KEYWORD where keyword = ?").many(TPubKeyword.class, keyword);
		if(list != null && list.size() > 0 ){
			return false;
		}else{
			return true;
		}
	}
	 
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(@RequestBody final TPubImg img){
		try{
			if(null != img.getId() && img.getId() > 0 ){
				D.startTranSaction(new Callable() {
					@Override
					public Object call() throws Exception {
						D.updateWithoutNull(img);
						TPubKeyword keyword =  D.selectById(TPubKeyword.class,img.getId());
						keyword.setKeyword(img.getKeyword());
						keyword.setType(img.getType());
						keyword.setModule(SystemConstant.ReplyType.REPLY_GRAPHIC);
						D.updateWithoutNull(keyword);
						return true;
					}
				});
			}else{
				D.startTranSaction(new Callable() {
					@Override
					public Object call() throws Exception {
						ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
						//text.setWx_id(user.getMerchantWx().getWx_id());
						img.setUid(user.getUser_id());
						int id = D.insertAndReturnInteger(img);
						TPubKeyword keyword = new TPubKeyword();
						keyword.setKeyword(img.getKeyword());
						keyword.setContent_id(id);
						keyword.setModule(SystemConstant.ReplyType.REPLY_GRAPHIC);
						keyword.setType(img.getType());
					//	keyword.setWx_id(user.getMerchantWx().getWx_id());
						keyword.setUid(user.getUser_id());
						D.insert(keyword);
						return true;
					}
				});
				
			}
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "getImg/{id}")
	public TPubImg getText(@PathVariable("id") int id) {
		TPubImg img = D.selectById(TPubImg.class, id);
		return img;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete/{ids}")
	public boolean delete(@PathVariable("ids") final int[] ids) {
		try {
			D.startTranSaction(new Callable() {
				@Override
				public Object call() throws Exception {
					for (Integer id : ids) {
						D.deleteById(TPubImg.class, id);
						D.deleteByWhere(TPubKeyword.class, "content_id = ? and MODULE = ?",  id,SystemConstant.ReplyType.REPLY_GRAPHIC);
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
