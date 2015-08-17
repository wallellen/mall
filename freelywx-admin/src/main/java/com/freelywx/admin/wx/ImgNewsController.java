package com.freelywx.admin.wx;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.wx.WxImg;
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
	 
	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("uid", user.getUser_id()); 
		
		return PageUtil.getPageModel(WxImg.class, "sql.publish/getImgPage",request,map);
	}
	
	@ResponseBody
	@RequestMapping(value = "listAll")
	public List<WxImg> listAll() {
		return D.selectAll(WxImg.class);
	}
	 
	@ResponseBody
	@RequestMapping(value = "save")
	public boolean save(@RequestBody final WxImg img){
		try{
			if(null != img.getId() && img.getId() > 0 ){
				D.updateWithoutNull(img);
			}else{
				D.insertAndReturnInteger(img);
			}
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "getImg/{id}")
	public WxImg getText(@PathVariable("id") int id) {
		WxImg img = D.selectById(WxImg.class, id);
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
						D.deleteById(WxImg.class, id);
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
