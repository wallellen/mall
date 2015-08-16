package com.freelywx.admin.wx;
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
import com.freelywx.common.model.wx.WxImg;
import com.freelywx.common.model.wx.WxImgMulti;
import com.freelywx.common.model.wx.WxKeyword;
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
		
		 
		return PageUtil.getPageModel(WxImgMulti.class,
				"sql.publish/getImgMultiPage", request,map);
	}

	@ResponseBody
	@RequestMapping(value = "check")
	public boolean check(String keyword, String id) {
		if (!StringUtils.isEmpty(id)) {
			int keyId = Integer.parseInt(id);
			WxImg key = D.selectById(WxImg.class, keyId);
			if (key == null) {
				return true;
			}
		}
		List<WxKeyword> list = D.sql(
				"select * from T_PUB_KEYWORD where keyword = ?").many(
				WxKeyword.class, keyword);
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
			final WxImgMulti tPubImgMulti = new WxImgMulti();
			tPubImgMulti.setImgids(ids);
			
			String id = req.getParameter("id");
			if(StringUtils.isEmpty(id)){
				D.startTranSaction(new Callable() {
					@Override
					public Object call() throws Exception {
						int keyId = D.insertAndReturnInteger(tPubImgMulti);
						WxKeyword keyword = new WxKeyword();
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
						WxKeyword keyword =  D.selectById(WxKeyword.class,tPubImgMulti.getId());
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
	public WxImgMulti getText(@PathVariable("id") int id) {
		WxImgMulti img = D.selectById(WxImgMulti.class, id);
		return img;
	}

	@ResponseBody
	@RequestMapping(value = "/delete/{id}")
	public boolean delete(@PathVariable("id") final int id) {
		try {
			return D.deleteById(WxImgMulti.class, id)>0;
		} catch (Exception e) {
			return false;
		}
	}
}
