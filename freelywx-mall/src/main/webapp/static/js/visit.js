
//loadScript("http://code.jquery.com/jquery-latest.js", function(){ // 加载最新Jquery
loadScript("http://pv.sohu.com/cityjson?ie=utf-8", function(){ // 获取当前用户IP
	sendByXmlHttp();
});
//});

function loadScript(url, callback){
	var script = document.createElement ("script");
	script.type = "text/javascript";
	if (script.readyState){ //IE
		script.onreadystatechange = function(){
			if (script.readyState == "loaded" || script.readyState == "complete"){
					script.onreadystatechange = null;
					callback();
			}
		};
	} else { //Others
		script.onload = function(){
			callback();
		};
	}
	script.src = url;
	document.getElementsByTagName("head")[0].appendChild(script);
}

//以XMLHttp的方式发生请求
function sendByXmlHttp() {
	var xmlHttp = null;
	
    if (window.XMLHttpRequest) {
    	xmlHttp = new XMLHttpRequest;
    }else if (window.ActiveXObject) {
    	xmlHttp = new ActiveXObject("Microsoft.XMLHttp");
    }

    if (xmlHttp!=null) {
    	var title = document.title;// 获取本页的标题
    	var link = window.location.href;// 获取本页的网址
    	var oldlink = document.referrer;// 获取上页的网址
    	var screen = window.screen.width + "*" + window.screen.height;// 屏幕分辨率    
    	var ip = returnCitySN["cip"];//IP地址
    	var city = returnCitySN["cname"];//省份城市
    	var url = window.location.protocol + "//" + window.location.host + "/wxmall/visit/visit";
    	var param = "?t="+title+"&l="+link+"&o="+oldlink+"&s="+screen+"&i="+ip+"&c="+city+"&os="+getOS()+"&bs="+getBS();
    	
        xmlHttp.open("GET", url + param, true);
        xmlHttp.onreadystatechange = function(){
        	if(xmlHttp.readyState == 4){
        		if (xmlHttp.status == 200) {
        			//var text = xmlHttp.responseText;
        		}
        	}
        };
        xmlHttp.send(null); 
    }
}

//以Jquery.AJAX的方式发生请求
function sendByJquery(){
	$.post(url,{
		"t" : title,
		"l" : link,
		"o" : oldlink,
		"s" : screen,
		"i" : ip,
		"c" : city,
		"os" : getOS(),
		"bs" : getBS()
	},function(text){
		
	});
}

/**
 * 获取客户端的操作系统
 * @returns {String}
 */
function getOS() {
    var ua = navigator.userAgent.toLowerCase();
    
    isWin7 = ua.indexOf("nt 6.1") > -1;
    isVista = ua.indexOf("nt 6.0") > -1;
    isWin2003 = ua.indexOf("nt 5.2") > -1;
    isWinXp = ua.indexOf("nt 5.1") > -1;
    isWin2000 = ua.indexOf("nt 5.0") > -1;
    isWindows = (ua.indexOf("windows") != -1 || ua.indexOf("win32") != -1);
    isMac = (ua.indexOf("macintosh") != -1 || ua.indexOf("mac os x") != -1);
    isAir = (ua.indexOf("adobeair") != -1);
    isLinux = (ua.indexOf("linux") != -1);
    
    if (isWin7) return "Windows 7";
    if (isVista) return "Vista";
    if (isWinXp) return "Windows xp";
    if (isWin2003) return "Windows 2003";
    if (isWin2000) return "Windows 2000";
    if (isWindows) return "Windows";
    if (isMac) return "Macintosh";
    if (isAir) return "Adobeair";
    if (isLinux) return "Linux";
    
    return "";
}

/**
 * 获取客户端的浏览器信息
 * @returns {String}
 */
function getBS() {
    var ua = navigator.userAgent.toLowerCase();

    if (ua.indexOf('opera') != -1) return "Opera " + ua.substring(ua.indexOf('version') + 8, ua.length);
    if (ua.indexOf('safari') != -1) return "Safari " + ua.substring(ua.indexOf('safari') + 7, ua.length);
    if (ua.indexOf('gecko') != -1) return "Firefox " + ua.substring(ua.indexOf('firefox') + 8, ua.length);
    if (ua.indexOf('msie') != -1) return "IE " + ua.substring(ua.indexOf('msie') + 5, ua.length - 1).split(';')[0];
    if (ua.indexOf('chrome') != -1) return "Chrome " + ua.substring(ua.indexOf('chrome') + 7, ua.length).split(' ')[0];

    return "";
}
