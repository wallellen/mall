package com.freelywx.admin.wx;

import java.io.InputStreamReader;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.junit.Test;
/**
 * 微信服务端模拟器
 * @author eric
 *
 */
public class WxServerSim {
	private static String URL = "http://localhost:8080/system/wxService";
	public static String textStr = "<xml>" +
			"<ToUserName><![CDATA[12asfasdfads]]></ToUserName>" +
			"<FromUserName><![CDATA[gh_0e9fa9717693]]></FromUserName> " +
			"<CreateTime>1348831860</CreateTime> " +
			"<MsgType><![CDATA[text]]></MsgType> " +
			"<Content><![CDATA[KKKKK]]></Content>" +
			" <MsgId>1234567890123456</MsgId></xml>" ;
	
	public static String imgStr ="<xml>" +
			"<ToUserName><![CDATA[12asfasdfads]]></ToUserName>" +
			"<FromUserName><![CDATA[gh_0e9fa9717693]]></FromUserName>" +
			"<CreateTime>1348831860</CreateTime>" +
			"<MsgType><![CDATA[image]]></MsgType>" +
			"<PicUrl><![CDATA[https://www.baidu.com/img/bd_logo1.png]]></PicUrl> " +
			"<MediaId><![CDATA[33]]></MediaId>" +
			"<MsgId>1234567890123456</MsgId></xml>";
	
	public static String menu_click = "<xml>" +
			"<ToUserName><![CDATA[1]]></ToUserName>" +
			"<FromUserName><![CDATA[2]]></FromUserName>" +
			"<CreateTime>123456789</CreateTime>" +
			"<MsgType><![CDATA[event]]></MsgType>" +
			"<Event><![CDATA[CLICK]]></Event><EventKey>" +
			"<![CDATA[EVENTKEY]]></EventKey>";
	public static String menu_scancode_push = "<xml>" +
			"<ToUserName><![CDATA[gh_e136c6e50636]]></ToUserName>" +
			"<FromUserName><![CDATA[oMgHVjngRipVsoxg6TuX3vz6glDg]]></FromUserName>" +
			"<CreateTime>1408090502</CreateTime><MsgType>" +
			"<![CDATA[event]]></MsgType><Event><![CDATA[scancode_push]]></Event>" +
			"<EventKey><![CDATA[6]]></EventKey>" +
			"<ScanCodeInfo><ScanType><![CDATA[qrcode]]></ScanType>" +
			"<ScanResult><![CDATA[1]]></ScanResult></ScanCodeInfo></xml>";
	@Test
	public  void testText() throws Exception {
		HttpClient httpclient = new DefaultHttpClient();
		HttpPost httppost = new HttpPost(URL);
		StringEntity myEntity = new StringEntity(textStr, "UTF-8");
		httppost.addHeader("Content-Type", "text/xml");
		httppost.setEntity(myEntity);
		HttpResponse response = httpclient.execute(httppost);
		HttpEntity resEntity = response.getEntity();
		InputStreamReader reader = new InputStreamReader(
				resEntity.getContent(), "UTF-8");
		char[] buff = new char[1024];
		int length = 0;
		while ((length = reader.read(buff)) != -1) {
			System.out.println(new String(buff, 0, length));
		}
		httpclient.getConnectionManager().shutdown();
	}
	
	/*@Test
	public  void testImg() throws Exception {
		HttpClient httpclient = new DefaultHttpClient();
		HttpPost httppost = new HttpPost(URL);
		StringEntity myEntity = new StringEntity(imgStr, "UTF-8");
		httppost.addHeader("Content-Type", "text/xml");
		httppost.setEntity(myEntity);
		HttpResponse response = httpclient.execute(httppost);
		HttpEntity resEntity = response.getEntity();
		InputStreamReader reader = new InputStreamReader(
				resEntity.getContent(), "UTF-8");
		char[] buff = new char[1024];
		int length = 0;
		while ((length = reader.read(buff)) != -1) {
			System.out.println(new String(buff, 0, length));
		}
		httpclient.getConnectionManager().shutdown();
	}*/
}
