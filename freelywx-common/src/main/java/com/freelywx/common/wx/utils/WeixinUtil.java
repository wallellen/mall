package com.freelywx.common.wx.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.freelywx.common.wx.menu.Menu;
import com.freelywx.common.wx.message.WxMember;
import com.freelywx.common.wx.token.OAuthAccessToken;

import net.sf.json.JSONObject;

public class WeixinUtil {
	private static Logger log = LoggerFactory.getLogger(WeixinUtil.class);

	// 获取access_token的接口地址（GET） 限2000 （次/天）
	public final static String access_token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";

	// 菜单创建（POST） 限1000（次/天）
	public static String menu_create_url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";

	// 菜单删除（GET） 限1000（次/天）
	public static String menu_del_url = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN";

	// 获取用户信息5000000
	public static String user_info_url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID";

	// 发送微信消息500000
	public static String send_msg_url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN";

	// 网页授权
	public static String oauth_rul = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=APPSECRET&code=CODE&grant_type=authorization_code";

	// 上传文件5000
	public static String media_url = "http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE";

	//发货通知接口
	public static String delivernotify_url = "https://api.weixin.qq.com/pay/delivernotify?access_token=ACCESS_TOKEN"; 
	
	//订单查询接口
	public static String orderquery_url =  "https://api.weixin.qq.com/pay/orderquery?access_token=ACCESS_TOKEN"; 
	/**
	 * 上传文件
	 */
	public static String getMediaId(String accessToken, String type, String filePath) {
		String result = "";
		String url = media_url.replace("ACCESS_TOKEN", accessToken).replace("TYPE", type);
		Runtime runTime = Runtime.getRuntime();
		Process process;
		try {
			process = runTime.exec("curl -F media=@" + filePath + " " + url);
			StringBuffer buffer = new StringBuffer();
			InputStream in = process.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(in));
			String str = null;
			while ((str = reader.readLine()) != null) {
				buffer.append(str);
			}
			JSONObject jsonObject = JSONObject.fromObject(buffer.toString());
			log.info("jsonObject:==============================" + jsonObject);
			if (null != jsonObject) {
				String rtype = jsonObject.getString("type");
				if ("voice".equals(rtype)) {
					result = jsonObject.getString("media_id");
				} else if ("thumb".equals(rtype)) {
					result = jsonObject.getString("thumb_media_id");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}

	/**
	 * 创建菜单
	 * 
	 * @param menu
	 *            菜单实例
	 * @param accessToken
	 *            有效的access_token
	 * @return 0表示成功，其他值表示失败
	 */
	public static boolean createMenu(Menu menu, String accessToken) {
		int result = 0;
		// 拼装创建菜单的url
		String url = menu_create_url.replace("ACCESS_TOKEN", accessToken);
		// 将菜单对象转换成json字符串
		String jsonMenu = JSONObject.fromObject(menu).toString();
		System.out.println("开始打印菜单了");
		System.out.println(jsonMenu);
		System.out.println("打印菜单结束");
		// 调用接口创建菜单
		String resultStr = HttpUtil.post(url, jsonMenu);
		try{
			Map map = new ObjectMapper().readValue(resultStr, Map.class);
			result = (Integer)map.get("errcode");
			if(result != 0 ){
				log.error("创建菜单失败 errcode:{} errmsg:{}", map.get("errcode"), map.get("errmsg"));
			}
		}catch (Exception e) {
			log.error("解析菜单创建结果异常，", e);
		}
		return result == 0 ;
	}
	
	/**
	 * 创建菜单
	 * 
	 * @param menu
	 *            菜单实例
	 * @param accessToken
	 *            有效的access_token
	 * @return 0表示成功，其他值表示失败
	 */
	public static boolean delMenu(String accessToken) {
		int result = 0;

		// 拼装创建菜单的url
		String url = menu_del_url.replace("ACCESS_TOKEN", accessToken);
		// 调用接口创建菜单
		String resultStr = HttpUtil.post(url, "");
		try{
			Map map = new ObjectMapper().readValue(resultStr, Map.class);
			result = (Integer)map.get("errcode");
			if(result != 0 ){
				log.error("删除菜单失败  errcode:{} errmsg:{}", map.get("errcode"), map.get("errmsg"));
			}
		}catch (Exception e) {
			log.error("解析菜单创建结果异常，", e);
		}
		return result == 0 ;
	}

	/**
	 * 根据OpenID获取用户信息
	 * 
	 * @param OpenID
	 * @param accessToken
	 * @return
	 */
	public static WxMember getUser(String OpenID, String accessToken) {
		String url = user_info_url.replace("ACCESS_TOKEN", accessToken).replace("OPENID", OpenID);
		WxMember member = new WxMember();
		String resultStr = HttpUtil.get(url, null);
		try{
			Map map = new ObjectMapper().readValue(resultStr, Map.class);
			if(map.get("errcode")!=null)
			{
				log.error("获取微信用户信息失败  errcode:{} errmsg:{}", map.get("errcode"), map.get("errmsg"));
			}else{
				Object nickname = map.get("nickname");
				Object sex = map.get("sex");
				Object city = map.get("city");
				Object headimgurl = map.get("headimgurl");
				member.setNickname(nickname == null ? "" : Base64.encodeBase64String(String.valueOf(nickname).getBytes()));
				member.setSex(nickname == null ? "" : String.valueOf(sex));
				member.setCity(nickname == null ? "" : String.valueOf(city));
				member.setHeadimgurl(nickname == null ? "" : String.valueOf(headimgurl));
			}
		}catch (Exception e) {
			log.error("解析菜单创建结果异常，", e);
		}
		return member;
	}

	/**
	 * 网络授权方式 获取code
	 * 
	 * @param code
	 * @param appId
	 * @param appSecret
	 * @return
	 */
	public static OAuthAccessToken getOpenId(String code, String appId, String appSecret) {
		OAuthAccessToken token = null;
		Date date = new Date();
		String url = oauth_rul.replace("APPID", appId).replace("APPSECRET", appSecret).replace("CODE", code);
		String resultStr = HttpUtil.get(url, null);
		try{
			Map map = new ObjectMapper().readValue(resultStr, Map.class);
			Object result =  map.get("errcode");
			if(result != null ){
				log.error("获取code失败:errcode:{} errmsg:{}",map.get("errcode"), map.get("errmsg"));
			}else{
				token = new OAuthAccessToken();
				token.setOpenid((String) map.get("openid"));
				token.setAccess_token((String)  map.get("access_token"));
				token.setExpires_in((Integer) map.get("expires_in"));
				token.setRefresh_token( (String) map.get("refresh_token"));
				token.setScope( (String) map.get("scope"));
				token.setCode(code);
				token.setCreateTime(date);
			}
		}catch (Exception e) {
			log.error("解析菜单创建结果异常，", e);
		}
		return token;
	}

	/*public static boolean sendMsg(String toUserName, String type, String accessToken, HashMap<String, String> map) {
		boolean result = false;
		String respMessage = "";
		String url = send_msg_url.replace("ACCESS_TOKEN", accessToken);
		MessageUtil messageUtil = new MessageUtil();
		// 推送文本消息
		if (MessageUtil.RESP_MESSAGE_TYPE_TEXT.equals(type)) {
			TextMessageReq textMessage = new TextMessageReq();
			textMessage.setTouser(toUserName);
			textMessage.setMsgtype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
			textMessage.setText(map);
			respMessage = messageUtil.toJson(textMessage);
		} else if (MessageUtil.RESP_MESSAGE_TYPE_VOICE.equals(type)) {
			VoiceMessageReq voiceMessage = new VoiceMessageReq();
			voiceMessage.setMsgtype(MessageUtil.RESP_MESSAGE_TYPE_VOICE);
			voiceMessage.setTouser(toUserName);
			voiceMessage.setVoice(map);
			respMessage = messageUtil.toJson(voiceMessage);
		} else if (MessageUtil.RESP_MESSAGE_TYPE_MUSIC.equals(type)) {
			MumicMessageReq musicMessage = new MumicMessageReq();
			musicMessage.setMsgtype(MessageUtil.RESP_MESSAGE_TYPE_MUSIC);
			musicMessage.setTouser(toUserName);
			musicMessage.setMusic(map);
			respMessage = messageUtil.toJson(musicMessage);
		}
		// 推送信息
		JSONObject jsonObject = httpRequest(url, "GET", respMessage);
		if (null != jsonObject) {
			if (0 != jsonObject.getInt("errcode")) {
				log.info("发送消息errcode:{} errmsg:{}" + jsonObject.getInt("errcode") + " | "
						+ jsonObject.getString("errmsg"));
				System.out.println("发送消息errcode:{} errmsg:{}" + jsonObject.getInt("errcode") + " | "
						+ jsonObject.getString("errmsg"));
			} else {
				result = true;
			}
		}
		return result;
	}
	
	public static boolean sendTextMsg(String toUserName, String type, String accessToken, HashMap<String, Object> map) {
		boolean result = false;
		String respMessage = "";
		String url = send_msg_url.replace("ACCESS_TOKEN", accessToken);
		MessageUtil messageUtil = new MessageUtil();
		// 推送文本消息
	
		if (MessageUtil.RESP_MESSAGE_TYPE_NEWS.equals(type)) {
			PicTextMessageReq picTextMessage=new PicTextMessageReq();
			picTextMessage.setMsgtype(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
			picTextMessage.setTouser(toUserName);
			picTextMessage.setNews(map);
			respMessage = messageUtil.toJson(picTextMessage);
		}
		// 推送信息
		JSONObject jsonObject = httpRequest(url, "GET", respMessage);
		if (null != jsonObject) {
			if (0 != jsonObject.getInt("errcode")) {
				log.info("发送消息errcode:{} errmsg:{}" + jsonObject.getInt("errcode") + " | "
						+ jsonObject.getString("errmsg"));

				System.out.println("发送消息errcode:{} errmsg:{}" + jsonObject.getInt("errcode") + " | "
						+ jsonObject.getString("errmsg"));
			} else {
				result = true;
			}
		}
		return result;
	}*/
}