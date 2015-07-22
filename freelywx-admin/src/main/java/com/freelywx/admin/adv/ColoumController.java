package com.freelywx.admin.adv;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.config.Config;
import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.advertise.TaAdvertisement;
import com.freelywx.common.model.advertise.TaColoum;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 广告栏目信息
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "/adv/coloum")
public class ColoumController {

	@RequestMapping("")
	public String init()   {
		return "adv/coloum/coloum";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response){
		PageModel page = PageUtil.getPageModel(TaColoum.class, "sql.coloum/getColoumList", request);
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
		model.addAttribute("server_url", Config.SERVER_BASE);
		return "adv/coloum/editColoum";
	}
	
	/**
	 * 获取修改详情
	 * 
	 * @param categoryId
	 * @return
	 */
	@RequestMapping("/editData")
	@ResponseBody
	public TaColoum getCategory(HttpServletRequest request) {
		try {
			Long coloum_id = Long.valueOf(request.getParameter("coloum_id"));
			return D.selectById(TaColoum.class, coloum_id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public boolean saveCategory(@RequestBody TaColoum coloum, HttpServletRequest request) {
		try {
			if (coloum.getColoum_id() != null) {
				D.updateWithoutNull(coloum);
			} else {
				D.insert(coloum);
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
			Long coloum_id = Long.valueOf(request.getParameter("coloum_id"));
			List<TaAdvertisement> advertList = D.sql("select * from T_A_ADVERTISEMENT where coloum_id=?").many(TaAdvertisement.class, coloum_id);
			if (advertList != null && !advertList.isEmpty()){
				map.put("status", "1");
			}else{
				D.deleteById(TaColoum.class, coloum_id);
				map.put("status", "2");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("status", "0");
		}
		return map;
	}
	
	@RequestMapping("/coloumlist")
	@ResponseBody
	public List<TaColoum> coloumList(){
		return D.sql("select * from T_A_COLOUM where status=?").many(TaColoum.class, SystemConstant.EnableState.ENABLE);
	}
}
