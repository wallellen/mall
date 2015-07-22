var timeout;
var count = 10000; //倒数秒数
var isopen = 0;//是否营业
var addonPath = "";

$(function(){
	FastClick.attach(document.body);
	addonPath = $("#addonPath").val();
	//初始化门店的菜单与饮品信息
	initSiteInfo();
  if (!sessionStorage.notCheckLBS) {
    getNearestSite();
  }
});

function initSiteInfo() {
	var deliveryInfo = sessionStorage.deliveryInfo;
	var userInfo = sessionStorage.userInfo;
	
	if(deliveryInfo == undefined) {
		if(userInfo == undefined) {
			navigateTo("productlist","siteselector");
		} else {
			userInfo = $.parseJSON(userInfo);
			if(userInfo.default_building == undefined) {
				//没有设置默认办公楼,则跳转至门店选择页
				navigateTo("productlist","siteselector");
			} else {
				var site = userInfo.default_site;
				var building = userInfo.default_building;
				deliveryInfo = {};
	            
				//用户有默认门店,且未重新选择过门店,则将默认门店设到deliveryInfo中
				deliveryInfo.site_city = site.city;
				deliveryInfo.site_district = site.district;
				deliveryInfo.site_name = site.site_name;
				deliveryInfo.sitename = site.cityname + site.districtname + site.site_name;
				deliveryInfo.site_id = site.site_id;
				deliveryInfo.service_buildings = site.buildings;
				deliveryInfo.siteaddr = site.address;
				deliveryInfo.building_id = buildingId;
				deliveryInfo.building_name = buildingName;
				deliveryInfo.building_has_site = hasSite;
				deliveryInfo.detail_location = "";
				deliveryInfo.fromSelector = "true";
				deliveryInfo.announcement = site.announcement;
			}
		}
	} else {
		deliveryInfo = $.parseJSON(deliveryInfo);
		if(deliveryInfo.site_code == undefined || deliveryInfo.building_name == undefined) {
			navigateTo("productlist","siteselector");
		} else {
			//do nothing
		}
	}
	
  //在页面上显示门店信息
  $("#sitenameSpan").html(deliveryInfo.building_name);
  // 显示公告信息
  $("#site_announce").text(deliveryInfo.announcement);
  $("#siteEvaluatesLink").click(function(){
      var url = window.location.href.replace("productlist","siteevaluation");
      url = changeURLPar(url,"site_id",deliveryInfo.site_id);
      window.location.href = url;
  });
  //初始化门店饮品菜单
  checkOpenTime(deliveryInfo.site_code);
  initProducts(deliveryInfo.site_code);
  //保存deliveryInfo
  sessionStorage.deliveryInfo = JSON.stringify(deliveryInfo);
}

function initProducts(site_code) {
	getProductsInfoBySiteCode(site_code);
}

function initSelectedProductsInfo() {
	var totalnum = 0;
    var totalacc = 0;
    
	if (sessionStorage.productsinfo) {
	    var productsinfo = $.parseJSON(sessionStorage.productsinfo);
	    var products = productsinfo.products;
	    
	    for (var i in products) {
	      var prod = products[i];
	      if(parseInt(prod.qty)>0) {
	    	  $("#qty"+prod.SKU).val(prod.qty);
	    	  $("#typenum_"+prod.type).html(parseInt($("#typenum_"+prod.type).html())+parseInt(prod.qty));
	          $("span[name='productNum_"+prod.SKU+"']").html(prod.qty);
          
	    	  $("#typenum_"+prod.type).show();//显示类型数量
	     	  $("img[flag='minus_"+prod.SKU+"']").show();//显示减号
	     	  $("span[name='productNum_"+prod.SKU+"']").show();//显示商品数量
          
          var limit = $("img[flag='minus_"+prod.SKU+"']").parent().attr('left_limit');
          if (limit > 0 && prod.qty >= limit) {
            $("img[flag='plus_"+prod.SKU+"']").hide().siblings('.limit-label').show();
          }
	    	  
          totalnum += parseInt(prod.qty);
          totalacc += parseFloat(prod.amount);
	      }
	    }
	}
	
	$("#totalNum").val(totalnum);
    $("#totalAcc").html(totalacc.toFixed(2));
    $("#submitBtn").attr("value","点好了("+totalnum+")");
    if(totalnum <= 0) {
		  $("#submitBtn").attr("disabled","disabled");
	} else {
		  $("#submitBtn").removeClass("closecls").addClass("opencls").removeAttr("disabled");
	}
}

function bindEvent() {
//	$('*').click(function(event){
//		alert(window.screen.height);
//		//alert(this.tagName);//Jquery会把标签名放在tagName属性里。
//		event.stopPropagation();//阻止事件冒泡，否则点一下会弹出很多，具体原因请查询JS的事件冒泡规则
//	});
	
	$("#submitBtn").click(function(){
		gotoOrderForm();
	});
	
	$("img[name='plus_minus_btn']").click(function(){
		var iden = $(this).attr("iden").split("_");
    var limit = $(this).parent().attr('left_limit');
		plus_minus(iden[0], iden[1],iden[2],iden[3], limit);
	});
	
	$("dd[name='typename']").click(function(){
		var idstr = this.id.split("_")[1];
		changeRO('rolist',idstr);
	});
	
	$("#linkto_siteselector").click(function(){
		navigateTo("productlist","siteselector");
	});
	
	setWidth();
}

function getProductsInfoBySiteCode(siteCode) {
	var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/getproductsbysite.html";
	var params = {};
	params.site_code = siteCode;
	_postAjax(url,params,function(result){
        if(result) {
            result = $.parseJSON(result);
            // 成功是0 非0是失败
            if(result.ret_code == "0") {
                generateProductsHtml(result);
            } else {
                alert("饮品获取失败，请重试");
                return false;
            }
        } else {
            alert("饮品获取失败，请重试");
            return false;
        }
    });
}

//渲染菜单与饮品列表页面
function generateProductsHtml(data) {
	var navHtml = "";
	var productListHtml = "";
	var promotion_pid_arr = data.promotion_pids;
	var productTypes = data.products;
	var normalHtml = "";
	var totalHtml = "";
	
	//遍历类型
	for(var i=0; i<productTypes.length;i++) {
		var typeObj = productTypes[i];
		var productlist = typeObj.productlist;
		var normalTypeDivHtml = "";
		var totalTypeDivHtml = "";
		var proHtml = "";
		var hideInputHtml = "";
		var iconpath = USE_QINIU_ICON ? QINIU_PRODUCT_ICON_DOMAIN : addonPath + "/icons/product/";
		
		if(i==0) {
			navHtml += "<dl>";
			navHtml += "  <dd class='style5' id='Brolist_0' name='typename'>";
			navHtml += "    <span style='font-size:12px;'>全部</span>";
			navHtml += "  </dd>";
		}
		
		if(typeObj.name != "no_tag") {
			navHtml += "<dd class='style6' id='Brolist_"+typeObj.id+"' name='typename'>";
			navHtml += "  <span style='font-size:12px;position:relative;'>"+typeObj.name;
			navHtml += "    <span class='circle' id='typenum_"+typeObj.id+"'>0</span>";
			navHtml += "  </span>";
			navHtml += "</dd>";
			
			//遍历饮品
			var proHtml = "<ul>";
			for(var k=0;k<productlist.length;k++) {
				var product = productlist[k];
				
				proHtml += "<li id='A"+product.sku+"' style='border-top:solid 1px #f7f7f7;width:100%;height:auto;'>";
				proHtml += "  <div style='padding:10px 10px 10px 5px;' name='proitem'>";
				proHtml += "    <div style='display:inline-block;width:76px;height:76px;position:relative;float:left;'>";
				proHtml += "      <img src='"+iconpath+product.picture_small+"' alt='' style='height:100%;width:100%;float:left;border:solid 1px #f7f7f7;' />";
				proHtml += "      <span class='numCircle' name='productNum_"+product.sku+"' style='display:none;'>0</span>";
        // 如果限量供应则加上角标
        if (product.sale_limit > 0) {
          proHtml += "      <img alt='' src='"+addonPath+"/icons/ui/ico_limit.png' style='position: absolute;left:0px;top:0px; width:26px;height:26px;' />";
        }
        if(promotion_pid_arr.indexOf(product.id) > -1) {
					proHtml += "      <img alt='' src='"+addonPath+"/icons/ui/ico_pic_game.png' style='position: absolute;left:0px;bottom:-1px; width:26px;height:26px;' />";
				}
				proHtml += "    </div>";
				
				proHtml += "    <div style='display:inline-block;float:left;position:relative;word-break:break-all;word-wrap:break-word;padding-left:10px;' name='prodetail'>";
				proHtml += "      <p style='color:#353535;margin-bottom:5px;'>"+product.name+"</p>";
				proHtml += "      <p style='color:#666;font-size:12px;margin-bottom:10px;'>"+product.description+"</p>";
				proHtml += "      <div>";
				proHtml += "        <p style='margin:0px;display:inline-block;float:left;'>";
				proHtml += "          <em style='color:#ff7d50;height:20px;line-height:20px;font-size:10px;font-style:normal;'>";
				proHtml += "            <b style='font-size:18px;font-weight:normal;' id='price_"+product.sku+"'>￥"+parseFloat(product.online_price)+"</b>";
				proHtml += "             /"+product.unit;
				proHtml += "          </em>";
				proHtml += "        </p>";
				proHtml += "        <div style='float:right;overflow:hidden;' left_limit='" + product.sale_limit + "' >";
				proHtml += "          <img btn_prod='"+product.id+"' src='"+addonPath+"/icons/ui/btn_red.png' style='margin-right:8px;display:none;' name='plus_minus_btn' class='btn-cart' iden='"+product.sku+"_-1_-"+product.online_price+"_"+typeObj.id+"' flag='minus_"+product.sku+"'/>";
				proHtml += "          <img btn_prod='"+product.id+"' src='"+addonPath+"/icons/ui/btn_add.png' class='btn-cart' iden='"+product.sku+"_1_"+product.online_price+"_"+typeObj.id+"' name='plus_minus_btn' flag='plus_"+product.sku+"' /><span class='hide limit-label' >限量" + product.sale_limit + product.unit + "/天</span>";
				proHtml += "          <div style='clear:both;'></div>";
				proHtml += "        </div>";
				proHtml += "        <div style='clear:both;'></div>";
				proHtml += "      </div>";
				proHtml += "    </div>";
				proHtml += "    <div style='clear:both;'></div>";
				proHtml += "  </div>";
				proHtml += "</li>";
				
				hideInputHtml += "<input type='hidden' id='qty"+product.sku+"' value='0' name='proQty' iden='qty_"+typeObj.id+"_"+product.sku+"_"+product.id+"' proname='"+product.name+"' proprice='"+product.online_price+"' imgsrc='"+product.picture_small+"'/>";
			}
			
			proHtml += "</ul>";
			
			totalTypeDivHtml += "<div style='background-color:#fff;height:24px;line-height:24px;color:#aaa;font-size:12px;padding: 4px 0 0 10px;'>"+typeObj.name+"</div>";
			totalTypeDivHtml += proHtml;
			totalTypeDivHtml += hideInputHtml;
			totalTypeDivHtml += "<div style='clear:both'></div>";
			
			normalTypeDivHtml += "<div id='Arolist"+typeObj.id+"' class='arolist'   style='display:none;'>";
			normalTypeDivHtml += proHtml;
			normalTypeDivHtml += "</div>";
			
			normalHtml += normalTypeDivHtml;
			totalHtml += totalTypeDivHtml;
		}
	}
	
	navHtml += "</dl>";
	$("#navBar").html(navHtml);
	
	totalHtml = "<div id='Arolist0' class='arolist' style='display:block;'>" + totalHtml + "</div>";
	$("#productlist").html(totalHtml+normalHtml);
	
	bindEvent();
  initLimitedProductsInfo();
}

function checkOpenTime(siteCode) {
	var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/checkopentime.html";
	var datas = {'site_code': siteCode};
	
	$.ajax({
    url: url,
    data:datas,
    type:"POST",
    success: function(result){
      if(result) {
        count = parseInt(result.remain_time);
        isopen = result.isopen;
        timeout = setTimeout(TimeCount, 1000); // 1s执行一次TimeCount
        if (!isopen) {
          $('#siteCloseBtn').show();
          $('#submitBtn').hide();
        } else {
          $('#siteCloseBtn').hide();
          $('#submitBtn').show();
        }
      }
    }, error:function(result){
        
    }
  });
}

TimeCount = function() {
	// 启动倒计时
	if (count == 0) {
    isopen = !isopen;
    if (!isopen) {
      $('#siteCloseBtn').show();
      $('#submitBtn').hide();
    } else {
      $('#siteCloseBtn').hide();
      $('#submitBtn').show();
    }
    clearTimeout(timeout);
	} else {
		count--;
    setTimeout(TimeCount, 1000);
	}
};

//左侧菜单
function changeRO(mystr, index) {
    $(".arolist").hide();
    $(".style5").removeClass("style5").addClass('style6');

    $("#A"+mystr+index).show();
    $("#B"+mystr+"_"+index).removeClass("style6").addClass('style5');
}

function setWidth() {
	var marqWidth;
	var proitemWidth;
	var prodetailWidth;
	marqWidth = document.documentElement.clientWidth - 28 - 10;
	proitemWidth = document.documentElement.clientWidth * 0.78 - 17;
	prodetailWidth = proitemWidth - 86;
	
	$("div[name='proitem']").css("width",proitemWidth+"px");
	$("div[name='prodetail']").css("width",prodetailWidth+"px");
}

function setHeight(){
	var cHeight;
	cHeight = document.documentElement.clientHeight - 128;
	cHeight = cHeight +"px"
	document.getElementById("navBar").style.height =  cHeight;
	document.getElementById("infoSection").style.height =  cHeight;
}

window.addEventListener("DOMContentLoaded", function(){
    setHeight();setWidth();
}, false);
window.onresize = function(){ setHeight();setWidth(); }

//加减
function plus_minus(pid, number,price,tid,limit) {
	var num = parseInt($("#qty"+pid).val());//当前商品加入数量
	var totalnum = parseInt($("#totalNum").val());//所有商品加入数量
	var totalacc = parseFloat($("#totalAcc").html());//所有商品总价
	var typenum = parseInt($("#typenum_"+tid).html());//当前类型商品总加入数量
	
	num = num + parseInt(number);
	typenum = typenum+parseInt(number);
	totalnum = totalnum + parseInt(number);
	if (num < 0) {
	    return false;
	} else if(num == 0) {
		$("span[name='productNum_"+pid+"']").hide();//隐藏商品数量
		$("img[flag='minus_"+pid+"']").hide();//隐藏减号
		if(typenum==0) {
			$("#typenum_"+tid).hide();//隐藏类型数量
		}
    $("img[flag='plus_"+pid+"']").show().siblings('.limit-label').hide(); // 显示加号
	} else if(num >99 ) {
		return false;
	} else {
		$("#typenum_"+tid).show();//显示类型数量
		$("img[flag='minus_"+pid+"']").show();//显示减号
		$("span[name='productNum_"+pid+"']").show();//显示商品数量
    // 如果达到限量供应则隐藏加号
    if (limit > 0 && num >= limit) {
      $("img[flag='plus_"+pid+"']").hide().siblings('.limit-label').show();
      if (num > limit) {
        return false;
      }
    } else if (limit > 0 && num < limit) {
      $("img[flag='plus_"+pid+"']").show().siblings('.limit-label').hide(); // 显示加号
    }
	}
	
	$("#qty"+pid).val(num);
	$("#typenum_"+tid).html(typenum);
	$("span[name='productNum_"+pid+"']").html(num);
	
	$("#totalNum").val(totalnum);
	var tAcc = totalacc + Math.abs(parseInt(number)) * parseFloat(price);
	$("#totalAcc").html(tAcc.toFixed(2));
	$("#submitBtn").attr("value","点好了("+totalnum+")");
	if(totalnum <= 0) {
		$("#submitBtn").attr("disabled","disabled");
	} else {
		$("#submitBtn").removeClass("closecls").addClass("opencls").removeAttr("disabled");
	}
}

//页面跳转
function gotoOrderForm() {
	//获取参数
	var totalnum = parseInt($("#totalNum").val());
	if(totalnum == 0) {
		showTip("请选择饮品!","#infoSection");
		return false;
	}
	
	var data = {};
	data.original_amount = parseFloat($("#totalAcc").html());
	data.totalQty = totalnum;

	//获取商品信息
	var products = [];
	var pids = [];
	$("input[name='proQty'][value != '0']").each(function(){
		var product = {};
		var iden = $(this).attr("iden").split("_");
		product.type = iden[1];
		product.SKU = iden[2];
		product.id = iden[3];
		product.product_id = iden[3];
		product.name = $(this).attr("proname");
		product.qty = $(this).attr("value");
		product.price = parseFloat($(this).attr("proprice"));
		product.amount = parseFloat($(this).attr("proprice"))*parseInt(product.qty);
		product.smallpic = $(this).attr("imgsrc");

		products.push(product);
		pids.push(iden[3]);
	});

	data.products = products;
	data.pids = pids;
	sessionStorage.productsinfo = JSON.stringify(data);
	sessionStorage.orderinfo = JSON.stringify(data);
  
  // 生成产品ID用于获取口味信息
  var orderinfo = sessionStorage.orderinfo;
  orderinfo = $.parseJSON(orderinfo);
  $('#tasteinput').val(orderinfo.pids);
  $('#tasteform').submit();
}

//获取最近门店
function getNearestSite() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(doGetNearestSite);
  }
}

//获取最近门店
function doGetNearestSite(position) {
  var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/getnearestbuilding.html";
  var params = {};
  params.lat = parseFloat(position.coords.latitude);
  params['long'] = parseFloat(position.coords.longitude);
  
  _postAjax(url,params,function(result) {
    if(result) {
      result = $.parseJSON(result);
      // 成功是0 非0是失败
      if(result.ret_code == "0") {
        if (sessionStorage.deliveryInfo != undefined) {
          var deliveryInfo = $.parseJSON(sessionStorage.deliveryInfo);
          if (deliveryInfo.site_id != undefined) {
            var defaultSite = deliveryInfo.site_id;
            if (result.ret_info.building.site_id != defaultSite || !result.ret_info.in_group) {
              var msg = "您可能已不在此办公楼【" + deliveryInfo.building_name + "】，是否切换办公楼？";
              var result = confirm(msg);
              sessionStorage.notCheckLBS = true;
              if (result) {
                var url = window.location.href.replace("productlist", "siteselector");
                window.location.href = url;
              }
            }
          }
        }
      }
    }
  });
}

// 获取用户限量商品的信息
function initLimitedProductsInfo() {
  if (!sessionStorage.userInfo) {
    //初始化选中的饮品信息
    initSelectedProductsInfo();
    return; // 未登录就不检测限量商品
  }
  var deliveryInfo = $.parseJSON(sessionStorage.deliveryInfo);
  var userInfo = $.parseJSON(sessionStorage.userInfo);
  if (!userInfo.mytoken) {
    return;
  }
  
  var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/listUserLimitedProd.html";
  var params = {
    'site_id': deliveryInfo.site_id,
    'user_id': userInfo.user_id,
  };
  
  _postAjax(url,params,function(result) {
    if(result) {
      result = $.parseJSON(result);
      // 成功是0 非0是失败
      if(result.ret_code == "0") {
        var limited = result.limited_products;
        for (var i in limited) {
          var p = limited[i];
          if (p.left_limit == 0) {
            $("img[btn_prod='" + p.product_id + "']").hide().siblings('.limit-label').show();
          } else {
            $("img[btn_prod='" + p.product_id + "']").parent().attr('left_limit', p.left_limit);
          }
        }
      }
      //初始化选中的饮品信息
      initSelectedProductsInfo();
    }
  });
}
