package com.freelywx.common.util;

import java.io.OutputStream;
import java.io.Reader;
import java.text.SimpleDateFormat;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.module.jaxb.JaxbAnnotationModule;

/**
	2013 2013-9-13 下午4:54:15
 	 
 */
public class JacksonUtil {
	
	private static ObjectMapper objectMapper = new ObjectMapper();
	
	static{
		//https://github.com/FasterXML/jackson-databind
		objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
		objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
		objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
		
		/**
		 * 配置默认的日期转换格式 ，参考http://wiki.fasterxml.com/JacksonFAQDateHandling
		 */
		objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
	}

	public static ObjectMapper getObjectMapper(){
	 
		return objectMapper ;
	}
	
	public static <T> T   readValue(String content , Class<T> valueType){
		 
		try {
			return objectMapper.readValue(content, valueType) ;
		}  catch (Exception e) {
			e.printStackTrace();
			return null ;
		}
	}
	
	public static JsonNode getJsonNode(String jsonStr , String key){
		//  token
		try {
			 String[] split = StringUtils.split(key,".");
			  JsonNode jsonNode = objectMapper.readTree(jsonStr);
			  JsonNode rootNode = jsonNode.get(split[0]);
			  if(split.length <= 1){
				  return rootNode ;
			  }
			  
			  JsonNode tempNode = rootNode ;
			  for (int i = 1; i < split.length; i++) {
				  tempNode = tempNode.get(split[i]);
				  if(tempNode == null){
					  break ;
				  }
			  }
			  return tempNode ;
		}  catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null ;
	}
	
	
	public static JsonNode string2json(String jsonStr){
		try {
			return   objectMapper.readTree(jsonStr);
		}   catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null ;
	}
	
	public static String optionString(JsonNode jsonNode , String key , String defaultVale){
		JsonNode node = jsonNode.get(key);
		if(node == null){
			return defaultVale;
		}
		return node.asText() ;
	}
	
	public static String optionString(JsonNode jsonNode , String key ){
		 
		return optionString(jsonNode ,key ,"") ;
	}
	
	
	public static int optionInt(JsonNode jsonNode , String key , int defaultVale){
		JsonNode node = jsonNode.get(key);
		if(node == null){
			return defaultVale;
		}
		return node.asInt() ;
	}
	
	public static int optionInt(JsonNode jsonNode , String key ){
		 
		return optionInt(jsonNode ,key ,0) ;
	}
	
	
	
	
	public static void xml2json(Class clazz , Reader reader , OutputStream os) {
		xml2json(clazz ,reader ,os , null);
	}
	
	
	public static void xml2json(Class clazz , Reader reader , OutputStream os ,BeanProcesser beanProcesser) {
		 try {
			JAXBContext context = JAXBContext.newInstance(clazz);
			 Unmarshaller unmarshal = context.createUnmarshaller();
 	 
			    Object bean = unmarshal.unmarshal(reader);
			    
			    
			    ObjectMapper objectMapper = new ObjectMapper();
			    JaxbAnnotationModule module = new JaxbAnnotationModule();
			    objectMapper.registerModule(module);
			    
			    objectMapper.writeValue(os, bean);
			    
			   
			    
			    if(beanProcesser != null){
			    	beanProcesser.processBean(bean);
			    }
		}   catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static String writeValueAsString(Object bean){
//		 ObjectMapper objectMapper = new ObjectMapper();
		 try {
			return objectMapper.writeValueAsString(bean);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		 return "" ;
	}
	
	
	public interface BeanProcesser{
		public Object processBean(Object bean) ;
	}
	

	
	public static void main(String[] args) {
		String json = "{\"active_start_date\":\"2013-12-09 00:00:00\"    }";
	}
}


