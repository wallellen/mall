package com.freelywx.admin.wx;

import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.wx.WxAttention;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 关注控制器类
 */
@Controller
@RequestMapping("/attention")
public class AttentionController {

	@RequestMapping("")
	public String init() {
		return "publish/attention";
	}
	
	@RequestMapping(value="edit")
	public String edit(){
		return "publish/attention_edit";
	}
	

	@ResponseBody
	@RequestMapping("/list")
	public PageModel list(HttpServletRequest request)   {
		return PageUtil.getPageModel(WxAttention.class, "sql.publish/getAttentionPage",request);
	}
	
	@ResponseBody
	@RequestMapping(value = "/{attentionId}")
	public WxAttention getText(@PathVariable("attentionId") int attentionId) {
		return  D.selectById(WxAttention.class, attentionId);
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete/{ids}")
	public boolean delete(@PathVariable("ids") final int[] ids) {
		try {
			D.startTranSaction(new Callable() {
				@Override
				public Object call() throws Exception {
					for (Integer id : ids) {
						D.deleteById(WxAttention.class, id);
					}
					return true;
				}
			});
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	

	/*
	 * 修改新增
	 */
	@ResponseBody
	@RequestMapping(value = "/save")
	public boolean save(@RequestBody WxAttention wxAttention) {

		if (wxAttention.getAttention_id() != null) {
			return D.updateWithoutNull(wxAttention) > 0;
		} else {
			return D.insertWithoutNull(wxAttention) > 0;
		}

	}

}
