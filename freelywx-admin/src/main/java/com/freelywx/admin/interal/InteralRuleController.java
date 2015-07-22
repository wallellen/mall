package com.freelywx.admin.interal;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.common.model.interal.InteralRule;
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
@RequestMapping(value = "/interal/rule")
public class InteralRuleController {

	@RequestMapping("")
	public String index() {
		return "interal/rule/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(InteralRule.class, "sql.interal/getInteralRuleList", request);
		return page;
	}

	@RequestMapping("/edit")
	public String edit(HttpServletRequest request) {
		return "interal/rule/edit";
	}

	@RequestMapping("/getEditR")
	@ResponseBody
	public InteralRule getEditR(HttpServletRequest request) {
		Long interal_rule_id = Long.valueOf(request.getParameter("interal_rule_id"));
		InteralRule editR = D.selectById(InteralRule.class, interal_rule_id);
		return editR;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean save(@RequestBody InteralRule interalRule, HttpServletRequest request) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if (interalRule.getInteral_rule_id() != null && interalRule.getInteral_rule_id().intValue() != 0) {
			interalRule.setLast_update_time(new Date());
			interalRule.setLast_updated_by(user.getUser_id());
			D.updateWithoutNull(interalRule);
		} else {
			interalRule.setInteral_rule_id(null);
			interalRule.setCreate_time(new Date());
			interalRule.setCreated_by(user.getUser_id());
			D.insert(interalRule);
		}
		return true;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public boolean delete(HttpServletRequest request) {
		Long interal_rule_id = Long.valueOf(request.getParameter("interal_rule_id"));
		D.deleteById(InteralRule.class, interal_rule_id);
		return true;
	}

	@RequestMapping("/checkName")
	@ResponseBody
	public boolean checkName(InteralRule interalRule, HttpServletRequest request) {

		String sql = "SELECT interal_rule_id FROM T_I_INTERAL_RULE WHERE interal_rule_id <> ? and interal_rule_name = ?";
		List<InteralRule> list = D.sql(sql).many(InteralRule.class, interalRule.getInteral_rule_id(),
				interalRule.getInteral_rule_name());
		if (list != null && list.size() > 0) {
			// 存在重复名称的情况
			return false;
		}
		return true;
	}
}
