package com.freelywx.mall.util;

import java.io.IOException;
import java.util.Date;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.eclipse.jetty.util.UrlEncoded;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.filter.OncePerRequestFilter;

import com.freelywx.common.model.member.Member;
import com.freelywx.common.model.visit.TVVisit;
import com.freelywx.common.wx.token.OAuthAccessToken;
import com.rps.util.ClojureUtil;
import com.rps.util.D;

public class SessionFilter extends OncePerRequestFilter {
	private static final Logger log = LoggerFactory.getLogger(SessionFilter.class);

	private static String FLAG =  ClojureUtil.getString("config/flag");
	private static String MEMBER =  ClojureUtil.getString("config/member");
	private static String VISIT =  ClojureUtil.getString("config/visit");
	private static String RESPATH =  ClojureUtil.getString("config/resPath");
	private static String APPPATH =  ClojureUtil.getString("config/appPath");
	private static String HTTPURL =  ClojureUtil.getString("config/httpUrl");
	private static String APPID =  ClojureUtil.getString("config/appid");
	private static String APPSECRET =  ClojureUtil.getString("config/appsecret");
	private static String SUBSCRIBE =  ClojureUtil.getString("config/subscribe");
	
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		if (StringUtils.equals("false", FLAG)) {
			Member member = (Member) session.getAttribute("member");
			if (member == null)
				member = D.selectById(Member.class, MEMBER);
			if (member == null)
				member = D.selectAll(Member.class).get(0); 
			session.setAttribute("member", member);
			request.setAttribute("access_token", "access_token");

			filterChain.doFilter(request, response);
		} else {
			String path = request.getServletPath();
			String code = request.getParameter("code");
			String IP = request.getHeader("x-forwarded-for");

			String[] resPath = RESPATH.split(" ");
			boolean rFlag = false;
			for (String str : resPath) {
				if (path.contains(str)) {
					rFlag = true;
					break;
				}
			}
			if (rFlag) {
				filterChain.doFilter(request, response);
				return;
			}
			log.info("~~~~~ path ~~~~~" + path+"~~~~~ code ~~~~~" + code);

			OAuthAccessToken jo = null;
			if (!StringUtils.isEmpty(code))
				jo = OAuthAccessToken.getInstance(code, APPID, APPSECRET);

			if (path.contains("order/confirm") || path.contains("order/start")) {
				if (jo != null) {
					request.setAttribute("access_token", jo.getAccess_token());
				} else {
					String url = UrlEncoded.encodeString(SUBSCRIBE);
					SUBSCRIBE = HTTPURL.replace("URL", url);
					response.sendRedirect(SUBSCRIBE);
					return;
				}
			}

			Member member = (Member) session.getAttribute("member");
			log.info("~~~~~ member ~~~~~" + member);
			if (member == null) {
				log.info("session member null");
				if (StringUtils.isEmpty(code)) {
					if (!path.equals("/"))
						response.sendRedirect(SUBSCRIBE);
					return;
				} else {
					if (jo == null) {
						response.sendRedirect(SUBSCRIBE);
						return;
					}
					String openId = jo.getOpenid();
					String sql = "SELECT * FROM T_M_MEMBER WHERE MEMBER_W_ID = ?";
					member = D.sql(sql).one(Member.class, openId);
					if (member == null) {
						log.info("begin to insert member" + openId);
						member = new Member();
						member.setOpenid(openId);
						member.setMember_level(1);
						member.setStatus("1");
						member.setCreate_time(new Date());
						D.insert(member);
					}
					if (member.getMember_id() == null){
						log.info("begin to select member" + openId);
						member = D.sql(sql).one(Member.class, openId);
					}
					session.setAttribute("member", member);
				}
			}

			log.info("~~~~~ member ~~~~~" + member.getMember_id() + "|"	+ member.getStatus());

			String[] appPath = APPPATH.split(" ");
			boolean aFlag = false;
			for (String str : appPath) {
				if (path.contains(str)) {
					aFlag = true;
					break;
				}
			}
			if (aFlag) {
				if ("1".equals(member.getStatus())) {
					response.sendRedirect(SUBSCRIBE);
					return;
				}
			}

		//	visit(path, IP, member.getMember_id(), member.getOpenid());
			filterChain.doFilter(request, response);

		}
	}

	public void visit(String l, String i, Long m, String o) {
		if (StringUtils.equals("true", VISIT)) {
			TVVisit visit = new TVVisit();
			visit.setVisit_url(l);
			visit.setVisit_ip(i);
			if (m != null)
				visit.setMember_id(Integer.valueOf(m.toString()));
			if (o != null)
				visit.setOpen_id(o);
			visit.setVisit_time_in(new Date());
			D.insert(visit);
		}
	}

}
