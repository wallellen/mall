var addonpath = "";
var pageSize = 10;
var pageNumber = 0;
$(document).on("pageinit",function(){
	addonpath = $("#addonpath").val();
	
	initData();
	bindEvent();
});

function initData() {
	getOrderList();
}

function bindEvent() {
   $("#nav_bar ul li a").click(function(){
	   //获取跳转地址 - 临时
	   var url = window.location.href.replace("orderlist",$(this).attr("id"));
	   $(this).attr("href",url);
   });
  $('#btnLoadMore').click(function() {
    getOrderList();
  });
}

function getOrderList() {
	//获取用户信息
	var userInfo = sessionStorage.userInfo;
	if(userInfo == undefined) {
		generateEmptyContent();
	} else {
		userInfo = $.parseJSON(userInfo);
		var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/getorderlist.html";
		var data = {};
		data.user_id = userInfo.user_id;
		data.page_size = pageSize;//获取所有
		data.page_num = pageNumber;//获取所有
		
		//显示加载器 
		$.mobile.loading('show', {  
	        text: '加载中...', //加载器中显示的文字  
	        textVisible: true, //是否显示文字  
	        theme: 'a',        //加载器主题样式a-e  
	        textonly: false,   //是否只显示文字  
	        html: ""           //要显示的html内容，如图片等  
	    }); 
        
		_postAjax(url,data,function(result) {
			if(result) {
				result = $.parseJSON(result);
        getNotifications();
				if(result.ret_code == "0") {// 成功是0 非0是失败
					//生成列表
					if(result.orders.length>0) {
						generateList(result.orders);
            pageNumber++;
					} else {
            $('#loadMore').hide();
						generateEmptyContent();
					}
				} else {
					generateEmptyContent();
				}
				
				//隐藏加载器   
				$.mobile.loading('hide');
			}
		},function(result){//出错时
			//隐藏加载器   
			$.mobile.loading('hide');
	        alert("订单列表获取失败");
	        return false;
		});
	}
}

function generateEmptyContent() {
  if ($('#order_list').html().length > 0) {
    return;
  }
  
	var htmlstr = "";
	
	htmlstr += "<div style='width:80%;text-align:center;margin-left:10%;margin-top:20%;'>";
	htmlstr += "    <img style='width:100px;height:100px;' src='" + addonpath + "/icons/ui/pic_orders_nothing.png'/>";
	htmlstr += "    <div style='color:#656565;font-size:14px;margin-top:20px;margin-bottom:50px;'>";
	htmlstr += "        <p>你还没有喝过我们家的咖啡</p>";
	htmlstr += "        <p>要不要来一杯呢？</p>";
	htmlstr += "    </div>";
	htmlstr += "    <div class='o_btn clearfix'>";
	htmlstr += "        <input data-role='none' type='button' class='o_btn_red' value='立即下单' style='width:100%;' id='orderBtn'/>";
	htmlstr += "        <div style='clear:both'></div>";
	htmlstr += "    </div>";
	htmlstr += "</div>";
	
	$("#order_list").html(htmlstr);
	$("#orderBtn").click(function(){
		navigateTo("orderlist","productlist");
	});
}

function generateList(orders) {
	var htmlstr = "";
	var iconpath = USE_QINIU_ICON ? QINIU_PRODUCT_ICON_DOMAIN : addonpath + "/icons/product/";
	
	for(var i=0;i<orders.length;i++) {
		var order = orders[i];
		var products = order.products ? order.products : [];
		var status = order_status_map.get(order.status);
	    if (order.delivery_type == "1" && order.status == "4") {
	      status = "等待自取";
	    }
	    
		var ordertime = order.created;
		if(order.paid_time) {
			ordertime = order.paid_time;
		}
		htmlstr += "";
		htmlstr += "<div class='p_mod'>";
		htmlstr += "  <div>";
		htmlstr += "    <ul>";
		htmlstr += "        <li>";
		htmlstr += "            <span style='line-height:18px'>"+ordertime+"</span>";
	    if (order.status == 0) {
	      htmlstr += "            <span style='float:right;color:#EE4A2A' id='status_"+order.order_code+"'>"+status+"</span>";
	    } else if (order.status > 0 && order.status < 3) {
	      htmlstr += "            <span style='float:right' id='status_"+order.order_code+"'>"+status+"</span>";
	    }  else if (order.status > 3 && order.status < 8) {
	      htmlstr += "            <span style='float:right;color:#F18F28' id='status_"+order.order_code+"'>"+status+"</span>";
	    } else if (order.status > 8) {
	      htmlstr += "            <span style='float:right;color:#A0A0A0' id='status_"+order.order_code+"'>"+status+"</span>";
	    } else {
			  htmlstr += "            <span style='float:right;' id='status_"+order.order_code+"'>"+status+"</span>";
	    }
	    
		htmlstr += "        </li>";
		htmlstr += "        <li class='addContact'>";
		htmlstr += "            <a href='#' style='display:block;margin-left:0px;' rel='external' id='c_"+order.order_code+"' name='orderitem'>";
		htmlstr += "                <span style='margin-left:0px;margin-right:20px;float:left;width:100%;'>";
		var totalQty = 0;
		for (var k=0;k<products.length;k++) {
			var product = products[k];
			if(k < 4) {
			    htmlstr += "<div class='prod-list'><img alt='" + product.name + "' src='" + iconpath + product.picture_small + "' /><label>" + product.name + "</label></div>";
			}
			
			totalQty += parseInt(product.qty);
		}

		htmlstr += "                </span>";
		htmlstr += "                <div class='clearFix'></div>";
		htmlstr += "            </a>";
		htmlstr += "        </li>";
    
      htmlstr += "        <li style='padding:0 17px;line-height:44px;font-size:14px;color:#353535' id='btnli_"+order.order_code+"'>";
      htmlstr += "            <span style='color:#888888;float:left;font-size:12px;'>共计:</span><span style='float:left'>" + parseInt(totalQty) + "杯</span><span style='color:#888888;margin-left:6px;float:left;font-size:12px'>合计:</span><span style='float:left'>￥"+order.actual_amount+"</span>";
    
    
	    htmlstr += "            <div class='o_btn' style='margin:0px;float:right;position:relative'>";
	    if(order.status == "1") {//待支付
			htmlstr += "                <input type='button' name='lipaybtn' id='payBtn_"+order.order_code+"' class='o_btn_back ts1 paybtn' value='去支付' style='width:auto;height:30px;line-height:30px;margin-top:7px;padding:0 10px;background:none;border-color:#E1312B;color:#E1312B;text-shadow:none;'/>";
		} else if (order.delivery_type == "0" && order.appointment == "1" && (order.status >1 && order.status < 6)) {
		    htmlstr += "                <span>预约 "+(new Date(order.appoint_start.replace(/-/g,"/"))).format('hh:mm')+"-"+(new Date(order.appoint_end.replace(/-/g,"/"))).format('hh:mm')+" 送达</span>";
		} else if ((order.status == "7" || order.status == "8" || order.status == "12") && parseInt(order.evaluate_status) == ORDER_EVALUATE_PEND) {
		    htmlstr += "                <input type='button' name='liEvaluateBtn' id='evaluateBtn_"+order.order_code+"' class='o_btn_back ts1 paybtn' value='去评价' style='width:auto;height:30px;line-height:30px;margin-top:7px;padding:0 10px;background:none;border-color:#E1312B;color:#E1312B;text-shadow:none;'/>";
		}
    
	    htmlstr += "            </div>";
	    htmlstr += "            <div class='clearFix'></div>";
	    htmlstr += "        </li>";
		
		htmlstr += "    </ul>";
		htmlstr += "  </div>";
		htmlstr += "</div>";
	}
	
	$("#order_list").append(htmlstr);
	
	$("#order_list ul li a[name='orderitem']").click(function(){
		//页面跳转
	   var url = window.location.href.replace("orderlist","orderdetailform");
	   window.location.href = changeURLPar(url,"corder_code",this.id.split("_")[1]);
	});
	
	//签收
	$("input[name='lisignbtn']").click(function(){
		var order_code = this.id.split("_")[1];
		if(confirm("请收到饮品后再签收，确定继续?")) {
			signOrder(order_code);
		}
	});
	
	//去支付订单
	$("input[name='lipaybtn']").click(function(){
		var order_code = this.id.split("_")[1];
		payOrder(order_code);
	});
	
	//去评价订单
    $("input[name='liEvaluateBtn']").click(function(){
        var order_code = this.id.split("_")[1];
        var picPath = addonpath+"/icons/ui";
        submitEvaluation(picPath,order_code,function(){
            window.location.reload();
        });
    });
	
	function payOrder(order_code) {
		//获取跳转地址 - 临时
	    var url = window.location.href.replace("orderlist","goingpayform");
	    window.location.href = changeURLPar(url,"showwxpaytitle","1")+"&order_code="+order_code;
	}
}

//签收订单
function signOrder(order_code) {
	var data = {};
	data.order_code = order_code;
	data.status = "7";//已签收
	data.comments = "签收订单";
	data.oper_msg = "订单签收";//用于显示提示消息
	
	var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/updateorder.html";
	_postAjax(url,data,function(result){
		if(result) {
			result = $.parseJSON(result);
			if(result.ret_code == "0") {// 成功是0 非0是失败
				//window.location.reload();
				//签收成功
				$("#status_"+order_code).html(order_status_map.get(data.status));//更新显示状态
				$("#signBtn_"+order_code).remove();//删除按钮
			} else if(result.ret_code == "2") {
				alert("登录信息无效，请重新登录");
				navigateTo("orderlist","login");
				return false;
			}else {
				alert(data.oper_msg+"失败");
				return false;
			}
		}
	});
}