package com.freelywx.admin.adv;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.config.Config;
import com.freelywx.common.model.advertise.TaAdvertisement;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 广告栏目信息
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "/adv/advertise")
public class AdvertiseController {

	@RequestMapping("")
	public String init()  {
		return "adv/advert/advert";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response){
		PageModel page = PageUtil.getPageModel(TaAdvertisement.class, "sql.advert/getAdvertList", request);
		return page;
	}
	
	/**
	 * 跳转
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/edit")
	public String editCategory(HttpServletRequest request,Model model) {
		model.addAttribute("server_url",Config.SERVER_BASE);
		return "adv/advert/editAdvert";
	}
	
	/**
	 * 获取修改详情
	 * 
	 * @param categoryId
	 * @return
	 */
	@RequestMapping("/editData")
	@ResponseBody
	public TaAdvertisement getCategory(HttpServletRequest request) {
		try {
			Long ad_id = Long.valueOf(request.getParameter("ad_id"));
			return D.selectById(TaAdvertisement.class, ad_id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public boolean saveCategory(@RequestBody TaAdvertisement advert, HttpServletRequest request) {
		try {
			if (advert.getAd_id()!= null) {
				D.updateWithoutNull(advert);
			} else {
				D.insert(advert);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public HashMap<String, String> deleteBrand(HttpServletRequest request) {
		final HashMap<String, String> map = new HashMap<String, String>();
		try {
			Long ad_id = Long.valueOf(request.getParameter("ad_id"));
			D.deleteById(TaAdvertisement.class, ad_id);
			map.put("status", "2");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "0");
		}
		return map;
	}
	
}
