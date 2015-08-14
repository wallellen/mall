package com.freelywx.admin.publish;

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
import com.freelywx.common.model.pub.TPubKeyword;
import com.freelywx.common.model.pub.TPubText;
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
		return PageUtil.getPageModel(TPubText.class, "sql.publish/getTextPage",request,map);
	}
	 
	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(String keyword,String id) {
		if(!StringUtils.isEmpty(id)){
			int keyId = Integer.parseInt(id);
			TPubText key = D.selectById(TPubText.class, keyId);
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
	public boolean save(@RequestBody final TPubText text){
		try{
			if(null != text.getId() && text.getId() > 0 ){
				D.startTranSaction(new Callable() {
					@Override
					public Object call() throws Exception {
						D.updateWithoutNull(text);
						TPubKeyword keyword =  D.selectById(TPubKeyword.class,text.getId());
						keyword.setKeyword(text.getKeyword());
						keyword.setType(text.getType());
						keyword.setModule(SystemConstant.ReplyType.REPLY_TEXT);
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
						text.setUid(user.getUser_id());
						int id = D.insertAndReturnInteger(text);
						TPubKeyword keyword = new TPubKeyword();
						keyword.setKeyword(text.getKeyword());
						keyword.setContent_id(id);
						keyword.setModule(SystemConstant.ReplyType.REPLY_TEXT);
						keyword.setType(text.getType());
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
	@RequestMapping(value = "getText/{id}")
	public TPubText getText(@PathVariable("id") int id) {
		TPubText text = D.selectById(TPubText.class, id);
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
						D.deleteById(TPubText.class, id);
						D.deleteByWhere(TPubKeyword.class, "content_id = ? and MODULE = ?",  id,SystemConstant.ReplyType.REPLY_TEXT);
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