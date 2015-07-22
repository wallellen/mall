package com.freelywx.admin.member;

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
import com.freelywx.common.model.member.MemberRule;
import com.freelywx.common.util.ComboxModel;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.rps.util.D;

/**
 * 会员规则
 * 
 * @author ghl
 * 
 */
@Controller
@RequestMapping(value = "/member/rule")
public class MemberRuleController {

	@RequestMapping("/index")
	public String index()   {
		return "member/rule/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(MemberRule.class, "sql.member/getMemberRuleList", request);
		return page;
	}

	@RequestMapping("/edit")
	public String edit(HttpServletRequest request) {
		return "member/rule/edit";
	}

	@RequestMapping("/getEditR")
	@ResponseBody
	public MemberRule getEditR(HttpServletRequest request) {
		Long rule_id = Long.valueOf(request.getParameter("rule_id"));
		MemberRule editR = D.selectById(MemberRule.class, rule_id);
		return editR;
	}

	@RequestMapping("/save")
	@ResponseBody
	public boolean save(@RequestBody MemberRule memberRule, HttpServletRequest request) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if (memberRule.getRule_id() != null && memberRule.getRule_id().intValue() != 0) {
			memberRule.setLast_update_time(new Date());
			memberRule.setLast_updated_by(user.getUser_id());
			D.updateWithoutNull(memberRule);
		} else {
			memberRule.setCreate_time(new Date());
			memberRule.setCreated_by(user.getUser_id());
			D.insert(memberRule);
		}
		return true;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public boolean delete(HttpServletRequest request) {
		Long rule_id = Long.valueOf(request.getParameter("rule_id"));
		D.deleteById(MemberRule.class, rule_id);
		return true;
	}

	@RequestMapping("/checkName")
	@ResponseBody
	public boolean checkName(MemberRule memberRule, HttpServletRequest request) {

		String sql = "SELECT rule_id FROM T_M_RULE WHERE rule_id <> ? and rule_name = ?";
		List<MemberRule> list = D.sql(sql).many(MemberRule.class, memberRule.getRule_id(), memberRule.getRule_name());
		if (list != null && list.size() > 0) {
			// 存在重复名称的情况
			return false;
		}
		return true;
	}

	@RequestMapping("/getMemberRuleMap")
	@ResponseBody
	public List<ComboxModel> getMemberRuleMap(HttpServletRequest request) {
		return D.sqlAt("sql.member/getMemberRuleMap").many(ComboxModel.class);
	}
}
