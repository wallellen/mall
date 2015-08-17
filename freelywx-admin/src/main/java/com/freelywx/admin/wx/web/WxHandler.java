package com.freelywx.admin.wx.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.freelywx.common.config.SystemConstant;
import com.freelywx.common.model.member.Member;
import com.freelywx.common.model.wx.WxAttention;
import com.freelywx.common.model.wx.WxInfo;
import com.freelywx.common.wx.api.AccessTokenApi;
import com.freelywx.common.wx.message.WxMember;
import com.freelywx.common.wx.msg.OutMsgXmlBuilder;
import com.freelywx.common.wx.msg.in.InImageMsg;
import com.freelywx.common.wx.msg.in.InLinkMsg;
import com.freelywx.common.wx.msg.in.InLocationMsg;
import com.freelywx.common.wx.msg.in.InMsg;
import com.freelywx.common.wx.msg.in.InTextMsg;
import com.freelywx.common.wx.msg.in.InVideoMsg;
import com.freelywx.common.wx.msg.in.InVoiceMsg;
import com.freelywx.common.wx.msg.in.event.InFollowEvent;
import com.freelywx.common.wx.msg.in.event.InLocationEvent;
import com.freelywx.common.wx.msg.in.event.InMenuEvent;
import com.freelywx.common.wx.msg.in.event.InQrCodeEvent;
import com.freelywx.common.wx.msg.in.speech_recognition.InSpeechRecognitionResults;
import com.freelywx.common.wx.msg.out.OutImageMsg;
import com.freelywx.common.wx.msg.out.OutMsg;
import com.freelywx.common.wx.msg.out.OutNewsMsg;
import com.freelywx.common.wx.msg.out.OutTextMsg;
import com.freelywx.common.wx.msg.out.OutVoiceMsg;
import com.freelywx.common.wx.utils.WeixinUtil;
import com.rps.util.D;

public class WxHandler {
	private static Logger log = LoggerFactory.getLogger(WxHandler.class);
	public static ExecutorService cachedThreadPool = Executors.newFixedThreadPool(10);  
	public static String handleRequest(HttpServletRequest request) {
		String respMessage = "";
		String xmlStr = readIncommingRequestData(request);
		InMsg msg = null;
		try {
			msg = getInMsgXml(xmlStr);
			if (msg instanceof InTextMsg)
				respMessage =processInTextMsg((InTextMsg)msg);
			else if (msg instanceof InImageMsg)
				respMessage =processInImageMsg((InImageMsg)msg);
			else if (msg instanceof InVoiceMsg)
				respMessage =processInVoiceMsg((InVoiceMsg)msg);
			else if (msg instanceof InVideoMsg)
				respMessage =processInVideoMsg((InVideoMsg)msg);
			else if (msg instanceof InLocationMsg)
				respMessage =processInLocationMsg((InLocationMsg)msg);
			else if (msg instanceof InLinkMsg)
				respMessage =processInLinkMsg((InLinkMsg)msg);
			else if (msg instanceof InFollowEvent)
				respMessage =processInFollowEvent((InFollowEvent)msg);
			else if (msg instanceof InQrCodeEvent)
				respMessage =processInQrCodeEvent((InQrCodeEvent)msg);
			else if (msg instanceof InLocationEvent)
				respMessage =processInLocationEvent((InLocationEvent)msg);
			else if (msg instanceof InMenuEvent)
				respMessage =processInMenuEvent((InMenuEvent)msg,xmlStr);
			else if (msg instanceof InSpeechRecognitionResults)
				respMessage =processInSpeechRecognitionResults((InSpeechRecognitionResults)msg,xmlStr);
			else
				log.error("未能识别的消息类型。 消息 xml 内容为：\n" +xmlStr );
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return respMessage;
	}
	
	
	
	
	
	public static InMsg getInMsgXml(String inMsgXml) throws DocumentException {
		InMsg  msg = doParse(inMsgXml);
		// 是否需要解密消息
		/*if (ApiConfigKit.getApiConfig().isEncryptMessage()) {
			inMsgXml = MsgEncryptKit.decrypt(inMsgXml, getPara("timestamp"), getPara("nonce"), getPara("msg_signature"));
		}	*/
		return msg;
	}
	
	public static String readIncommingRequestData(HttpServletRequest request) {
		BufferedReader br = null;
		try {
			StringBuilder result = new StringBuilder();
			br = request.getReader();
			for (String line=null; (line=br.readLine())!=null;) {
				result.append(line).append("\n");
			}
			
			return result.toString();
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		finally {
			if (br != null)
				try {br.close();} catch (IOException e) {e.printStackTrace();}
		}
	}
	
	private static InMsg doParse(String xml) throws DocumentException {
		Document doc = DocumentHelper.parseText(xml);
        Element root = doc.getRootElement();
        String toUserName = root.elementText("ToUserName");
        String fromUserName = root.elementText("FromUserName");
        Integer createTime = Integer.parseInt(root.elementText("CreateTime"));
        String msgType = root.elementText("MsgType");
        if ("text".equals(msgType))
        	return parseInTextMsg(root, toUserName, fromUserName, createTime, msgType);
        if ("image".equals(msgType))
        	return parseInImageMsg(root, toUserName, fromUserName, createTime, msgType);
        if ("voice".equals(msgType))
        	return parseInVoiceMsgAndInSpeechRecognitionResults(root, toUserName, fromUserName, createTime, msgType);
        if ("video".equals(msgType))
        	return parseInVideoMsg(root, toUserName, fromUserName, createTime, msgType);
        if ("location".equals(msgType))
        	return parseInLocationMsg(root, toUserName, fromUserName, createTime, msgType);
        if ("link".equals(msgType))
        	return parseInLinkMsg(root, toUserName, fromUserName, createTime, msgType);
        if ("event".equals(msgType))
        	return parseInEvent(root, toUserName, fromUserName, createTime, msgType);
        throw new RuntimeException("无法识别的消息类型，请查阅微信公众平台开发文档");
	}
	
	private static InMsg parseInTextMsg(Element root, String toUserName, String fromUserName, Integer createTime, String msgType) {
		InTextMsg msg = new InTextMsg(toUserName, fromUserName, createTime, msgType);
		msg.setContent(root.elementText("Content"));
		msg.setMsgId(root.elementText("MsgId"));
		return msg;
	}
	
	private static InMsg parseInImageMsg(Element root, String toUserName, String fromUserName, Integer createTime, String msgType) {
		InImageMsg msg = new InImageMsg(toUserName, fromUserName, createTime, msgType);
		msg.setPicUrl(root.elementText("PicUrl"));
		msg.setMediaId(root.elementText("MediaId"));
		msg.setMsgId(root.elementText("MsgId"));
		return msg;
	}
	
	private static InMsg parseInVoiceMsgAndInSpeechRecognitionResults(Element root, String toUserName, String fromUserName, Integer createTime, String msgType) {
		String recognition = root.elementText("Recognition");
		if (StringUtils.isEmpty(recognition)) {
			InVoiceMsg msg = new InVoiceMsg(toUserName, fromUserName, createTime, msgType);
			msg.setMediaId(root.elementText("MediaId"));
			msg.setFormat(root.elementText("Format"));
			msg.setMsgId(root.elementText("MsgId"));
			return msg;
		}
		else {
			InSpeechRecognitionResults msg = new InSpeechRecognitionResults(toUserName, fromUserName, createTime, msgType);
			msg.setMediaId(root.elementText("MediaId"));
			msg.setFormat(root.elementText("Format"));
			msg.setMsgId(root.elementText("MsgId"));
			msg.setRecognition(recognition);			// 与 InVoiceMsg 唯一的不同之处
			return msg;
		}
	}
	
	private static InMsg parseInVideoMsg(Element root, String toUserName, String fromUserName, Integer createTime, String msgType) {
		InVideoMsg msg = new InVideoMsg(toUserName, fromUserName, createTime, msgType);
		msg.setMediaId(root.elementText("MediaId"));
		msg.setThumbMediaId(root.elementText("ThumbMediaId"));
		msg.setMsgId(root.elementText("MsgId"));
		return msg;
	}
	
	private static InMsg parseInLocationMsg(Element root, String toUserName, String fromUserName, Integer createTime, String msgType) {
		InLocationMsg msg = new InLocationMsg(toUserName, fromUserName, createTime, msgType);
		msg.setLocation_X(root.elementText("Location_X"));
		msg.setLocation_Y(root.elementText("Location_Y"));
		msg.setScale(root.elementText("Scale"));
		msg.setLabel(root.elementText("Label"));
		msg.setMsgId(root.elementText("MsgId"));
		return msg;
	}
	
	private static InMsg parseInLinkMsg(Element root, String toUserName, String fromUserName, Integer createTime, String msgType) {
		InLinkMsg msg = new InLinkMsg(toUserName, fromUserName, createTime, msgType);
		msg.setTitle(root.elementText("Title"));
		msg.setDescription(root.elementText("Description"));
		msg.setUrl(root.elementText("Url"));
		msg.setMsgId(root.elementText("MsgId"));
		return msg;
	}
	
	// 解析四种事件
	private static InMsg parseInEvent(Element root, final String toUserName, final String fromUserName, Integer createTime, String msgType) {
		final String event = root.elementText("Event");
		String eventKey = root.elementText("EventKey");
		
		// 关注/取消关注事件（包括二维码扫描关注，二维码扫描关注事件与扫描带参数二维码事件是两回事）
		if (("subscribe".equals(event) || "unsubscribe".equals(event)) && StringUtils.isEmpty(eventKey)) {
			cachedThreadPool.execute(new Runnable() {
				@Override
				public void run() {
					if("subscribe".equals(event)){
						WxService.addMember(fromUserName, toUserName);
					}else {
						WxService.updateMember(fromUserName, toUserName);
					}
					
				}
			});
			InFollowEvent e = new InFollowEvent(toUserName, fromUserName, createTime, msgType);
			e.setEvent(event);
			return e;
		}
		
		// 扫描带参数二维码事件之一		1: 用户未关注时，进行关注后的事件推送
		String ticket = root.elementText("Ticket");
		if ("subscribe".equals(event) && StringUtils.isNotEmpty(eventKey) && eventKey.startsWith("qrscene_")) {
			cachedThreadPool.execute(new Runnable() {
				@Override
				public void run() {
					WxService.addMember(fromUserName, toUserName);
				}
			});
			InQrCodeEvent e = new InQrCodeEvent(toUserName, fromUserName, createTime, msgType);
			e.setEvent(event);
			e.setEventKey(eventKey);
			e.setTicket(ticket);
			return e;
		}
		// 扫描带参数二维码事件之二		2: 用户已关注时的事件推送
		if ("SCAN".equals(event)) {
			InQrCodeEvent e = new InQrCodeEvent(toUserName, fromUserName, createTime, msgType);
			e.setEvent(event);
			e.setEventKey(eventKey);
			e.setTicket(ticket);
			return e;
		}
		
		// 上报地理位置事件
		if ("LOCATION".equals(event)) {
			InLocationEvent e = new InLocationEvent(toUserName, fromUserName, createTime, msgType);
			e.setEvent(event);
			e.setLatitude(root.elementText("Latitude"));
			e.setLongitude(root.elementText("Longitude"));
			e.setPrecision(root.elementText("Precision"));
			return e;
		}
		
		// 自定义菜单事件之一			1：点击菜单拉取消息时的事件推送
		if ("CLICK".equals(event)) {
			InMenuEvent e = new InMenuEvent(toUserName, fromUserName, createTime, msgType);
			e.setEvent(event);
			e.setEventKey(eventKey);
			return e;
		}
		// 自定义菜单事件之二			2：点击菜单跳转链接时的事件推送
		if ("VIEW".equals(event)) {
			InMenuEvent e = new InMenuEvent(toUserName, fromUserName, createTime, msgType);
			e.setEvent(event);
			e.setEventKey(eventKey);
			return e;
		}
		throw new RuntimeException("无法识别的事件类型，请查阅微信公众平台开发文档");
	}
	
	public static String processInTextMsg(InTextMsg inTextMsg) {
		OutMsg outMsg = WxService.geOutMsgBykey(inTextMsg);
		if(outMsg==null)
		{
			return "";
		}
		else
		{
			String str=OutMsgXmlBuilder.build(outMsg); 
			System.out.println(str);
			return str;
		}
		
		
		 
		
		
		
		/*// 帮助提示
		if ("help".equalsIgnoreCase(msgContent)) {
			OutTextMsg outMsg = new OutTextMsg(inTextMsg);
			outMsg.setContent("");
			render(outMsg);
		}
		// 图文消息测试
		else if ("news".equalsIgnoreCase(msgContent)) {
			OutNewsMsg outMsg = new OutNewsMsg(inTextMsg);
			outMsg.addNews("JFinal 1.8 发布，JAVA 极速 WEB+ORM 框架", "现在就加入 JFinal 极速开发世界，节省更多时间去跟女友游山玩水 ^_^", "http://mmbiz.qpic.cn/mmbiz/zz3Q6WSrzq1ibBkhSA1BibMuMxLuHIvUfiaGsK7CC4kIzeh178IYSHbYQ5eg9tVxgEcbegAu22Qhwgl5IhZFWWXUw/0", "http://mp.weixin.qq.com/s?__biz=MjM5ODAwOTU3Mg==&mid=200313981&idx=1&sn=3bc5547ba4beae12a3e8762ababc8175#rd");
			outMsg.addNews("JFinal 1.6 发布,JAVA极速WEB+ORM框架", "JFinal 1.6 主要升级了 ActiveRecord 插件，本次升级全面支持多数源、多方言、多缓", "http://mmbiz.qpic.cn/mmbiz/zz3Q6WSrzq0fcR8VmNCgugHXv7gVlxI6w95RBlKLdKUTjhOZIHGSWsGvjvHqnBnjIWHsicfcXmXlwOWE6sb39kA/0", "http://mp.weixin.qq.com/s?__biz=MjM5ODAwOTU3Mg==&mid=200121522&idx=1&sn=ee24f352e299b2859673b26ffa4a81f6#rd");
			render(outMsg);
		}
		// 音乐消息测试
		else if ("music".equalsIgnoreCase(msgContent)) {
			OutMusicMsg outMsg = new OutMusicMsg(inTextMsg);
			outMsg.setTitle("Listen To Your Heart");
			outMsg.setDescription("建议在 WIFI 环境下流畅欣赏此音乐");
			outMsg.setMusicUrl("http://www.jfinal.com/Listen_To_Your_Heart.mp3");
			outMsg.setHqMusicUrl("http://www.jfinal.com/Listen_To_Your_Heart.mp3");
			outMsg.setFuncFlag(true);
			render(outMsg);
		} */
	}
	
	/**
	 *处理图片消息
	 */
	public static String processInImageMsg(InImageMsg inImageMsg) {
		OutImageMsg outMsg = new OutImageMsg(inImageMsg);
		// 将刚发过来的图片再发回去
		outMsg.setMediaId(inImageMsg.getMediaId());
		return OutMsgXmlBuilder.build(outMsg);
	}
	
	/**
	 *处理语音消息
	 */
	public static String processInVoiceMsg(InVoiceMsg inVoiceMsg) {
		OutVoiceMsg outMsg = new OutVoiceMsg(inVoiceMsg);
		// 将刚发过来的语音再发回去
		outMsg.setMediaId(inVoiceMsg.getMediaId());
		return OutMsgXmlBuilder.build(outMsg);
	}
	
	/**
	 *处理视频消息
	 */
	public static String processInVideoMsg(InVideoMsg inVideoMsg) {
		/* 腾讯 api 有 bug，无法回复视频消息，暂时回复文本消息代码测试
		OutVideoMsg outMsg = new OutVideoMsg(inVideoMsg);
		outMsg.setTitle("OutVideoMsg 发送");
		outMsg.setDescription("刚刚发来的视频再发回去");
		// 将刚发过来的视频再发回去，经测试证明是腾讯官方的 api 有 bug，待 api bug 却除后再试
		outMsg.setMediaId(inVideoMsg.getMediaId());
		render(outMsg);
		*/
		OutTextMsg outMsg = new OutTextMsg(inVideoMsg);
		outMsg.setContent("\t视频消息已成功接收，该视频的 mediaId 为: " + inVideoMsg.getMediaId());
		return OutMsgXmlBuilder.build(outMsg);
	}
	
	/**
	 *处理地址位置消息
	 */
	public static String processInLocationMsg(InLocationMsg inLocationMsg) {
		OutTextMsg outMsg = new OutTextMsg(inLocationMsg);
		outMsg.setContent("已收到地理位置消息:" +
							"\nlocation_X = " + inLocationMsg.getLocation_X() +
							"\nlocation_Y = " + inLocationMsg.getLocation_Y() + 
							"\nscale = " + inLocationMsg.getScale() +
							"\nlabel = " + inLocationMsg.getLabel());
		return OutMsgXmlBuilder.build(outMsg);
	}
	
	/**
	 *处理链接消息
	 * 特别注意：测试时需要发送我的收藏中的曾经收藏过的图文消息，直接发送链接地址会当做文本消息来发送
	 */
	public static String processInLinkMsg(InLinkMsg inLinkMsg) {
		OutNewsMsg outMsg = new OutNewsMsg(inLinkMsg);
		outMsg.addNews("链接消息已成功接收", "链接使用图文消息的方式发回给你，还可以使用文本方式发回。点击图文消息可跳转到链接地址页面，是不是很好玩 :)" , "http://mmbiz.qpic.cn/mmbiz/zz3Q6WSrzq1ibBkhSA1BibMuMxLuHIvUfiaGsK7CC4kIzeh178IYSHbYQ5eg9tVxgEcbegAu22Qhwgl5IhZFWWXUw/0", inLinkMsg.getUrl());
		return OutMsgXmlBuilder.build(outMsg);
	}
	
	/**
	 *处理关注/取消关注消息
	 */
	public static String processInFollowEvent(InFollowEvent inFollowEvent) {
		
		//微信帐号表
		WxInfo tpm=D.sql("select * from t_wx_info where original_id=?").oneOrNull(WxInfo.class, inFollowEvent.getToUserName());
		
		//得到微信粉丝的信息
		WxMember member = WeixinUtil.getUser(inFollowEvent.getFromUserName(), AccessTokenApi.getAccessToken(tpm.getApp_id(), tpm.getApp_secrect()).getAccessToken());
		
		//微信关注粉丝表
		Member tm=D.sql("select * from t_m_member where OPEN_ID=?").oneOrNull(Member.class, inFollowEvent.getFromUserName());
		
		if("subscribe".equals(inFollowEvent.getEvent()))	//订阅
		{
			//向微信关注粉丝表表插入关注者的信息
			if(tm==null)
			{
				tm=new Member();
				tm.setCreate_time(new Date());
				tm.setUpdate_time(new Date());
				tm.setCity(member.getCity());
				tm.setCountry(member.getCountry());
				tm.setImg(member.getHeadimgurl());
				tm.setNickname(member.getNickname());
				tm.setProvince(member.getProvince());
				tm.setSex(member.getSex());
				tm.setOpenid(inFollowEvent.getFromUserName());
				tm.setWx_id(tpm.getWx_id());
				tm.setStatus(SystemConstant.MemberLogType.ATTENTION_ON);
				D.insert(tm);
			}
			else
			{
				tm.setCreate_time(new Date());
				tm.setUpdate_time(new Date());
				tm.setCity(member.getCity());
				tm.setCountry(member.getCountry());
				tm.setImg(member.getHeadimgurl());
				tm.setNickname(member.getNickname());
				tm.setProvince(member.getProvince());
				tm.setSex(member.getSex());
				tm.setOpenid(inFollowEvent.getFromUserName());
				tm.setWx_id(tpm.getWx_id());
				tm.setStatus(SystemConstant.MemberLogType.ATTENTION_ON);
				D.update(tm);
			}
			//从关注表中查出关注时回复的信息
				
			List<WxAttention> tpaList=D.sql("select * from t_wx_attention where start_time <= now() and end_time >= now() ").list(WxAttention.class);
			WxAttention tpa = new WxAttention();
			if(tpaList != null && tpaList.size() > 0){
				tpa = tpaList.get(0);
				if( StringUtils.isNotEmpty(tpa.getKeyword()))	//如果回复的是关键字的信息，则需去查关键字
				{
					InTextMsg itm=new InTextMsg(inFollowEvent.getToUserName(),inFollowEvent.getFromUserName(),new Date().getDate(),"text");
					itm.setContent(tpa.getKeyword());
					OutMsg outMsg = WxService.geOutMsgBykey(itm);
					if(outMsg==null){
						return "";
					}else{
						String str=OutMsgXmlBuilder.build(outMsg); 
						System.out.println(str);
						return str;
					}
				} 
			}
		}else if("unsubscribe".equals(inFollowEvent.getEvent()))	//取消订阅
		{
			if(tm!=null)
			{
				tm.setStatus(SystemConstant.MemberLogType.ATTENTION_CANCLE);
				D.updateWithoutNull(tm);
			}
		}
		return "";
		
	}
	
	/**
	 *处理扫描带参数二维码事件
	 */
	public static String processInQrCodeEvent(InQrCodeEvent inQrCodeEvent) {
		OutTextMsg outMsg = new OutTextMsg(inQrCodeEvent);
		outMsg.setContent("processInQrCodeEvent() 方法测试成功");
		return OutMsgXmlBuilder.build(outMsg);
	}
	
	/**
	 *处理上报地理位置事件
	 */
	public static String processInLocationEvent(InLocationEvent inLocationEvent) {
		OutTextMsg outMsg = new OutTextMsg(inLocationEvent);
		outMsg.setContent("processInLocationEvent() 方法测试成功");
		return OutMsgXmlBuilder.build(outMsg);
	}
	
	/**
	 *处理自定义菜单事件
	 * @throws DocumentException 
	 */
	public static String  processInMenuEvent(InMenuEvent inMenuEvent,String xmlStr) throws DocumentException {
		OutTextMsg outMsg= new OutTextMsg(doParse(xmlStr));
		outMsg.setContent("processInMenuEvent() 方法测试成功");
		return OutMsgXmlBuilder.build(outMsg);
	}
	
	/**
	 *处理接收语音识别结果
	 * @throws DocumentException 
	 */
	public static String processInSpeechRecognitionResults(InSpeechRecognitionResults inSpeechRecognitionResults,String xmlStr) throws DocumentException {
		OutTextMsg outMsg= new OutTextMsg(doParse(xmlStr));
		outMsg.setContent("语音识别结果： " + inSpeechRecognitionResults.getRecognition());
		return OutMsgXmlBuilder.build(outMsg);
	}
}