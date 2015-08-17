
function getUrl(){
	var url  = window.location.href ;
	if(url.indexOf("&code") > -1 ){
		var arr = url.split("&code");
		return arr[0];
	}else if(url.indexOf("?code") > -1){
		var arr = url.split("?code");
		return arr[0];
	}
	return url;
}



function getTime(time) {
	while (time.indexOf("-") > -1 || time.indexOf(".0") > -1) {
		time = time.replace("-", " ");
		time = time.replace(".0", "");
	}
	var now = new Date();
	var date = new Date(time);

	var t1 = now.getTime();
	var t2 = date.getTime();

	var l = t1 - t2;
	var d = parseInt(l / (24 * 60 * 60 * 1000));
	var h = parseInt(l / (60 * 60 * 1000) - d * 24);
	var m = parseInt((l / (60 * 1000)) - d * 24 * 60 - h * 60);
	var t = null;
	if (d != 0) {
		t = d + "天前";
	} else if (h != 0) {
		t = h + "小时前";
	} else {
		t = m + "分钟前";
	}
	return t;
}

function goTop(accelerate, time) {
	accelerate = accelerate || 0.1;
	time = time || 10;

	var x1 = 0, y1 = 0, x2 = 0, y2 = 0, x3 = 0, y3 = 0;

	if (document.documentElement) {
		x1 = document.documentElement.scrollLeft || 0;
		y1 = document.documentElement.scrollTop || 0;
	}
	if (document.body) {
		x2 = document.body.scrollLeft || 0;
		y2 = document.body.scrollTop || 0;
	}
	var x3 = window.scrollX || 0;
	var y3 = window.scrollY || 0;

	var x = Math.max(x1, Math.max(x2, x3));
	var y = Math.max(y1, Math.max(y2, y3));

	var speed = 1 + accelerate;
	window.scrollTo(Math.floor(x / speed), Math.floor(y / speed));

	if (x > 0 || y > 0) {
		var invokeFunction = "goTop(" + accelerate + ", " + time + ")";
		window.setTimeout(invokeFunction, time);
	}
}

if (!NeuF)
	var NeuF = {};
NeuF.ScrollPage = function(obj, callback) {
	var options = {
		delay : 500,
		bottom : 0,
	};
	this.isScrolling = false;
	this.oriPos = 0;
	this.curPos = 0;
	var me = this;
	var $obj = (typeof obj == "string") ? $("#" + obj) : $(obj);
	$obj.scroll(function(ev) {
		me.curPos = $obj.scrollTop();
		if ($(window).height() + $(window).scrollTop() >= $(document.body)
				.height()
				- options.bottom) {
			if (me.isScrolling == true)
				return;
			me.isScrolling = true;
			setTimeout(function() {
				me.isScrolling = false;
			}, options.delay);
			if (typeof callback == "function")
				callback.call(null, me.curPos - me.oriPos);
		}
		me.oriPos = me.curPos;
	});
};

function alert(text) {
	$('.bg .dialog p').text(text);
	$('.bg').show();
}
jQuery(function() {
	var $dialog = jQuery(".dialog")
	var dialog_w = $dialog.height();
	$dialog.css("margin-top", -dialog_w / 2);

	jQuery('.bg').click(function() {
		jQuery('.bg .dialog p').text("");
		jQuery('.bg').hide();
	})

	jQuery('.shoop_share').click(function() {
		jQuery('.shoop_share').hide();
	})
})


