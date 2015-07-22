$(document).ready(function(){
	FastClick.attach(document.body);
	
	//bindEvent();
	//initData();
});

function initData() {
	initUserInfo();
}

function bindEvent() {
	$("#nav_bar ul li a").click(function(){
        //获取跳转地址 - 临时
        var url = window.location.href.replace("mypage",$(this).attr("id"));
        $(this).attr("href",url);
    });
	
	$("#aboutus").click(function(){
	    window.location.href = "http://mp.weixin.qq.com/s?__biz=MjM5Nzg4NDk5NQ==&mid=207116333&idx=1&sn=6dfe6b6fa54593577f868eb48c466b00&scene=1&key=c468684b929d2be27bcfdf51075746453066d9e9c5dd6fb97ddbda293697c4ca8eb1fa8d045498ca50c2fe50cac2844e&ascene=0&uin=MTU1ODkzMDU%3D&devicetype=iMac+MacBookPro11%2C1+OSX+OSX+10.10.3+build(14D136)&version=11020012&pass_ticket=%2F1MTub2byIvTjuKX4kqO2DPZlh3WaLAIKo%2Fx5%2F8UuRM%3D";
	});
}

function initUserInfo() {
	//获取用户信息
	var userInfo = sessionStorage.userInfo;
	
	if(userInfo == undefined) {
		$("#myinfo").hide();
        $("#myaccount").hide();
        $("#mycoupon").hide();
		$("#loginSection").show();
		
		$("#mysuggestion, #login, #myinfo, #myaccount, #mycoupon").unbind();
		$("#mysuggestion, #login, #myinfo, #myaccount, #mycoupon").click(function(){
			if(this.id == "login") {
				//获取跳转地址 - 临时
				//window.location.href = window.location.href.replace("mypage",$(this).attr("id"));
				navigateTo("mypage",$(this).attr("id"));
			} else {
				alert("您还未登录，请先登录");
				return false;
			}
		});
	} else {
		$("#myinfo").show();
		$("#loginSection").hide();
		
		userInfo = $.parseJSON(userInfo);
		var url = "http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/getuserinfo.html";
		var data = {};
		data.account = userInfo.account;
		
		_postAjax(url,data,function(result){
			if(result) {
				result = $.parseJSON(result);
				if(result.ret_code == "0") {// 成功是0 非0是失败
					//填充信息
					var remain_amount = (result.user.remain_amount) ? result.user.remain_amount : 0.00;
					$("#user_name").html(result.user.name);
					$("#phone_number").html(result.user.account);
					$("#remain_amount").html('￥'+remain_amount+"元");
					if(result.user.head_pic == undefined) {
					    $("#headpic").attr("src",$("#publicPath").val()+"/icons/ui/pic_body.png");
					} else if(result.user.head_pic.indexOf('http') > -1) {
					    $("#headpic").attr("src",result.user.head_pic);
					} else {
					    //todo
					}
					
					$("#mysuggestion, #login, #myinfo, #myaccount, #mycoupon").unbind();
					$("#mysuggestion, #login, #myinfo, #myaccount, #mycoupon").click(function(){
						//获取跳转地址 - 临时
				        //var url = window.location.href.replace("mypage",$(this).attr("id"));
				        //window.location.href = url+"&account="+userInfo.account;
						navigateTo("mypage",$(this).attr("id"));
					});
				} else if(result.ret_code == "2") {
					alert("登录信息无效，请重新登录");
					//window.location.href = "./index.php?s=/addon/CoffeeStore/CoffeeStore/nonlogin.html";
					navigateTo("mypage","login");
					return false;
				} else {
					alert("用户信息获取失败");
					return false;
				}
				
			} else {
				alert("用户信息获取失败");
				return false;
			}
		},function(result){//出错时
	        alert("用户信息失败");
	        return false;
		});
	}
}