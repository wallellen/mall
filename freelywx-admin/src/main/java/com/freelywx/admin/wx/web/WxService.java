//package com.freelywx.admin.wx.web;
//import java.io.UnsupportedEncodingException;
//import java.net.URLEncoder;
//import java.util.Arrays;
//import java.util.Date;
//import java.util.List;
//
//import org.apache.commons.lang3.StringUtils;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.stereotype.Component;
//
//import com.freelywx.admin.wx.api.AccessTokenApi;
//import com.freelywx.admin.wx.message.WxMember;
//import com.freelywx.admin.wx.msg.in.InTextMsg;
//import com.freelywx.admin.wx.msg.out.OutMsg;
//import com.freelywx.admin.wx.msg.out.OutNewsMsg;
//import com.freelywx.admin.wx.msg.out.OutTextMsg;
//import com.freelywx.admin.wx.token.AccessToken;
//import com.freelywx.admin.wx.utils.HttpUtil;
//import com.freelywx.admin.wx.utils.WeixinUtil;
//import com.freelywx.common.cache.WxCache;
//import com.freelywx.common.cache.WxMenuCache;
//import com.freelywx.common.config.SystemConstant;
//import com.freelywx.common.model.member.Member;
//import com.freelywx.common.model.pub.TPubImg;
//import com.freelywx.common.model.pub.TPubImgMulti;
//import com.freelywx.common.model.pub.TPubKeyword;
//import com.freelywx.common.model.pub.TPubText;
//import com.freelywx.common.model.sys.TPMerchantWx;
//import com.rps.util.D;
//import com.rps.util.SpringContextUtil;
//
//@Component
//public class WxService {
// 
//	private static final Logger logger = LoggerFactory.getLogger(WxServiceController.class);
//	public static WxCache cache = SpringContextUtil.getBean("wxCache");
//	public static WxMenuCache menuCache = SpringContextUtil.getBean("menuCache");
//	/**
//	 * 取消关注更新会员信息
//	 * @param fUser
//	 * @param tUser
//	 */
//	public static void updateMember(final String fUser, final String tUser){
//		//WxCache cache = new WxCache();
//		try {
//			TPMerchantWx merchantWx = cache.get(fUser);
//			if(merchantWx != null ){
//				Member member = D.sql("select * from t_m_member where open_id = ?  and wx_id = ? ").oneOrNull(Member.class, tUser,merchantWx.getWx_id());
//				if(member != null &&  StringUtils.equals(SystemConstant.Yesorno.YES, member.getStatus())){
//					member.setLast_update_time(new Date());
//					member.setStatus(SystemConstant.Yesorno.NO);
//					D.updateWithoutNull(member);	
//				}
//			}else{
//				logger.error("get merchantwx info err(focus off err) : "+fUser);
//			}
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	/**
//	 * 关注保存或者更新用户信息
//	 * @param fUser
//	 * @param tUser
//	 */
//	public static void addMember(final String fUser, final String tUser){
//		WxCache cache = new WxCache();
//		try {
//			TPMerchantWx merchantWx = cache.get(fUser);
//			if(merchantWx != null ){
//				doAddMember(fUser, tUser, merchantWx);
//			}else{
//				logger.error("get merchantwx info err(focus on err) : "+fUser);
//			}
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	
//	/**
//	 * 关键字回复的方法
//	 * @param inTextMsg
//	 * @return
//	 */
//	public static OutMsg geOutMsgBykey(InTextMsg inTextMsg) {
//		String keyinfo = inTextMsg.getContent().trim();
//		logger.info("keyinfo:"+keyinfo);
//		OutMsg outMsg = null ; 
//		List<TPubKeyword> list = D.sql("SELECT * FROM t_pub_keyword WHERE   KEYWORD like ? order by keyword_id desc ").many(TPubKeyword.class,"%" + keyinfo+"%");
//		logger.info("list listSize:"+list.size());
//		if(list != null && list.size()>0){
//			TPubKeyword key = null;
//			for(TPubKeyword keyword : list){
//				if(StringUtils.equals(keyword.getType(), SystemConstant.MatchType.COMPLETE) && StringUtils.equals(keyword.getKeyword(), keyinfo)){
//					key = keyword ; 
//					break; 
//				}else if(!StringUtils.equals(keyword.getType(), SystemConstant.MatchType.COMPLETE) ){
//					key = keyword ; 
//					break;
//				}
//			}
//			if(key != null ){
//				if(StringUtils.equals(key.getModule(), SystemConstant.ReplyType.REPLY_TEXT)){
//					outMsg = getText(inTextMsg,key);
//				}else if(StringUtils.equals(key.getModule(), SystemConstant.ReplyType.REPLY_GRAPHIC)){
//					outMsg = getImgNews(inTextMsg,key);
//				} else if(StringUtils.equals(key.getModule(), SystemConstant.ReplyType.REPLY_GRAPHIC_MULTI)){
//					outMsg = getMultiImgNews(inTextMsg,key);
//				} 
//			}
//		} 
//		else	//用户发的文字不是关键字则动用聊天机器人
//		{
//			try {
//				String resultStr = HttpUtil.post("http://dev.skjqr.com/api/weixin.php?email=1208447198@qq.com&appkey=ef05d20c4944c2d45187422ff7c74901&msg="+URLEncoder.encode(keyinfo, "GBK"), "");
//				if(resultStr!=null&&!"".equals(resultStr))
//				{
//					String str=resultStr.substring(resultStr.indexOf("[msg]")+5, resultStr.indexOf("[/msg]"));
//					if(str!=null&&!"".equals(str))
//					{
//						OutTextMsg outMsg1 = new OutTextMsg(inTextMsg);
//						outMsg1.setContent(str);
//						return outMsg1;
//					}
//				}
//			} catch (UnsupportedEncodingException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//		return outMsg;
//	}
//	
//	/*private static OutNewsMsg getMusicNews(InTextMsg inTextMsg,TPubKeyword keyword) {
//		TPubImg img = D.selectById(TPubImg.class, keyword.getKeyword_id());
//		OutNewsMsg outMsg = new OutNewsMsg(inTextMsg);
//		if(img != null ){
//			outMsg.addNews(img.getTitle(), img.getRemark(), img.getPic(), img.getUrl());
//		}
//		return outMsg;
//	}*/
//
//	private static OutNewsMsg getMultiImgNews(InTextMsg inTextMsg,TPubKeyword keyword) {
//		TPubImgMulti imgMulti = D.selectById(TPubImgMulti.class, keyword.getContent_id());
//		OutNewsMsg outMsg = new OutNewsMsg(inTextMsg);
//		if(imgMulti != null ){
//			String[] idArr = imgMulti.getImgids().split(",");
//			//Array.
//			List<String>  isList = Arrays.asList(idArr);
//			List<TPubImg> imgList = D.templateAt("sql.publish/getImgByIds", isList).list(TPubImg.class);
//			for(TPubImg img : imgList){
//				outMsg.addNews(img.getTitle(), img.getRemark(), img.getPic(), img.getUrl());
//			}
//		}
//		return outMsg;
//	}
//	private static OutNewsMsg getImgNews(InTextMsg inTextMsg,TPubKeyword keyword) {
//		TPubImg img = D.selectById(TPubImg.class, keyword.getContent_id());
//		OutNewsMsg outMsg = new OutNewsMsg(inTextMsg);
//		if(img != null ){
//			outMsg.addNews(img.getTitle(), img.getRemark(), img.getPic(), img.getUrl());
//		}
//		return outMsg;
//	}
//
//	private static OutMsg getText(InTextMsg inTextMsg,TPubKeyword key) {
//		TPubText text = D.selectById(TPubText.class, key.getContent_id());
//		OutTextMsg outMsg = new OutTextMsg(inTextMsg);
//		if(text != null ){
//			outMsg.setContent(text.getContent());
//		}
//		return outMsg;
//	}
//	
//	private static void doAddMember(final String fUser, final String tUser,
//			TPMerchantWx merchantWx) {
//		Member member = D.sql("select * from t_m_member where open_id = ?  and wx_id = ? ").oneOrNull(Member.class, tUser,merchantWx.getWx_id());
//		if(member == null ||  StringUtils.equals(SystemConstant.Yesorno.NO, member.getStatus())){
//			AccessToken at = AccessTokenApi.getAccessToken(merchantWx.getApp_id(), merchantWx.getApp_secret());
//			WxMember wxm = WeixinUtil.getUser(fUser, at.getAccessToken());
//			if(member != null ){ 
//				member.setLast_update_time(new Date());
//				member.setStatus(SystemConstant.Yesorno.YES);
//				if(wxm != null){
//					String nick = wxm.getNickname();
//					if(nick != null){
//						member.setMember_name(nick);
//					}
//					member.setMember_sex(wxm.getSex());
//					member.setMember_img(wxm.getHeadimgurl());
//					member.setMember_city(wxm.getCity());
//				}
//				 D.updateWithoutNull(member);	
//			}else{
//				member = new Member();
//				member.setUid(merchantWx.getUser_id());
//				member.setOpen_id(tUser);
//				member.setCreate_time(new Date());
//				member.setStatus(SystemConstant.Yesorno.YES);
//				member.setMember_level(1);
//				if(wxm != null){
//					String nick = wxm.getNickname();
//					if(nick != null){
//						member.setMember_name(nick);
//					}
//					member.setMember_sex(wxm.getSex());
//					member.setMember_img(wxm.getHeadimgurl());
//					member.setMember_city(wxm.getCity());
//				}
//				D.insert(member);
//			}
//		}
//	}
//	
//}
