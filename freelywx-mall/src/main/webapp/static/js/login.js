var timeout;
var count = 45; // 倒数45秒
$(function(){
	initData();
	bindEvent();
  if ($.trim($("#tel").val()).length == 11) {
    sendVcode();
  }
});

function initData() {
	var type = getQueryString(window.location.href,"signtype");
	if(type==undefined) {
		//do nothing
	} else {
		var lbl = "登录";
		if(type=='zc') {
			lbl = "注册";
		}
		$("#noticeinfo span").html("请输入您的手机号码进行"+lbl);
	}
}

function bindEvent() {
	$("#sendBtn").click(function(){
		sendVcode();
	});
	
	$("#submitBtn").click(function(){
		verifyVcode();
	});
}

//发送验证码
function sendVcode() {
	var tel = $.trim($("#tel").val());
	
	if(tel == "") {
		showTip("请输入手机号码","form");
		//$("#tel").focus();
		return false;
	}
	
	//发送验证码
	var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/sendvcode.html";
	var data = {};
	data.account = tel;
	
	$("#sendBtn").hide();
	$("#resendBtn").show();
	
	timeout = setTimeout(BtnCount, 1000); // 1s执行一次BtnCount
	
	_postAjax(url,data,function(result){
		if(result) {
			result = $.parseJSON(result);
			
			if(result.ret_code == "0") {// 成功是0 非0是失败
				$("#validcode").removeAttr("disabled");
			} else {
				showTip("验证码发送失败","form");
				return false;
			}
		} else {
			showTip("验证码发送失败","form");
			return false;
		}
	});	
}

BtnCount = function() {
	// 启动按钮
	if (count == 0) {
		$("#sendBtn").show();
		$("#resendBtn").hide();
	    clearTimeout(timeout);           // 可取消由 setTimeout() 方法设置的 timeout
	    count=45;
	    $("#resendBtn").attr("value","重新发送("+count+")");
	}
	else {
	    count--;
	    $("#resendBtn").attr("value","重新发送("+count+")");
	    setTimeout(BtnCount, 1000);
	}
};

//验证验证码
function verifyVcode() {
	var disableAttr = $("#validcode").attr("disabled");
	var code = $.trim($("#validcode").val());
	var tel = $.trim($("#tel").val());
	
	if( disableAttr && disableAttr == "disabled") {
		showTip("请先发送验证码","form");
		return false;
	}
	
	if(code == "") {
		showTip("请输入验证码","form");
		//$("#validcode").focus();
		return false;
	}
	
	//验证验证码
	var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/verifyvcode.html";
	var data = {};
	data.account = tel;
	data.vcode = code;
	data.social_account = "新用户";//TODO
	data.social_account_type = 1;//TODO
	
	_postAjax(url,data,function(result){
		if(result) {
			result = $.parseJSON(result);
			//alert(JSON.stringify(result));
			if(result.ret_code == "0") {// 成功是0 非0是失败
				//先删除现有的
				sessionStorage.removeItem("userInfo");
        		//sessionStorage.clear();
				//保存用户信息
				var userInfo = {};
				userInfo.user_id = result.user.id;
				userInfo.contact_number = tel;
				userInfo.mytoken = result.mytoken;
				userInfo.account = result.user.account;
				userInfo.default_site = result.user.default_site;
				userInfo.default_building = result.user.default_building;
				userInfo.name = result.user.name;
				userInfo.remain_amount = result.user.remain_amount;
				
				sessionStorage.userInfo = JSON.stringify(userInfo);
				
				var type = getQueryString(window.location.href,"signtype");
				if(type==undefined) {
					//从下单页面过来
					var orderinfo = sessionStorage.orderinfo;
					if(orderinfo == undefined) {
						showTip("订单信息不存在,请重新选择饮品下单","form");
						return false;
					} else {
						//回到配送方式选择页面
						var url = window.location.href.replace("login","postwayselector");
				        window.location.href = url;
					}
				} else {
					//从注册或登录页面过来，回到我的页面
					var url = window.location.href.replace("login","mypage").replace("&signtype=zc","").replace("&signtype=dl","");
			        window.location.href = url;
					//navigateTo("login","mypage");
				}
			} else {
				showTip("验证码不正确","form");
				return false;
			}
		} else {
			showTip("验证码不正确","form");
			return false;
		}
	});	
}