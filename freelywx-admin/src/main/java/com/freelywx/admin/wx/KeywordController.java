package com.freelywx.admin.wx;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;

//import org.apache.shiro.SecurityUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.wx.WxAttention;
import com.freelywx.common.model.wx.WxKeyword;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
//import com.rps.util.ClojureUtil;
import com.rps.util.D;

@Controller
@Scope("session")
@RequestMapping(value = "/keyword")
public class KeywordController {

	@RequestMapping("")
	public String init(HttpServletRequest request) {
		return "publish/keyword";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageModel list(HttpServletRequest request) {
		return PageUtil.getPageModel(WxKeyword.class, "sql.publish/getPageKeyword", request );
	}

	@RequestMapping(value = "/edit")
	public String edit(WxKeyword keyword) {
		return "publish/keyword_edit";
	}
	
	@ResponseBody
	@RequestMapping(value = "/{keyword_id}")
	public WxKeyword get(@PathVariable("keyword_id") int keyword_id) {
		return D.selectById(WxKeyword.class, keyword_id);
	}
	
	/**
	 * 新增
	 * 
	 * @param request
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/save")
	public boolean create(@RequestBody WxKeyword keyword) {
		try {
			if(keyword.getKeyword_id() == null ){
				D.insert(keyword);
			}else{
				D.update(keyword);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/*
	 * 修改
	 */
	@ResponseBody
	@RequestMapping(value = "/del/{ids}")
	public boolean delete(@PathVariable("ids") final int[] ids) {
		try {
			D.startTranSaction(new Callable() {
				@Override
				public Object call() throws Exception {
					for (Integer id : ids) {
						D.deleteById(WxKeyword.class, id);
					}
					return true;
				}
			});
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 是否启用
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/editKeyword1")
	@ResponseBody
	public int editKeyword1(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		String status = request.getParameter("status");
		String[] split = ids.split(",");
		try {
			for (int i = 0; i < split.length; i++) {
				WxKeyword WxKeyword = D.selectById(WxKeyword.class, split[i]);
				WxKeyword.setStatus(status);
				D.update(WxKeyword);
			}
			return 1;
		} catch (Exception e) {
			return 0;
		}

	}

	/**
	 * 公众号下拉框
	 * 
	 * @param request
	 * @return
	 */
//	@RequestMapping("/getWxMPublic")
//	@ResponseBody
//	public List<WxMPublic> getWxMPublic(HttpServletRequest request) {
//		return D.sql(ClojureUtil.getValue("sql.publish/getWxMPublic").toString()).many(WxMPublic.class);
//	}
	/**
	 * reply_id下拉框
	 * WX_PUB_ATTENTION
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getReply_id")
	public List<WxKeyword> getReply_id(HttpServletRequest request) {
		return D.sql("select * from t_wx_keyword").many(WxKeyword.class);
	}
	
	/**
	 * 数据列表
	 * 
	 * @param request
	 * @return
	 */
	
	@RequestMapping("/getPageKeyword")
	@ResponseBody
	public PageModel getWxKeyword(HttpServletRequest request) {
//		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		HashMap<String,Object> map = new HashMap<String,Object>();
//		map.put("user_id", loginUser.getUser_id());
		map.put("keyword_id", request.getParameter("keyword_id"));
		map.put("public_id", request.getParameter("public_id"));
		map.put("keyword", request.getParameter("keyword"));
		map.put("keyword_type", request.getParameter("keyword_type"));
		return PageUtil.getPageModel(WxKeyword.class, "sql.publish/getPageKeyword", request, map);
	}

	/**
	 * 单一数据
	 * 
	 * @param request
	 * @return
	 */
	
	@ResponseBody
	@RequestMapping(value = "/getOneKeyword/{keyword_id}")
	public WxKeyword getActiveById(@PathVariable("keyword_id") Long keyword_id) {
		WxKeyword u = D.selectById(WxKeyword.class, keyword_id);
		return u;
	}


	/**
	 * 删除多条数据
	 * 
	 * @param request
	 * @return
	 */
/*	@RequestMapping("/delWxKeyword")
	@ResponseBody
	public int delWxKeyword(HttpServletRequest request) {
		String ids = request.getParameter("ids");
		String[] split = ids.split(",");
		try {
			for (int i = 0; i < split.length; i++) {
				D.deleteById(WxKeyword.class, split[i]);
				D.deleteByWhere(WxKeywordBand.class, "KEYWORD_ID = ?", split[i]);
			}
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}*/

	/**
	 * 获取所有关键词
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/listAll")
	@ResponseBody
	public List<WxKeyword> listAll(HttpServletRequest request) {
		return D.selectAll(WxKeyword.class);
	}

	/**
	 * 查询使用的关键词是否存在关键词库当中
	 */

	@RequestMapping(value = "/checkKeyword/{keyword}")
	@ResponseBody
	public boolean checkKeyword(@PathVariable(value = "keyword") String keyword) {
		return D.sql("SELECT * FROM WX_PUB_KEYWORD WHERE WX_PUB_KEYWORD.KEYWORD=?").many(WxKeyword.class, keyword)
				.isEmpty();
	}

	/*
	 * 绑定 之前
	 */
	@RequestMapping(value = "beforeband/{keyword_id}/{flag}")
	public String beforeband(@PathVariable("keyword_id") String keyword_id, @PathVariable("flag")String flag, HttpServletRequest request){
		request.setAttribute("keyword_id", keyword_id);
		request.setAttribute("flag", flag);
		return "publish/bandcontent";
	}
	
/*	@ResponseBody
	@RequestMapping(value = "/band")
	public boolean band(HttpServletRequest request, final WxKeywordBand band){
		try{
			boolean result = (Boolean) D.startTranSaction(new Callable() {
				public Object call() {
					D.deleteByWhere(WxKeywordBand.class, "KEYWORD_ID=?", band.getKeyword_id());
//					ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
					if (null != band.getContents() && !"".equals(band.getContents())){
						String[] contents = band.getContents().split(";");
						for (int i = 0; i < contents.length; i++) {
//							int order = i+1;
							int keyId = Integer.parseInt(contents[i]);
							band.setContent_id(keyId);
//							band.setOrder(order);
//							band.setUser_id(loginUser.getUser_id());
							D.insertWithoutNull(band);
						}
					}
					WxKeyword WxKeyword = D.selectById(WxKeyword.class, band.getKeyword_id());
					WxKeyword.setReply_type(band.getContent_type());
					D.update(WxKeyword);
					return true;
				}
			});
			return result;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}*/
	
	/*@ResponseBody
	@RequestMapping(value="queryband/{keyword_id}/{flag}")
	public boolean queryband(@PathVariable("keyword_id") String keyword_id, @PathVariable("flag")String flag){
		List<WxKeywordBand>bandList = D.sql("select * from WX_PUB_KEYWORD_BAND where KEYWORD_ID=? and content_type<>?").many(WxKeywordBand.class, keyword_id, flag);
		if (null != bandList && !bandList.isEmpty()){
			return true;
		}
		return false;
	}*/
	
	/**
	 * 关键字消息预览（注意：预览调用的接口与实际调用的接口不一样）
	 * @param request
	 * @return
	 */
/*	@ResponseBody
	@RequestMapping("/preview")
	public int preview(HttpServletRequest request){
//		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		String appId=null;
		String appSecret=null;
//		if (loginUser.getMerchantInfo()!=null){
//			appId = loginUser.getMerchantInfo().getApp_id();
//			appSecret=loginUser.getMerchantInfo().getApp_secret();
//		}
		
		int keyword_id=Integer.valueOf(request.getParameter("keyword_id"));
		String toUserName=request.getParameter("toUserName");
		
		//测试使用begin
		if(appId==null||appId==""||appSecret==null||appSecret==""||toUserName==null||toUserName==""){
			appId="wxda3610b3f94244d6";
			appSecret="d16587ab9ea36d703b5b22726eaf7c5d";
			toUserName="oTROJjmmwUMBxUHHfNqWG3aVt3kE";
		}
		//测试使用end
		
		List<WxKeywordBand> bandList = D.sql("select * from WX_PUB_KEYWORD_BAND where KEYWORD_ID=?").many(WxKeywordBand.class, keyword_id);
		if(bandList.size()>0){
			AccessToken accessToken=null;
			accessToken = AccessToken.getInstance(appId, appSecret);
			if(accessToken==null){
				accessToken = AccessToken.getInstance(appId, appSecret);
			}
			
			int id=bandList.get(0).getContent_id();
			String content_type=bandList.get(0).getContent_type();
			
			if(SystemConstant.ReplyType.REPLY_TEXT.equals(content_type)){
				WxPubReplyText text=D.selectById(WxPubReplyText.class, id);
				if(text!=null){
					HashMap<String, String> content = new HashMap<String, String>();
					content.put("content", text.getContent());
					boolean message=WeixinUtil.sendMsg(toUserName, "text", accessToken.getToken(), content);
					if(message){
						return 1;//发送成功
					}else{
						return 2;//发送失败
					}
				}
			}else if(SystemConstant.ReplyType.REPLY_GRAPHIC.equals(content_type)){
				WxPubReplyGraphic graphic=D.selectById(WxPubReplyGraphic.class, id);
				HashMap<String, Object> news = new HashMap<String, Object>();
				List<Article> articles = new ArrayList<Article>();
				Article article=new Article();
				article.setTitle(graphic.getTitle());
				article.setDescription(graphic.getContent());
				article.setPicUrl(graphic.getPic_url());
				article.setUrl(graphic.getLink_url());
				articles.add(article);
				news.put("articles", articles);
				boolean message=WeixinUtil.sendMsg1(toUserName, "news", accessToken.getToken(), news);
				if(message){
					return 1;//发送成功
				}else{
					return 2;//发送失败
				}
			}else{
				return 3;//回复类型异常
			}
		}
		return 0;//关键字未绑定回复
	}*/
	
//	@ResponseBody
//	@RequestMapping("/getPreviewUser")
//	public List<WxMMerchantContacts> getPreviewUser(HttpServletRequest request){
//		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
//		return D.sql("select * from WX_M_MERCHANT_CONTACTS where user_id=?").many(WxMMerchantContacts.class, loginUser.getUser_id());
//	}
	
	/**
	 * 根据回复类型查询对应的关键字
	 * @param replyType
	 * @param request
	 * @return
	 */
	@RequestMapping("/list/{replyType}")
	@ResponseBody
	public List<WxKeyword> listByType(@PathVariable("replyType") String replyType,HttpServletRequest request) {
//		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
//		return D.sql("SELECT * FROM WX_PUB_KEYWORD where status = ? and reply_type = ? and user_id = ? ").many(WxKeyword.class,SystemConstant.State.STATE_ENABLE,replyType,loginUser.getUser_id());
		return D.sql("SELECT * FROM WX_PUB_KEYWORD where status = ? and reply_type = ?").many(WxKeyword.class,SystemConstant.State.STATE_ENABLE,replyType);
	}
	
	@RequestMapping("/checkDel")
	@ResponseBody
	public int checkDel(HttpServletRequest request) {
		List<WxAttention> attentionList = D.selectAll(WxAttention.class);
		List<Integer> keywordIdList = new ArrayList<Integer>();
		for (WxAttention attention : attentionList) {
			keywordIdList.add(attention.getKeyword_id());
		}
		String ids = request.getParameter("ids");
		String[] split = ids.split(",");
		try {
			for (int i = 0; i < split.length; i++) {
				if (keywordIdList.contains(Integer.parseInt(split[i]))){
					return 0;
				}
			}
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
}
