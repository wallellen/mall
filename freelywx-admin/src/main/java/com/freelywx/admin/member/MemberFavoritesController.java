package com.freelywx.admin.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.member.MemberFavorites;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;

 
@Controller
@RequestMapping(value = "/member/favorites")
public class MemberFavoritesController {

	@RequestMapping("/index")
	public String index()   {
		return "member/favorites/index";
	}

	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request, HttpServletResponse response) {
		PageModel page = PageUtil.getPageModel(MemberFavorites.class, "sql.member/getMemberFavoritesList", request);
		return page;
	}
}
