package com.freelywx.admin.menu;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.admin.shiro.ShiroUser;
import com.freelywx.admin.wx.api.ApiResult;
import com.freelywx.admin.wx.api.MenuApi;
import com.freelywx.admin.wx.menu.Button;
import com.freelywx.admin.wx.menu.CommonButton;
import com.freelywx.admin.wx.menu.CommonButton2;
import com.freelywx.admin.wx.menu.ComplexButton;
import com.freelywx.admin.wx.menu.Menu;
import com.freelywx.common.cache.DictCache;
import com.freelywx.common.model.pub.TPubMenu;
import com.rps.util.D;

/**
 * 用户控制器类
 * 方法上的注释为页面中Button的标题
 */
@Controller
@RequestMapping("/wxmenu")
public class MenuController {
	@Autowired
	DictCache dictCache;
	
	@RequestMapping("init")
	public String init() {
		return "publish/menu";
	}
	
	@ResponseBody
	@RequestMapping("list")
	public List<TPubMenu> SearchEmployees(HttpServletRequest request,HttpServletResponse response) throws Exception
	{ 		
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		List<TPubMenu> allMenue = D.sql("select * from t_pub_menu where uid= ?   order by menu_id  ").many(TPubMenu.class,loginUser.getUser_id());
		return allMenue;
	}
	
	
	/**
	 * 菜单提交
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/apply")
	public boolean apply(){
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		/*ApiConfig.setToken(loginUser.getMerchantWx().getToken());
		ApiConfig.setAppId(loginUser.getMerchantWx().getApp_id());
		ApiConfig.setAppSecret(loginUser.getMerchantWx().getApp_secret());*/
		
		//父按钮
		ArrayList<Button> listParent=new ArrayList<Button>();
		List<TPubMenu> list=D.sql("select * from t_pub_menu where UID= ?").many(TPubMenu.class,loginUser.getUser_id());
		for(TPubMenu tp:list)
		{
			if(tp.getPid()==-1)	//表示是父按钮
			{
				//查找此父按钮下面是否有子按钮，有的话就只用ComplexButton表示此父按钮，没有的话就只用Button类表示此父按钮
				boolean isHave=false;
				for(TPubMenu tp1:list)
				{
					if(tp1.getPid()==tp.getMenu_id())
					{
						isHave=true;
						break;
					}
				}
				//如果此父按钮有子按钮
				if(isHave)
				{
					//父按钮
					ComplexButton cbParent=new ComplexButton();
					cbParent.setName(tp.getMenu_name());
					//父按钮的子按钮数组
					ArrayList<Button> childCbList=new ArrayList<Button>();
					   
					//先查询此菜单有没有子菜单
					for(TPubMenu tpChild:list)
					{ 
						//如果有子菜单
						if(tpChild.getPid()==tp.getMenu_id())
						{ 
							//子按钮
							CommonButton cb=new CommonButton();
							CommonButton2 cb2=new CommonButton2();
							
							String type=dictCache.getEnTextByVal(tpChild.getMenu_type(), "MENU_TYPE");
							if("click".equals(type))
							{
								cb2.setKey(tpChild.getKeyword());
								cb2.setName(tpChild.getMenu_name());
								cb2.setType(type);
								childCbList.add(cb2);
							}
							else if("view".equals(type))
							{
								cb.setName(tpChild.getMenu_name());
								cb.setType(type);
								cb.setUrl(tpChild.getUrl());
								childCbList.add(cb);
							}
						}
					}
					
					
					Button [] bt2=new Button [childCbList.size()];
					for(int i=0;i<childCbList.size();i++)
					{
						bt2[i]=childCbList.get(i);
					} 
					cbParent.setSub_button(bt2);
					listParent.add(cbParent);
				}
				else	//此父按钮没有子按钮
				{
					//子按钮
					CommonButton cb=new CommonButton();
					CommonButton2 cb2=new CommonButton2();
					String type=dictCache.getEnTextByVal(tp.getMenu_type(), "MENU_TYPE");
					if("click".equals(type))
					{
						cb2.setKey(tp.getKeyword());
						cb2.setName(tp.getMenu_name());
						cb2.setType(type);
						listParent.add(cb2);
					}
					else if("view".equals(type))
					{
						cb.setName(tp.getMenu_name());
						cb.setType(type);
						cb.setUrl(tp.getUrl());
						listParent.add(cb);
					}
				}
			}
		}
		if(listParent.size()>0)
		{
			Menu menu=new Menu();
			Button [] bt2=new Button [listParent.size()];
			for(int i=0;i<listParent.size();i++)
			{
				bt2[i]=listParent.get(i);
			} 
			menu.setButton(bt2);
			String jsonMenu = JSONObject.fromObject(menu).toString();
			System.out.println("开始打印菜单");
			System.out.println(jsonMenu);
			MenuApi menuApi=new MenuApi(); 
			ApiResult apiResult = menuApi.createMenu(loginUser.getMerchantWx().getApp_id(),loginUser.getMerchantWx().getApp_secret(),jsonMenu);
			return apiResult.isSucceed();
		}
		else
		{
			return false;
		}
	
		
		 
	/*	
		MenuApi menuApi=new MenuApi(); 
		//ApiResult apiResult = menuApi.createMenu("{type: 'view',name: '点餐',url: 'http://loveyy.gnjsp.xzbiz.cn/_front/main.html/',sub_button: [ ]},{type: 'view',name: '我的订单',url: 'http://www.baidu.com',sub_button: [ ]},{type: 'view',name: '其他',url: 'http://www.baidu.com',sub_button: [ ]}]}}");
		 String str="{"+
        "\"button\":["+
            "{\"name\":\"点餐2\","+
            "\"type\":\"view\"," +
           "\"url\":\""+
              "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+ApiConfig.getAppId()+"&redirect_uri=http://iloveyy820.gotoip4.com/dc/oauth&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"
           +"\"" +
           
            "},"+
            "{\"name\":\"我的订单2\","+
            "\"type\":\"view\"," +
            "\"url\":\""+
            "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+ApiConfig.getAppId()+"&redirect_uri=http://iloveyy820.gotoip4.com/dc/oauth1&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"
          +"\"" +
            "}"+
             
        "]"+
    "}";
		
		ApiResult apiResult = menuApi.createMenu(str);
		return apiResult.isSucceed();
	*/	
		
	}
	
	/**
	 * 查询菜单下面的子菜单数量
	 * @param menu_id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getChilds/{menu_id}")
	public List<TPubMenu> getChilds(@PathVariable("menu_id") String menu_id) {
		List<TPubMenu> list= D.sql("select * from t_pub_menu where pid =?").many(TPubMenu.class, menu_id);
		return list;
	}
	
	@RequestMapping(value="/add")
	public String toAdd(){
		return "publish/menu_edit";
	}
	

	@RequestMapping(value="/edit")
	public String edit(){
		return "publish/menu_edit";
	}
	
	
	/*
	 * 修改新增
	 */
	@ResponseBody
	@RequestMapping(value = "/save")
	public boolean save(@RequestBody final TPubMenu tPubMenu){
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		tPubMenu.setUid(loginUser.getUser_id());
		tPubMenu.setWx_id(loginUser.getMerchantWx().getWx_id());
		System.out.println("tPubMenu.getMenu_id():"+tPubMenu.getMenu_id());
		if(tPubMenu.getMenu_id()!=null)
		{
			return D.updateWithoutNull(tPubMenu)>0;
		}
		else
		{
			return D.insertWithoutNull(tPubMenu)>0;
		}
	}
	
	/*
	 * 得到主菜单的数量
	 */
	@ResponseBody
	@RequestMapping("/getMenuSize")
	public List<TPubMenu> getMenuSize()
	{
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		List<TPubMenu> list=D.sql("select * from t_pub_menu where pid=-1 and uid=?").many(TPubMenu.class, loginUser.getUser_id());
		return list;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/delete/{menu_id}")
	public int delete(@PathVariable("menu_id") Integer menu_id) { 
		return D.deleteById(TPubMenu.class, menu_id);
		 
	}
	
	/*
	 * 修改（之前）-查询信息
	 */
	@ResponseBody
	@RequestMapping(value = "/{menu_id}")
	public TPubMenu get(@PathVariable("menu_id") Integer menu_id) {
		TPubMenu u = D.selectById(TPubMenu.class, menu_id);
		return u;
	}
	
	
	
	 
}
