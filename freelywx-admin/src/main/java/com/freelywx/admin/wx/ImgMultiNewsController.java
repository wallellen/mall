package com.freelywx.admin.wx;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.wx.WxImgMulti;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

@Controller
@RequestMapping("/reply/imgmulti")
public class ImgMultiNewsController {
	@RequestMapping("")
	public String init() {
		return "publish/imgmulti";
	}
	@RequestMapping(value = "edit")
	public String edit() {
		return "publish/imgmulti_edit";
	}

	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request) {
		
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("uid", user.getUser_id());
		
		 
		return PageUtil.getPageModel(WxImgMulti.class,	"sql.publish/getImgMultiPage", request,map);
	}

	/*
	 * 添加用户.后台只能创建系统用户。
	 */
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(HttpServletRequest req) {
		try {
			String ids = req.getParameter("ids");
			String title = req.getParameter("title");
			final WxImgMulti tPubImgMulti = new WxImgMulti();
			tPubImgMulti.setImgids(ids);
			tPubImgMulti.setTitle(title);
			
			String id = req.getParameter("id");
			if(StringUtils.isEmpty(id)){
				 D.insertAndReturnInteger(tPubImgMulti);
			}else{
				tPubImgMulti.setId(Integer.parseInt(req.getParameter("id")));
				D.updateWithoutNull(tPubImgMulti);
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
