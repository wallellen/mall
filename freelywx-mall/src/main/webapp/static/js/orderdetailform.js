var corder_code = null;
var openFromWxMsg = 0;

$(function(){
	corder_code = getQueryString(window.location.href,"corder_code");
	openFromWxMsg = getQueryString(window.location.href,"ofxm");
	
	initData();
	bindEvent();
});

function initData() {
	getOrderDetailInfo();
}

function bindEvent() {
	$("#orderstatusLink").click(function(){
		var $obj = $("#orderstatus");
		if($obj.css("display") == "none") {
			$obj.show();
			$(this).html("[鏀惰捣鐗╂祦璇︽儏]");
		} else {
			$obj.hide();
			$(this).html("[鏌ョ湅鐗╂祦璇︽儏]");
	    }
	});

	$("#orderlistLink").click(function() {
		//鑾峰彇璺宠浆鍦板潃 - 涓存椂
	    var url = window.location.href.replace("orderdetailform","orderlist");
	    $(this).attr("href",url);
	});

	$("#cancelBtn").on("click",function(){
		cancleOrder();
	});

	$("#signBtn").on("click",function(){
		signOrder();
	});

	$("#payBtn").on("click",function(){
		payOrder();
	});

//	$(window).unload(function(){
//		  alert("Goodbye!");
//	});

//	window.onbeforeunload = function(){alert(2);
//		//鑾峰彇璺宠浆鍦板潃 - 涓存椂
//	    var url = window.location.href.replace("orderdetailform","home");
//	    window.location.href = url;
//	}
}

function getOrderDetailInfo() {
	if(corder_code == undefined || corder_code == null) {
		alert("褰撳墠娌℃湁璁㈠崟");
		return false;
	} else {
		var params = {};
		params.order_code = corder_code;

		var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/getorderdetail.html";
		_postAjax(url,params,function(result){
			if(result) {
				result = $.parseJSON(result);
				if(result.ret_code == "0") {// 鎴愬姛鏄�0 闈�0鏄け璐�
					initPage(result);
				}else if(result.ret_code == "2") {
					alert("鐧诲綍淇℃伅鏃犳晥锛岃閲嶆柊鐧诲綍");
					navigateTo("orderdetailform","login");
					return false;
				} else {
					alert("璁㈠崟鑾峰彇澶辫触");
					return false;
				}
			}
		});
	}
}

//鏇存柊璁㈠崟淇℃伅
function updateOrder(data) {
	//鑾峰彇褰撳墠璁㈠崟鍙�
	if(corder_code == undefined) {
		alert("褰撳墠娌℃湁璁㈠崟");
		return false;
	} else {
		data.order_code = corder_code;

		var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/updateorder.html";
		_postAjax(url,data,function(result){
			if(result) {
				result = $.parseJSON(result);
				if(result.ret_code == "0") {// 鎴愬姛鏄�0 闈�0鏄け璐�
					window.location.reload();
				} else if(result.ret_code == "2") {
					alert("鐧诲綍淇℃伅鏃犳晥锛岃閲嶆柊鐧诲綍");
					navigateTo("orderdetailform","login");
					return false;
				} else {
					alert(data.oper_msg+"澶辫触");
					return false;
				}
			}
		});
	}
}

//鍙栨秷璁㈠崟
function cancleOrder() {
	var data = {};
	data.status = "9";//宸插彇娑�
	data.comments = "鍙栨秷璁㈠崟";
	data.oper_msg = "璁㈠崟鍙栨秷";//鐢ㄤ簬鏄剧ず鎻愮ず娑堟伅
	updateOrder(data);
}

//绛炬敹璁㈠崟
function signOrder() {
	var data = {};
	data.status = "7";//宸茬鏀�
	data.comments = "绛炬敹璁㈠崟";
	data.oper_msg = "璁㈠崟绛炬敹";//鐢ㄤ簬鏄剧ず鎻愮ず娑堟伅
	updateOrder(data);
}

function payOrder() {
	//鑾峰彇璺宠浆鍦板潃 - 涓存椂
    var url = window.location.href.replace("orderdetailform","goingpayform");
    url = url.replace("&corder_code="+corder_code,"");
    window.location.href = changeURLPar(url,"showwxpaytitle","1")+"&order_code="+corder_code;
}

//娓叉煋椤甸潰
function initPage(data) {
	$("#orderStatus").html(order_status_map.get(data.status));
	initProducts(data.products, data.actual_amount);
	initPromotions(data.order_promotion_items);

	$("#totalamount").html("锟�"+data.actual_amount);//TODO:鍔犱簡浼樻儬鍚庡簲璇ユ樉绀虹殑鏄疄闄呴噾棰� actual_amount
	$("#ordercode").html(data.order_code);
	$("#ordertime").html(data.paid_time);
	$("#phone").html(data.contact_number);
	$("#contact").html(data.contact);
	$("#address-2").html(data.address);
	// 閰嶉€佽鍗�
	if (data.delivery_type == "0") {
    $("#address").html('鏋侀€熼厤閫�');
	} else { // 鑷彇璁㈠崟
    $("#address").html('闂ㄥ簵鑷彇');
	}
  // 鏀粯鏂瑰紡
  if (data.payment_type == "0") {
    if (data.online_pay_approach == "0") {
      $('#paymenttype').html('寰俊鏀粯');
    } else if (data.online_pay_approach == "1") {
      $('#paymenttype').html('鏀粯瀹濇敮浠�');
    } else if(data.account_amount > 0) {
      $('#paymenttype').html('浣欓鏀粯');
    } else {
    	$('#paymenttype').html('');
    }
  } else if (data.payment_type == "1") {
    $('#paymenttype').html('璐у埌浠樻');
  } else if (data.payment_type == "2") {
    $('#paymenttype').html('闂ㄥ簵鏀粯');
  }
  
  if (data.status == "1") {//寰呮敮浠�
    //鑾峰彇鐢ㄦ埛淇℃伅
    var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/getuserinfo.html";
    var params = {};
    params.account = data.account;
    _postAjax(url,params,function(result2){
      if(result2) {
        result2 = $.parseJSON(result2);
        if(result2.ret_code == "0") {// 鎴愬姛鏄�0 闈�0鏄け璐�
          //鏄剧ず鎸夐挳
          $("#divsubBtn").show();
        } else if(result.ret_code == "2") {
          alert("鐧诲綍淇℃伅鏃犳晥锛岃閲嶆柊鐧诲綍");
          //window.location.href = "./index.php?s=/addon/CoffeeStore/CoffeeStore/nonlogin.html";
          navigateTo("orderdetailform","login");
          return false;
        } else {
          alert("鐢ㄦ埛淇℃伅鑾峰彇澶辫触");
          return false;
        }
      }
    });
  }
  
  // 灞曠ず璁㈠崟鐘舵€�
  var show_status_label_list = ["1","8","9","10","11","13","14","15","16"];//鐩存帴鏄剧ず鐘舵€佺殑鍒楄〃
  if (data.delivery_type == "1") {
    if (data.status == 4) {
      $("#orderStatus").html("绛夊緟鑷彇");
    }
    if (data.status != "1") {
        $('#payBtn').hide();
    }
    $('#unpaid').fadeIn();
  } else if (show_status_label_list.indexOf(data.status) > -1) {
    if (data.status != "1") {
      $('#payBtn').hide();
    }
    $('#unpaid').fadeIn();
  } else {
    var statusId = '#paidst1';//data.status == "2"鏃�
    if (data.status == "3") {
      statusId = '#paidst2';
    } else if (data.status == "4" || data.status == "5" || data.status == "6") {
      statusId = '#paidst3';
    } else if (data.status == "7" || data.status == "12") {
      statusId = '#paidst4';
    }
    $(statusId).show();
    $('#paid').fadeIn();
  }
  
  if (data.offline_order_id) {
    $('#offlineorderid').html(data.offline_order_id);
    $('#offlineorder').show();
  }
  
  //0涓虹珛鍗抽厤閫侊紝1涓洪绾�
  if(data.appointment == 1) {
      $("#appointTime").html((new Date(data.appoint_start.replace(/-/g,"/"))).format('yyyy-MM-dd hh:mm')+"-"+(new Date(data.appoint_end.replace(/-/g,"/"))).format('hh:mm'));
      $("#appointLi").show();
  }
  
  //鏄剧ず璁㈠崟璇勪环淇℃伅,璁㈠崟璇勪环鐘舵€侊細0涓轰笉闇€璇勪环锛�1涓哄緟璇勪环锛�2涓哄凡璇勪环
  var picPath = $.trim($("#uiIconPath").val());
  if(data.evaluate_status == ORDER_EVALUATE_NO) {
      //涓嶉渶璇勪环鍒欎笉鐢ㄦ樉绀鸿瘎浠蜂俊鎭�
      $("#evaluateSec").hide();
  } else if(data.status == "7" || data.status == "8" || data.status == "12"){
      $("#evaluateSec").show();
      if(data.evaluate_status == ORDER_EVALUATE_DONE) {
          $("#hasEvaluationUl").show();
          $("#noEvaluationUl").hide();
          //宸茶瘎浠�
          var evaluation = data.evaluate;
          var starstr = "";
          for(var i=1;i<=5;i++) {
              if(i<=evaluation.score_value) {
                  starstr += "<img src='"+picPath+"/ico_star_check.png' style='width:15px;height:auto;'/>";
              } else {
                  starstr += "<img src='"+picPath+"/ico_star_normal.png' style='width:15px;height:auto;'/>";
              }
          }
          
          $("#stars").html(starstr);
          $("#evaluateTime").html(evaluation.created);
          if(evaluation.evaluation_item == undefined || evaluation.evaluation_item == "") {
              $("#pointval").hide();
          } else {
              $("#pointval").html(order_evaluation_point_map.get(evaluation.evaluation_item));
              $("#pointval").show();
          }
          
          if(evaluation.comments == undefined || evaluation.comments == "") {
              $("#evaComsLi").hide();
          } else {
              $("#eva_comments").html(evaluation.comments);
              $("#evaComsLi").show();
          }
          
          if(evaluation.feedback == undefined) {
              $("#feedbacklbl").hide();
          } else {
              $("#feedbackval").html(evaluation.feedback);
              $("#feedbacklbl").show();
          }
      } else if(data.evaluate_status == ORDER_EVALUATE_PEND) {
          //寰呰瘎浠�
          $("#hasEvaluationUl").hide();
          $("#noEvaluationUl").show();
          $("#evaluateBtn").click(function(){
              submitEvaluation(picPath,corder_code,function(){
                  window.location.reload();
              });
          });
          
          if(parseInt(openFromWxMsg) == 1) {
              //浠庡井淇℃秷鎭腑鐩存帴鎵撳紑璁㈠崟璇︽儏锛屽垯鐩存帴鎵撳紑璇勪环寮瑰嚭妗�
              $("#evaluateBtn").click();
          }
      }
  }
}

//鍒濆鍖栬鍗曚腑鍟嗗搧
function initProducts(products, actualAmount) {
	var htmlstr = "";
	var toltstr = "";
	var totalQty = 0;

	for(var i=0; i<products.length; i++) {
		var product = products[i];
		htmlstr += "<li style='height:60px;line-height:60px;padding-top:10px;'>";
		htmlstr += "  <div style='height:26px;line-height:26px;'>";
		htmlstr += "    <span class='c1'>"+product.name+"</span>";
		htmlstr += "    <span class='c3'>锟�"+parseFloat(product.amount / product.qty).toFixed(2)+"</span>";
		htmlstr += "    <div style='clear:both;'></div>";
		htmlstr += "  </div>";
		htmlstr += "  <div style='height:26px;line-height:26px;'>";
		if(product.taste && product.taste.length > 0) {
			var tastestr = product.taste;
			tastestr = replaceAll(tastestr,"\\|",' ');
			htmlstr += "    <span class='c1' style='color:#703B11;'>"+tastestr+"</span>";
		} else {
			htmlstr += "    <span class='c1' style='color:#703B11;'>鏍囧噯鍋氭硶</span>";
		}
		
		htmlstr += "    <span class='c3' style='color:#686868;'>脳"+parseInt(product.qty)+"</span>";
		htmlstr += "    <div style='clear:both;'></div>";
		htmlstr += "  </div>";
		htmlstr += "</li>";
		totalQty += parseInt(product.qty);
	}
	
	toltstr += "<li class='nobottom sumli' style='margin:0 20px 2px;padding:0'>";
	toltstr += "  <span class='fl totalamount'><i>鍏辫" + totalQty + "鏉�</i></span>" + "<span class='fr totalamount'>鍚堣:<b>锟�" + actualAmount + "</b></span>";
	toltstr += "</li>";
  
	$("#productslist").html(htmlstr);
	$("#totalAmountUL").html(toltstr);
}

//鍒濆鍖栬鍗曚腑鐨勪績閿€鍟嗗搧
function initPromotions(promotions) {
	if(promotions == undefined) {
		return false;
	}
	
	var htmlstr = "";
	for(var i=0;i<promotions.length;i++) {
		var proObj = promotions[i];
		htmlstr += "<li style='height:auto;line-height:auto;min-height:60px;'>";
		htmlstr += "  <div style='height:26px;line-height:26px;'>";
		htmlstr += "    <span class='c1'>"+proObj.name+"</span>";
		htmlstr += "    <span class='c3'>锟�"+proObj.amount+"</span>";
		htmlstr += "    <div style='clear:both;'></div>";
		htmlstr += "  </div>";
		htmlstr += "  <div style='height:26px;line-height:26px;'>";
		htmlstr += "    <span class='c1' style='color:#F55A34;width:90%;font-size:12px;'>";
		htmlstr += "      <span style='font-size:10px;height:12px;line-height:12px;font-size:10px;display:inline-block;border:solid 1px #F55A34;-webkit-border-radius:5px;border-radius:5px;padding:2px 2px 0;margin-bottom:1px;'>娲诲姩</span>";
		htmlstr += "      <span>"+setWithDefaultValue(proObj.title,"淇冮攢娲诲姩")+"</span>";
		htmlstr += "    </span>";
		htmlstr += "    <span class='c3' style='color:#686868;width:10%;'>脳"+parseInt(proObj.qty)+"</span>";
		htmlstr += "    <div style='clear:both;'></div>";
		htmlstr += "  </div>";
		htmlstr += "</li>";
	}
	
	$("#promotionlist").html(htmlstr);
}