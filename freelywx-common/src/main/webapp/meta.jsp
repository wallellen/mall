<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="res" value="${ctx}/static" />
<script src="${res }/miniui/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="${res }/miniui/miniui_crack_3.2.js" type="text/javascript"></script>   
<link href="${res }/miniui/themes/default/miniui.css" rel="stylesheet" type="text/css" />
<link href="${res }/miniui/themes/blue/skin.css" rel="stylesheet" type="text/css" />
<link href="${res }/miniui/themes/icons.css" rel="stylesheet" type="text/css" /> 
<script src="${res }/map.js" type="text/javascript"></script>   

<script type="text/javascript">
function notify(message) {
    var x = document.getElementById("x").value;
    var y = document.getElementById("y").value;
    mini.showMessageBox({
        showModal: false,
        width: 250,
        title: "提示",
        //iconCls: "mini-messagebox-warning",
        message: message,
        timeout: 2000,
        x: x,
        y: y
    });
}

function checkMoney(e){
	if (e.isValid) {
		var patrn=/^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/;
		if(!patrn.exec(e.value)) {
			e.errorText = "金额格式错误或者不为正数。格式如：100.35";
            e.isValid = false;
		}
    }
}
/* function checkInterest(e){
	if (e.isValid) {
		var patrn=/^(([1-9]{1}[0-9]?)|([0]{1}))(\.(\d){1,2})?$/;
		if(!patrn.exec(e.value)) {
			e.errorText = "利息格式错误。利息为0-100间的正数，格式如：9.12";
            e.isValid = false;
		}else{
			if(e.name != "interest_from"){
				var from = mini.getbyName("interest_from").getValue();
				//alert(from);
			}
		}
    }
}
function checkMonth(e){
	if (e.isValid) {
		if(parseInt(e.value) <= 0) {
			e.errorText = "请输入大于0的整数!";
            e.isValid = false;
		}
    }
} */

function checkNull(obj){
	if (!obj && typeof(obj)!="undefined" && obj!=0)
	{
	    return true;
	}else if(obj == ""){
		return true;
	}else{
		return false;
	}
}

//金额格式转换.grid 格式转换
function gridPriceRender(e) {
	return parsePrice(e.value / 100);
}
function parsePrice(s) {
	var n = 2;
	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
	var l = s.split(".")[0].split("").reverse();
	var r = s.split(".")[1];
	var t = "";
	for (i = 0; i < l.length; i++) {
		t += l[i];
	}
	return '￥' + t.split("").reverse().join("") + "." + r;
}

//处理列表中的key-value字段,页面中的数据字典缓存信息
function getDict(e,fieldParam,dictId){
	if (e.column.field==fieldParam){
		var dictJson=dictMap.get(fieldParam+"_dictMap");
		if(!dictJson){
			$.ajax({
				//data : {dictId: dictId},
				url : "${ctx}/combox/dict/"+dictId,
	            async:false,		
				success : function(text) {
			        dictMap.put(fieldParam+"_dictMap",text);
			        dictJson=text;
				},
				error : function() {
				}
			});
		}
        for (var i = 0, l = dictJson.length; i < l; i++) {
            var g = dictJson[i];
            if (g.id == e.value) return g.text;
        }
        
        return "";
	}
}

function getDictValue(value,fieldParam,dictId){
	var dictJson=dictMap.get(fieldParam+"_dictMap");
	if(!dictJson){
		$.ajax({
			//data : {dictId: dictId},
			url : "${ctx}/combox/dict/"+dictId,
            async:false,		
			success : function(text) {
		        dictMap.put(fieldParam+"_dictMap",text);
		        dictJson=text;
			},
			error : function() {
			}
		});
	}
    for (var i = 0, l = dictJson.length; i < l; i++) {
        var g = dictJson[i];
        if (g.id == value) return g.text;
    }
    
    return "";	
}
</script>
<select id="x" style="display: none">
	<option value="right" selected>Right</option>
</select>
<select id="y"  style="display: none">
	<option value="bottom" selected>Bottom</option>
</select>