package com.freelywx.admin.publish;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.pub.TPubImg;
import com.freelywx.common.model.pub.TPubImgMulti;
import com.freelywx.common.model.pub.TPubKeyword;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

@Controller
@RequestMapping("/reply/imgmulti")
public class ImgMultiNewsController {
	@RequestMapping("init")
	public String init() {
		return "publish/imgmulti/imgmulti";
	}
	@RequestMapping(value = "edit")
	public String edit() {
		return "publish/imgmulti/imgmulti_edit";
	}

	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request) {
		
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("uid", user.getUser_id());
		
		 
		return PageUtil.getPageModel(TPubImgMulti.class,
				"sql.publish/getImgMultiPage", request,map);
	}

	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(String keyword, String id) {
		if (!StringUtils.isEmpty(id)) {
			int keyId = Integer.parseInt(id);
			TPubImg key = D.selectById(TPubImg.class, keyId);
			if (StringUtils.equals(key.getKeyword(), keyword)) {
				return true;
			}
		}
		List<TPubKeyword> list = D.sql(
				"select * from T_PUB_KEYWORD where keyword = ?").many(
				TPubKeyword.class, keyword);
		if (list != null && list.size() > 0) {
			return false;
		} else {
			return true;
		}
	}

	/*
	 * 添加用户.后台只能创建系统用户。
	 */
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(HttpServletRequest req) {
		try {
			String ids = req.getParameter("ids");
			String key = req.getParameter("keyword");
			final ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			final TPubImgMulti tPubImgMulti = new TPubImgMulti();
			tPubImgMulti.setImgids(ids);
			tPubImgMulti.setKeyword(key);
			tPubImgMulti.setUid(user.getUser_id());
			tPubImgMulti.setWx_id(user.getWxInfo().getWx_id());
			
			String id = req.getParameter("id");
			if(StringUtils.isEmpty(id)){
				D.startTranSaction(new Callable() {
					@Override
					public Object call() throws Exception {
						int keyId = D.insertAndReturnInteger(tPubImgMulti);
						TPubKeyword keyword = new TPubKeyword();
						keyword.setKeyword(tPubImgMulti.getKeyword());
						keyword.setContent_id(keyId);
						keyword.setModule(SystemConstant.ReplyType.REPLY_GRAPHIC_MULTI);
						keyword.setType(SystemConstant.MatchType.COMPLETE);
						keyword.setWx_id(user.getWxInfo().getWx_id());
						keyword.setUid(user.getUser_id());
						D.insert(keyword);
						return true;
					}
				});
			}else{
				tPubImgMulti.setId(Integer.parseInt(req.getParameter("id")));
				D.startTranSaction(new Callable() {
					@Override
					public Object call() throws Exception {
						D.updateWithoutNull(tPubImgMulti);
						TPubKeyword keyword =  D.selectById(TPubKeyword.class,tPubImgMulti.getId());
						keyword.setKeyword(tPubImgMulti.getKeyword());
						keyword.setModule(SystemConstant.ReplyType.REPLY_GRAPHIC_MULTI);
						D.updateWithoutNull(keyword);
						return true;
					}
				});
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	
	/**
	 * 得到单个的多图文的信息
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getImgMulti/{id}")
	public TPubImgMulti getText(@PathVariable("id") int id) {
		TPubImgMulti img = D.selectById(TPubImgMulti.class, id);
		return img;
	}

	@ResponseBody
	@RequestMapping(value = "/delete/{id}")
	public boolean delete(@PathVariable("id") final int id) {
		try {
			return D.deleteById(TPubImgMulti.class, id)>0;
		} catch (Exception e) {
			return false;
		}
	}
}
