package com.freelywx.admin.interal;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.interal.IntegralCycle;
import com.freelywx.common.util.ComboxModel;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 积分规则
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/integral/type")
public class InteralTypeController {

	@RequestMapping("")
	public String index()  {
		return "integral/type/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(IntegralCycle.class, "sql.integral/getCycleTypeList", request);
		return page;
	}

	@RequestMapping("/edit")
	public String edit(HttpServletRequest request) {
		return "integral/type/edit";
	}
	
	
	@RequestMapping("/getCycle")
	@ResponseBody
	public IntegralCycle getEditR(HttpServletRequest request) {
		int interal_exchange_id = Integer.parseInt(request.getParameter("cycle_id"));
		IntegralCycle editR = D.selectById(IntegralCycle.class, interal_exchange_id);
		return editR;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean save(@RequestBody IntegralCycle integralCycle, HttpServletRequest request) {
		//User user = (User) R.getSession(request, "user");
		if (integralCycle.getCycle_id() != null && integralCycle.getCycle_id().intValue() != 0) {
			D.updateWithoutNull(integralCycle);
		} else {
			D.insert(integralCycle);
		}
		return true;
	}
	
	@RequestMapping("/comboBox")
	@ResponseBody
	public List<ComboxModel> comboBox(HttpServletRequest request, HttpServletResponse response) {
		List<ComboxModel> comboList = new ArrayList<ComboxModel>();
		String sql = "select * from t_integral_cycle order by cycle_id";
		List<IntegralCycle> list = D.selectAll(IntegralCycle.class);
		for(IntegralCycle cycle : list){
			ComboxModel model = new ComboxModel();
			model.setId(cycle.getCycle_id());
			model.setText(cycle.getCycle_name());
			comboList.add(model);
		}
		return comboList;
	}
	
	
}
