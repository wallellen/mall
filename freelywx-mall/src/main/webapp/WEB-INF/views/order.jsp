<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html>
<html class="ui-mobile">
<head>
<!-- base href="http://m.8hcoffee.com/wx/index.php?s=/addon/CoffeeStore/CoffeeStore/orderlist.html&token=gh_afd96c055327&getOpenId=1" -->
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta name="HandheldFriendly" content="true">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="description" content="">

<title>8小时咖啡</title>

<script type="text/javascript" src="${js}/jquery-2.0.3.js"></script>
<script type="text/javascript" src="${js}/spin.js"></script>
<script type="text/javascript" src="${js}/jquery.spin.js"></script>
<script type="text/javascript" src="${js}/myloading.js"></script>
<script type="text/javascript" src="${js}/common.js"></script>
<script type="text/javascript">
	sessionStorage.userInfo = JSON
			.stringify({
				"id" : "3340",
				"account" : "18271812185",
				"social_account" : "\u4e00\u6487\u9633\u5149",
				"social_account_type" : "1",
				"name" : "\u4e00\u6487\u9633\u5149",
				"age" : null,
				"gender" : null,
				"qq" : null,
				"email" : null,
				"remain_amount" : "0",
				"status" : 1,
				"created" : "2015-07-08 22:32:58",
				"mytoken" : "enySJtjgb6G%lKl,bqno000oQvi9IDogIjE4MjcxODEyMTg1IiwgImlzc3VlZF9hdCIgOiAiMjAxNS0wNy0wOSAyMToxMzo0NyJ9",
				"user_id" : "3340"
			});
</script>
<script type="text/javascript">
	/* var userInfo = sessionStorage.userInfo;
	var url = window.location.href;
	if (userInfo == undefined && window.location.href.indexOf("refresh_session") <= 0) {
	  window.location.href = (url + "&refresh_session=true");
	} else if (userInfo != undefined && url.indexOf('refresh_session') > 0) {
	  url = url.replace('&refresh_session=true', '');
	  if (url.indexOf("orderform") <= 0 && url.indexOf("goingpayform") <= 0 && url.indexOf("myaccount") <= 0) {
	    if (url.indexOf("showwxpaytitle") > 0) {
	      url = url.replace("&showwxpaytitle=1", "");
	    }
	  }
	  window.location.href = url;
	} else if (url.indexOf("orderform") <= 0 && url.indexOf("goingpayform") <= 0 && url.indexOf("myaccount") <= 0) {
	  if (url.indexOf("showwxpaytitle") > 0) {
	    url = url.replace("&showwxpaytitle=1", "");
	    window.location.href = url;
	  }
	} */
</script>
        <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
        <script type="text/javascript" src="${js }/fastclick.min.js"></script>
        <title>口味定制</title>
        <link href="${css }/common.css" rel="stylesheet" type="text/css">
        <style>
            .taste_notice {height:52px;line-height:52px;text-align:center;background-color:#fff;color:#ff7d50;}
            .taste_item {display:inline-block;border:solid 1px #e9e9e9;border-radius:5px; width:25%;font-size:14px;height:32px;line-height:32px;text-align:center;cursor:pointer;margin:14px 20px 14px 0;}
            .taste_item.selected {color:#f18f28;border:solid 1px #f18f28;}
        </style>
        <script type="text/javascript">
            var productsInfo = null;
		        function setHeight(){
		            var  cHeight;
		            cHeight = document.documentElement.clientHeight - 70;
		            cHeight = cHeight +"px"
		            document.getElementById("maincontent").style.height =  cHeight;
		        }

		      window.addEventListener("DOMContentLoaded", function(){setHeight();}, false);
		      window.onresize = function(){setHeight();}
		      
		      $(function(){
		    	  FastClick.attach(document.body);
		    	  getProductTasteByIds();
		    	  $("#okBtn").click(function(){
		    		  submitTaste();
		    	  });
		      });
		      
		      function getProductTasteByIds() {
	              var url = "./index.php?s=/addon/CoffeeStore/CoffeeStore/getproducttastebyids.html";
	              var orderinfo = sessionStorage.orderinfo;
	              if(orderinfo == undefined) {
	                  navigateTo("tastesetting","productlist");
	                  return false;
	              }
	              orderinfo = $.parseJSON(orderinfo);
	              _postAjax(url,orderinfo,function(result){
	                  if(result) {
	                      result = $.parseJSON(result);
	                     // 成功是0 非0是失败
	                      if(result.ret_code == "0") {
	                    	  productsInfo = result.products;
	                    	  generateHtml(productsInfo);
	                      } else if(result.ret_code == "1"){
	                          alert("口味信息获取失败");
	                          return false;
	                      } else if(result.ret_code == "2") {
	                          alert("登录信息无效，请重新登录");
	                          navigateTo("tastesetting","login");
	                          return false;
	                      } else {
	                          alert("口味信息获取失败，请重试");
	                          return false;
	                      }
	                      
	                  } else {
	                      alert("口味信息获取失败");
	                      return false;
	                  }
	              },function(result){
	                  //出错时
	                  alert("口味信息获取失败");
	                  return false;
	              });
	          }
		      
		      function generateHtml(products) {
		    	  var htmlstr = "";
		    	  for(var i=0; i< products.length; i++) {
		    		  var product = products[i];
		    		  var hidestyle = "display:none;";
		    		  if(product.taste != null && product.taste != undefined) {
		    			  hidestyle = "";
		    		  }
		    		  
		    		  htmlstr += "<li style='height:auto;margin-bottom:10px;background-color:#ffffff;"+hidestyle+"' id='prod_"+product.id+"_"+product.index+"'>";
	                  htmlstr += "  <div style='border-bottom:solid 1px #e9e9e9;'>";
	                  htmlstr += "    <span>"+product.name+"</span><span>￥"+product.price+"</span>";
	                  htmlstr += "  </div>";
	                  if(product.taste != null && product.taste != undefined) {
	                	  htmlstr += "  <div>";
	                	  for(var j=0; j<product.taste.length;j++) {
	                          var tasteObj = product.taste[j];
	                          htmlstr += "    <div class='taste_item' style='position:relative;' name='tasteItem' tname='"+tasteObj.name+"' tid='"+tasteObj.id+"'>";
	                          htmlstr += "      <span>"+tasteObj.name+"</span>";
	                          htmlstr += "      <span style='' class='free_item'></span>";
	                          htmlstr += "    </div>";
	                      }
	                	  htmlstr += "  </div>";
	                  } else {
	                	  htmlstr += "  <div><span style='color:#aaa;'>暂无口味(标准做法)</span></div>";
	                  }
	                  
	                  htmlstr += "</li>";
		    	  }
		    	  
		    	  $("#plist").html(htmlstr);
		    	  $("div[name='tasteItem']").click(function(){
		    		  $(this).toggleClass("selected");
		    	  });
		      }
		      
		      function submitTaste() {
		    	  if(productsInfo == null || productsInfo == undefined || productsInfo.length < 1) {
		    		  alert("获取饮品信息失败，请重新选择饮品");
		    		  return false;
		    	  }
		    	  //alert(JSON.stringify(productsInfo));
		    	  var tempMap = new Map();
		    	  for(var i=0; i< productsInfo.length; i++) {
		    		  var pObj = productsInfo[i];
		    		  //获取选中的口味
		    		  var tasteIds = [];
		    		  var tasteNames = [];
		    		  $("#prod_"+pObj.id+"_"+pObj.index+" div[name='tasteItem']").each(function(){
		    			  if($(this).hasClass("selected")) {
		    				  tasteIds.push($(this).attr("tid"));
	                          tasteNames.push($(this).attr("tname"));
		    			  }
		    		  });
		    		  
		    		  pObj.taste = tasteIds;
		    		  pObj.tastenames = tasteNames.join(" ");
		    		  
		    		  var tempids = pObj.id;
		    		  if(tasteIds.length > 0) {
		    			  tempids = tempids + "_" + tasteIds.join("_");
		    		  }
		    		  
		    		  var tempQty = tempMap.get(tempids);
		    		  if(tempQty && tempQty != null && tempQty != undefined) {
		    			  tempMap.put(tempids, parseInt(tempQty)+1);
		    		  } else {
		    			  tempMap.put(tempids, 1);
		    		  }
		    	  }
		    	  
		    	  //合并同一口味的饮品
		    	  var tempProducts = [];
		    	  for(var k=0; k< productsInfo.length; k++) {
		    		  var pro = productsInfo[k];
		    		  var tIds = pro.id;
		    		  
		    		  if(pro.taste.length > 0) {
		    			  tIds = tIds + "_" + pro.taste.join("_");
		    		  }
		    		  
		    		  var proQty = tempMap.get(tIds);
		    		  if(proQty && proQty != null && proQty != undefined) {
		    			  pro.qty = parseInt(proQty);
		    			  pro.amount = parseFloat(pro.amount) * parseInt(proQty);
		    			  //将map中对应值设为null，标识已经使用
		    			  tempMap.put(tIds, null);
		    		  } else {
		    			  //已经取出过
		    			  continue;
		    		  }
		    		  
		    		  tempProducts.push(pro);
		    	  }
		    	  
		    	  //更新orderinfo
		    	  var orderinfo = sessionStorage.orderinfo;
		    	  orderinfo = $.parseJSON(orderinfo);
		    	  orderinfo.products = tempProducts;
		    	  sessionStorage.orderinfo = JSON.stringify(orderinfo);
		    	  
		    	  navigateTo("tastesetting", "postwayselector");
		      }
        </script>
    </head>
    <body>
      <div>
        <section id="maincontent" style="overflow-y: auto; float: left; width: 100%; height: 570px;">
            <div class="">
              <div style="text-align:center;margin-bottom:10px;">
                <div class="taste_notice">亲，你可以任性地定制以下饮品的口味哦～</div>
              </div>
            </div>
            <div class="csBody" style="background-color:#f7f7f7;">
              <ul id="plist"><li style="height:auto;margin-bottom:10px;background-color:#ffffff;" id="prod_73_0">  <div style="border-bottom:solid 1px #e9e9e9;">    <span>VC多橙汁</span><span>￥10</span>  </div>  <div>    <div class="taste_item" style="position:relative;" name="tasteItem" tname="少冰" tid="9">      <span>少冰</span>      <span style="" class="free_item"></span>    </div>  </div></li></ul>
            </div>
          </section>
          
          <div class="clear" style="clear:both;"></div>
          
          <div style="position:fixed;left:0px;right:0px;width:100%;bottom:2px;">
	          <div class="o_btn clearfix">
	            <input data-role="none" type="button" class="o_btn_red" value="确认饮品" style="width:100%;cursor:pointer;" id="okBtn">
	            <div style="clear:both"></div>
	          </div>
          </div>
       </div>
    
</body></html>