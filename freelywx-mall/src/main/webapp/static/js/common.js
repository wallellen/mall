$(function() {
 // getNotifications();
});

function Map(){
this.container = new Object();
}


Map.prototype.put = function(key, value){
this.container[key] = value;
}


Map.prototype.get = function(key){
return this.container[key];
}

//订单状态 - 用于订单列表中
var order_status_map = new Map();
order_status_map.put("1","待支付");
order_status_map.put("2","待制作");
order_status_map.put("3","制作中");
order_status_map.put("4","派送中");
order_status_map.put("5","派送中");
order_status_map.put("6","派送中");
order_status_map.put("7","已签收");
order_status_map.put("8","已自取");
order_status_map.put("9","已取消");
order_status_map.put("10","无法送达");
order_status_map.put("11","无法签收");
order_status_map.put("12","已签收");
order_status_map.put("13","已取消");
order_status_map.put("14","待退款");
order_status_map.put("15","已退款");
order_status_map.put("16","未自取");

//订单状态说明 - 用于订单详情中
var order_status_desc_map = new Map();
order_status_desc_map.put("1","订单已提交，请支付");
order_status_desc_map.put("2","付款成功，订单已下派到门店，待制作");
order_status_desc_map.put("3","饮品制作进行中");
order_status_desc_map.put("4","饮品制作完成，派送中");
order_status_desc_map.put("5","派送中");
order_status_desc_map.put("6","派送中");
order_status_desc_map.put("7","饮品已签收");
order_status_desc_map.put("8","饮品已自取");
order_status_desc_map.put("9","订单已取消");
order_status_desc_map.put("10","饮品无法送达");
order_status_desc_map.put("11","饮品无法签收");

var DELIVERY_TYPE_MDZQ = "mdzq";
var DELIVERY_TYPE_JSPS = "jsps";

//订单支付方式: 0: 在线支付 1: 现金支付
var PAYMENT_TYPE_ONLINE = 0;
var PAYMENT_TYPE_CASH = 1;

// 订单评价状态：0为不需评价，1为待评价，2为已评价
var ORDER_EVALUATE_NO      = 0;
var ORDER_EVALUATE_PEND    = 1;
var ORDER_EVALUATE_DONE    = 2;

//订单评价槽点
var order_evaluation_point_map = new Map();
order_evaluation_point_map.put("1","饮品口感");
order_evaluation_point_map.put("2","配送速度");
order_evaluation_point_map.put("3","服务态度");
order_evaluation_point_map.put("4","卫生状况");
order_evaluation_point_map.put("5","视觉印象");

//是否使用七牛服务器上的产品图片,true为使用，false为使用本地图片
var USE_QINIU_ICON = true;
var QINIU_PRODUCT_ICON_DOMAIN = "http://7xjt4d.com2.z0.glb.qiniucdn.com/";

//兼容click和tap事件, 调用时用$(selector).on(CLICK,fn);
var UA = window.navigator.userAgent;
var CLICK = 'click';
if(/iPad|iPhone|Android/.test(UA)){
    CLICK = 'tap';
}

//清除localstorage里可能遗留的deliveryInfo和sitelist
localStorage.removeItem("deliveryInfo");
localStorage.removeItem("sitelist");
//localStorage.removeItem("userInfo");

  var allowUrlList = ["product","store","getproductsbysite","sendvcode","verifyvcode","updateuseropenid","getList","getproducttastebyids","getorderpromotion","getnearestsite","getnearestbuilding","getlocation","addSiteWish","searchbuilding"];
  function isUrlAllow(url) {
	  var flag = false;
	  for(var val in allowUrlList) {
		  if(url.indexOf(allowUrlList[val]) > -1) {
			  flag = true;
			  break;
		  }
	  }
	  
	  return flag;
  }
//ajax
  var isstartajax = false;
  function _postAjax(url,datas,backfn,errorfn){
	  //获取当前用户的access token
	  var userInfo = sessionStorage.userInfo;
	  if(userInfo == undefined) {
		  if(isUrlAllow(url)) {
			  //do nothing
		  } else {
			  var href = window.location.href;
			  var from = href.substring(href.lastIndexOf("/")+1,href.lastIndexOf(".html"));
			  navigateTo(from, "login");
		  }
	  } else {
		  userInfo = $.parseJSON(userInfo);
		  var mytoken = userInfo.mytoken;
		  datas.accesstoken=mytoken;
	  }
      //if(isstartajax){return false;}
      isstartajax = true;
      
      var async = true;
      if(datas.isAsync != undefined && (datas.isAsync == false || datas.isAsync == "false")) {
    	  async = false;
      }
      
      showloading("fade");
      $.ajax({ 
          url: url,
          data:datas,
          async: async,
          type:"POST",
          success: function(result){
              isstartajax=false;
              stoploading("fade");
              if(backfn){
                  backfn(result);
              }
          },error:function(result){
        	  isstartajax=false;
        	  stoploading("fade");
        	  if(errorfn) {
        		  errorfn(result);
        	  }
          }
      });
  }
  
  function _getAjax(url,datas,backfn,errorfn){
      //if(isstartajax){return false;}
      isstartajax = true;
      showloading("fade");
      $.ajax({ 
          url: url,
          data:datas,         
          type:"GET",
          success: function(result){
              isstartajax=false;
              stoploading("fade");
              if(backfn){
                  backfn(result);
              }
          },error:function(result){
        	  isstartajax=false;
        	  stoploading("fade");
        	  if(errorfn) {
        		  errorfn(result);
        	  }
          }
      });
  }
  
  function doSubmitOrder(from) {
	//从本地存储中获取订单信息
	var orderinfo = sessionStorage.orderinfo;
	var userInfo = sessionStorage.userInfo;
	
	if(orderinfo == undefined || userInfo == undefined) {
		showTip("您还未登录或订单信息不完整，提交订单失败","body");
		return false;
	} else {
		orderinfo = $.parseJSON(orderinfo);
		userInfo = $.parseJSON(userInfo);
		orderinfo.user_id = userInfo.user_id;
		
		//提交
		var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/submitorder.html";
		_postAjax(url,orderinfo,function(result){
				//alert(JSON.stringify(result));
			
			if(result) {
				result = $.parseJSON(result);
				
				if(result.ret_code == "0") {// 成功是0 非0是失败
					//更新配送地址-添加新生成的address_id为下次默认id
					var deliveryInfo = $.parseJSON(sessionStorage.deliveryInfo);
//					deliveryInfo.address_id = result.address_id;
//					sessionStorage.deliveryInfo = JSON.stringify(deliveryInfo);
					
					//更新用户默认门店信息
					updateUserDefaultSite(userInfo,deliveryInfo);
					
					sessionStorage.removeItem("deliveryInfo");
					//删除订单记录
					sessionStorage.removeItem("orderinfo");
					sessionStorage.removeItem("productsinfo");
					
					if(orderinfo.payment_type == "1") {//订单支付方式: 0: 在线支付 1: 货到付款
						//获取跳转地址 - 临时
				        var url = window.location.href.replace(from,"orderdetailform");
				        window.location.href = changeURLPar(url,"corder_code",result.order_code);
					} else {
						//获取跳转地址 - 临时
				        var url = window.location.href.replace(from,"orderpayform");
				        window.location.href = url+"&order_code="+result.order_code;
					}
				} else if (result.ret_code == "2") {//过期,重新验证登录
					//获取跳转地址 - 临时
			        var url = window.location.href.replace(from,"login");
			        window.location.href = url;
				} else {
					showTip("创建订单失败","body");
					return false;
				}
			} else {
				showTip("提交订单失败","body");
				return false;
			}
		});
		
	}
  }
  
  //更新用户的默认门店
  function updateUserDefaultSite(userInfo,deliveryInfo) {
	  if(userInfo.default_building == undefined || userInfo.default_building.id != deliveryInfo.building_id) {
		  var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/updateuserdefaultsite.html";
			var data = {};
			data.user_id = userInfo.user_id;
			data.building_id = deliveryInfo.building_id;
			data.isAsync = false;
			
			_postAjax(url,data,function(result){
				if(result) {
					result = $.parseJSON(result);
					if(result.ret_code == "0") {// 成功是0 非0是失败
						//更新本地存储
						var localUserInfo = sessionStorage.userInfo;
						localUserInfo = $.parseJSON(localUserInfo);
						var site = localUserInfo.default_site;
						var building = localUserInfo.default_building;
						if(site == undefined) {
							site = {};
						}
						
						if(building == undefined) {
							building = {};
						}
						
						site.city = deliveryInfo.site_city;
			            site.district = deliveryInfo.site_district;
			            site.name = deliveryInfo.site_name;
			            site.id = deliveryInfo.site_id;
			            site.site_code = deliveryInfo.site_code;
			            site.buildings = deliveryInfo.service_buildings;
			            site.location = deliveryInfo.siteaddr;
			            site.announcement = deliveryInfo.announcement;
			            
			            building.id = deliveryInfo.building_id;
			            building.name = deliveryInfo.building_name;
			            building.has_site = deliveryInfo.building_has_site;
			
			            localUserInfo.default_site = site;
			            localUserInfo.default_building = building;
			            sessionStorage.userInfo = JSON.stringify(localUserInfo);
					} else {
						showTip("更新用户默认办公楼失败","body");
						return false;
					}
				} else {
					showTip("更新用户默认办公楼失败","body");
					return false;
				}
			});	
	  }
  }

  //更新用户openId
  function updateUserOpenId(userInfo) {
  	var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/updateuseropenid.html";
	var params = {};
	params.user_id = userInfo.user_id;
	//params.isAsync = false;//必须是同步的，需要设置完用户的本地信息后才能继续后面操作
	
	_postAjax(url,params,function(result){
        if(result) {
            result = $.parseJSON(result);
            // 成功是0 非0是失败
            if(result.ret_code == "0") {
            	sessionStorage.userInfo = JSON.stringify(userInfo);
            } else {
                //return false;
            }
        } else {
            //return false;
        }
    });
  }
  
  //现金支付未支付的订单
  function payUnpaidOrderByCash(from, orderCode) {
  	var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/payUnpaidOrderByCash.html";
	var params = {};
	params.order_code = orderCode;
	
	_postAjax(url,params,function(result){
        if(result) {
            result = $.parseJSON(result);
            // 成功是0 非0是失败
            if(result.ret_code == "0") {
            	cleanOrderSessionInfo();
				//获取跳转地址 - 临时
		        var url = window.location.href.replace(from,"orderdetailform");
		        window.location.href = changeURLPar(url,"corder_code",orderCode);
            } else {
                showTip(result.ret_info,"body");
            	return false;
            }
        } else {
        	showTip("现金支付失败，请重试","body");
        	return false;
        }
    });
  }
  
/**
 * 时间格式化
 * 使用方法
 * var now = new Date();
 * var nowStr = now.format("yyyy-MM-dd hh:mm:ss");
 */
Date.prototype.format = function(format){ 
	var o = { 
		"M+" : this.getMonth()+1, //month 
		"d+" : this.getDate(), //day 
		"h+" : this.getHours(), //hour 
		"m+" : this.getMinutes(), //minute 
		"s+" : this.getSeconds(), //second 
		"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
		"S" : this.getMilliseconds() //millisecond 
	}

	if(/(y+)/.test(format)) { 
		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 

	for(var k in o) { 
		if(new RegExp("("+ k +")").test(format)) { 
			format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
		} 
	}
	
	return format; 
}

function navigateTo(from, to) {
  var url = window.location.href.replace(from, to);
  // 如果本地userInfo缓存失效,则请求服务器重新写入用户信息到前端
  if (sessionStorage.userInfo == undefined) {
    if (url.indexOf("refresh_session") <= 0) {
      url += "&refresh_session=true";
    }
  } else if (url.indexOf("refresh_session") <= 0) {
    url = url.replace("&refresh_session=true", "");
  }
  
  if (to == 'orderform' || to == 'goingpayform' || to == 'myaccount') {
    if (url.indexOf("showwxpaytitle") <= 0) {
      url += "&showwxpaytitle=1";
    }
  } else if (url.indexOf("showwxpaytitle") > 0) {
    url = url.replace("&showwxpaytitle=1", "");
  }
  
  if(to == 'login' && from != 'postwayselector' && from != 'orderform') {
	  url = changeURLPar(url,'signtype','dl');
  }
  
  // 从支付页面跳转回来后，禁止再返回到下单流程
  if (from == 'orderform' && to == 'orderlist') {
    window.location.replace(url);
  } else {
    window.location.href = url;
  }
}

function showTip(tipTxt,containerSelector) {
    var div = document.createElement('div');
    var style1 = "z-index:1001;width:100%;text-align:center;position:fixed;top:50%;margin-top:-23px;left:0";
    var style2 = "display:inline-block;padding:13px 24px;border:solid#d6d482 1px;background:#f5f4c5;font-size:16px;color:#8f772f;line-height:18px;border-radius:3px";
    div.innerHTML = '<div style="'+style1+'"><p style="'+style2+'">' + tipTxt + '</p></div>';
    var tipNode = div.firstChild;
    $(containerSelector).after(tipNode);
    setTimeout(function() {
        $(tipNode).remove();
    },1500);
}

function getQueryString(url,name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = url.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}

function setWithDefaultValue(val, defval) {
	if(val == null || val == undefined) {
		return defval;
	}
	
	return val;
}

function replaceAll(str,oldstr,newstr){ 
	return str.replace(new RegExp(oldstr,"gm"),newstr);
}

//根据打烊时间格式化coupon的有效时间,传入的时间格式化为: yyyy-MM-dd HH:mm:ss
function formatCouponDate(datestr) {
	var tempdate = datestr.split(" ");
	tempdate = tempdate[0].split("-");
	var endDate = new Date(parseInt(tempdate[0]),parseInt(tempdate[1])-1,parseInt(tempdate[2]),20,0,0).format("yyyy年MM月dd日 营业时间内");
	return endDate;
}

//改变url参数中的值
function changeURLPar(url, par, par_value) { 
	var pattern = par+'=([^&]*)'; 
	var replaceText = par+'='+par_value; 
	if (url.match(pattern)) { 
		var tmp = '/\\'+par+'=[^&]*/'; 
		tmp = url.replace(eval(tmp), replaceText); 
		return (tmp); 
	} else { 
		if (url.match('[\?]')) { 
			return url+'&'+ replaceText; 
		} else { 
			return url+'?'+replaceText; 
		} 
	}
	
	return url+'\n'+par+'\n'+par_value; 
}

function cleanOrderSessionInfo(){
	sessionStorage.removeItem("deliveryInfo");
	//删除订单记录
	sessionStorage.removeItem("orderinfo");
	sessionStorage.removeItem("productsinfo");
}

function doGetLocation(position, callback, error){
  var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/getlocation.html";
  var params = {};
  params.location = position.coords.latitude + "," + position.coords.longitude;
  
  //返回参数
  /*
   {
   "status": 0,
   "result": {
   "location": {
   "lng": 114.28266042918,
   "lat": 30.616326682706
   },
   "formatted_address": "湖北省武汉市江汉区香港路餐饮街香港路302号",
   "business": "唐家墩,车站,后湖",
   "addressComponent": {
   "city": "武汉市",
   "country": "中国",
   "direction": "附近",
   "distance": "11",
   "district": "江汉区",
   "province": "湖北省",
   "street": "香港路餐饮街香港路",
   "street_number": "302号",
   "country_code": 0
   },
   "poiRegions": [],
   "sematic_description": "鹏飞湖庭东北78米",
   "cityCode": 218
   }
   }
   */
  _postAjax(url, params, callback, error);
}

/**
 * 用户评价页面
 * @param iconPath
 * @returns {String}
 */
function getUserEvaluationHtml(iconPath) {
    var htmlstr = "";
    htmlstr += "<div id='eva_main'>";
    htmlstr += "  <div id='infoDiv' style='padding:0px 12px;'>";
    htmlstr += "    <div style='width:100%;text-align:center;postion:absolute;height:50px;'>";
    htmlstr += "      <img style='width:60%;height:auto;top:-30px;position:relative' src='"+iconPath+"/img_assess.png' />";
    htmlstr += "    </div>";
    htmlstr += "    <div style='text-align:center;margin-bottom:30px;' id='starDiv'>";
    htmlstr += "      <img name='staritem' id='s_1' style='width:40px;height:auto;' src='"+iconPath+"/ico_star_normal.png'/>";
    htmlstr += "      <img name='staritem' id='s_2' style='width:40px;height:auto;' src='"+iconPath+"/ico_star_normal.png'/>";
    htmlstr += "      <img name='staritem' id='s_3' style='width:40px;height:auto;' src='"+iconPath+"/ico_star_normal.png'/>";
    htmlstr += "      <img name='staritem' id='s_4' style='width:40px;height:auto;' src='"+iconPath+"/ico_star_normal.png'/>";
    htmlstr += "      <img name='staritem' id='s_5' style='width:40px;height:auto;' src='"+iconPath+"/ico_star_normal.png'/>";
    htmlstr += "    </div>";
    htmlstr += "    <ul class='pointUlCls' id='pointUl'>";
    htmlstr += "      <li><span name='piontItem' id='p_1'>饮品口感</span></li>";
    htmlstr += "      <li><span name='piontItem' id='p_2'>配送速度</span></li>";
    htmlstr += "      <li><span name='piontItem' id='p_3'>服务态度</span></li>";
    htmlstr += "      <li><span name='piontItem' id='p_4'>卫生状况</span></li>";
    htmlstr += "      <li><span name='piontItem' id='p_5'>视觉印象</span></li>";
    htmlstr += "      <div style='clear:both;'></div>";
    htmlstr += "    </ul>";
    htmlstr += "    <div id='commentDiv' style='margin:20px 0px;width:100%;padding-left:10px;display:none;'>";
    htmlstr += "      <textarea class='comments' id='comments' rows='' cols='' placeholder='您尽情吐槽，我们努力改进~' style='width:90%;height:70px;border:solid 1px #eeefe4;::-webkit-input-placeholder:#9da09f;color:#333;background-color:#fffffa;font-size:14px;'></textarea>";
    htmlstr += "    </div>";
    htmlstr += "    <input type='hidden' id='starVal' class='starVal' value=''/>";
    htmlstr += "    <input type='hidden' id='pointVal' class='pointVal' value=''/>";
    htmlstr += "  </div>";
    htmlstr += "  <div class='evaluateOkBtn' id='evaluateOkBtn'>";
    htmlstr += "    <span>提&nbsp;&nbsp;交</span>";
    htmlstr += "  </div>";
    htmlstr += "</div>";
    
    return htmlstr;
}

/**
 * 显示评价界面和实现添加评价
 * @param iconPath 图片地址前辍
 * @param orderCode 订单号
 * @param callbackFn 成功后的处理
 */
function submitEvaluation(iconPath,orderCode,callbackFn) {
    var htmlstr = getUserEvaluationHtml(iconPath);
    var pagei = layer.open({
        //1代表页面层
        type: 1, 
        content: htmlstr,
        shadeClose: true,
        style: 'width:80%;min-height:90px;',
        success: function(olayer){
            $("img[name*='staritem']").click(function(){
                var placeholderstr = "选择以上您最不满意的槽点，尽情吐槽，我们努力改进~";
                var starval = parseInt($.trim(this.id.split('_')[1]));
                $("#starVal").val(starval);
                $("#starVal").css("margin-bottom","0px");
                $(this).prevAll().addBack().attr("src",iconPath+"/ico_star_check.png");
                $(this).nextAll().attr("src",iconPath+"/ico_star_normal.png");
                if(starval==5) {
                    placeholderstr = "尽情用赞美的词汇砸过来吧~";
                    $(".pointUlCls").fadeOut();
                } else if (starval==4) {
                    placeholderstr = "给点建议吧，下次做到5星~";
                    $(".pointUlCls").fadeOut();
                } else {
                    $(".pointUlCls").fadeIn();
                }
                $("textarea").attr("placeholder",placeholderstr);
                $("#commentDiv").fadeIn();
                $(".evaluateOkBtn").fadeIn();
            });
            $("span[name*='piontItem']").click(function(){
                $("span[name*='piontItem']").removeClass('selected');
                $(this).addClass('selected');
                $("#pointVal").val(this.id.split('_')[1]);
            });
            
            $(".evaluateOkBtn").click(function(){
                var starval = $.trim($("#starVal").val());
                var pointval = $.trim($("#pointVal").val());
                var comments = $.trim($("#comments").val());
                var params = {};
                params.order_code = orderCode;
                
                if(starval == '') {
                    showTip('请选择星级','#eva_main');
                    return false;
                } else {
                    params.score_value = starval;
                }
                
                if(pointval.length > 0) {
                    params.evaluation_item = pointval;
                }
                
                if(comments.length > 140) {
                    showTip('评价内容不能超140个字','#eva_main');
                    return false;
                } else if(comments.length > 0) {
                    params.comments = comments;
                }
                
                doAddEvaluation(params,callbackFn);
            });
        }
    });
}

/**
 * 提交用户评价
 * @param data 评价的数据
 * @param callbackFn 成功后的处理
 */
function doAddEvaluation(data,callbackFn) {
    var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/addEvaluation.html";
    
    _postAjax(url,data,function(result){
        if(result) {
            result = $.parseJSON(result);
            // 成功是0 非0是失败
            if(result.ret_code == "0") {
                showTip("评价成功","#eva_main");
                layer.closeAll();
                callbackFn();
            } else {
                showTip(result.ret_info,"#eva_main");
                return false;
            }
        } else {
            showTip("评价提交失败，请重试","#eva_main");
            return false;
        }
    });
}

function getNotifications() {
  if (sessionStorage.userInfo) {
    var userInfo = $.parseJSON(sessionStorage.userInfo);
    var userId = userInfo.user_id;
    var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/getUnevaluatedCount.html";
    var data = {'user_id': userId};
    _postAjax(url,data,function(result){
      if(result) {
        result = $.parseJSON(result);
        // 成功是0 非0是失败
        if(result.ret_code == "0") {
          if (result.order_count > 0) {
            setBudgets('orderlist', result.order_count);
          } else {
            remove('orderlist');
          }
        }
      }
    });
  }
}

function setBudgets(tab, number) {
  $('#' + tab).siblings('.budgets').remove();
  $('#' + tab).after("<span class='budgets'>" + number + "<span>");
}

function remove(tab) {
  $('#' + tab).siblings('.budgets').remove();
}
