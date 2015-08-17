/**
 *  全局函数处理
 *  -----------------------------
 *********************************************************************************************/
var tong = {
/****************************************************************************************************/
/*  对象私有变量/函数返回值/通用处理函数
*****************************************************************************************************/	
/*************************
 *  = 对象变量，判断函数
 *************************/
	_events 		: {},									// 自定义事件---this._execEvent('scrollStart');
	_windowHeight	: $(window).height(),					// 设备屏幕高度
	_windowWidth 	: $(window).width(),

	_rotateNode		: $('.p-ct'),							// 旋转体

	_page 			: $('.m-page'),							// 模版页面切换的页面集合
	_pageNum		: $('.m-page').size(),					// 模版页面的个数
	_pageNow		: 0,									// 页面当前的index数
	_pageNext		: null,									// 页面下一个的index数

	_touchStartValY	: 0,									// 触摸开始获取的第一个值
	_touchDeltaY	: 0,									// 滑动的距离

	_moveStart		: true,									// 触摸移动是否开始
	_movePosition	: null,									// 触摸移动的方向（上、下）
	_movePosition_c	: null,									// 触摸移动的方向的控制
	_mouseDown		: false,								// 判断鼠标是否按下
	_moveFirst		: true,
	_moveInit		: false,

	_firstChange	: false,

	_map 			: $('.ylmap'),							// 地图DOM对象
	_mapValue		: null,									// 地图打开时，存储最近打开的一个地图
	_mapIndex		: null,									// 开启地图的坐标位置

	_audioNode		: $('.u-audio'),						// 声音模块
	_audio			: null,									// 声音对象
	_audio_val		: true,									// 声音是否开启控制
	
	_elementStyle	: document.createElement('div').style,	// css属性保存对象

	_UC 			: RegExp("Android").test(navigator.userAgent)&&RegExp("UC").test(navigator.userAgent)? true : false,
	_weixin			: RegExp("MicroMessenger").test(navigator.userAgent)? true : false,
	_iPhoen			: RegExp("iPhone").test(navigator.userAgent)||RegExp("iPod").test(navigator.userAgent)||RegExp("iPad").test(navigator.userAgent)? true : false,
	_Android		: RegExp("Android").test(navigator.userAgent)? true : false,
	_IsPC			: function(){ 
						var userAgentInfo = navigator.userAgent; 
						var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"); 
						var flag = true; 
						for (var v = 0; v < Agents.length; v++) { 
							if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; } 
						} 
						return flag; 
					} ,

/***********************
 *  = gobal通用函数
 ***********************/
 	// 判断函数是否是null空值
	_isOwnEmpty		: function (obj) { 
						for(var name in obj) { 
							if(obj.hasOwnProperty(name)) { 
								return false; 
							} 
						} 
						return true; 
					},
	// 微信初始化函数
	_WXinit			: function(callback){
						if(typeof window.WeixinJSBridge == 'undefined' || typeof window.WeixinJSBridge.invoke == 'undefined'){
							setTimeout(function(){
								this.WXinit(callback);
							},200);
						}else{
							callback();
						}
					},
	// 判断浏览器内核类型
	_vendor			: function () {
						var vendors = ['t', 'webkitT', 'MozT', 'msT', 'OT'],
							transform,
							i = 0,
							l = vendors.length;
				
						for ( ; i < l; i++ ) {
							transform = vendors[i] + 'ransform';
							if ( transform in this._elementStyle ) return vendors[i].substr(0, vendors[i].length-1);
						}
						return false;
					},
	// 判断浏览器来适配css属性值
	_prefixStyle	: function (style) {
						if ( this._vendor() === false ) return false;
						if ( this._vendor() === '' ) return style;
						return this._vendor() + style.charAt(0).toUpperCase() + style.substr(1);
					},
	// 判断是否支持css transform-3d（需要测试下面属性支持）
	_hasPerspective	: function(){
						var ret = this._prefixStyle('perspective') in this._elementStyle;
						if ( ret && 'webkitPerspective' in this._elementStyle ) {
							this._injectStyles('@media (transform-3d),(-webkit-transform-3d){#modernizr{left:9px;position:absolute;height:3px;}}', function( node, rule ) {
								ret = node.offsetLeft === 9 && node.offsetHeight === 3;
							});
						}
						return !!ret;
					},
		_translateZ : function(){
						if(tong._hasPerspective){
							return ' translateZ(0)';
						}else{
							return '';
						}
					},

	// 判断属性支持是否
	_injectStyles 	: function( rule, callback, nodes, testnames ) {
						var style, ret, node, docOverflow,
							div = document.createElement('div'),
							body = document.body,
							fakeBody = body || document.createElement('body'),
							mod = 'modernizr';

						if ( parseInt(nodes, 10) ) {
							while ( nodes-- ) {
								node = document.createElement('div');
								node.id = testnames ? testnames[nodes] : mod + (nodes + 1);
								div.appendChild(node);
								}
						}

						style = ['&#173;','<style id="s', mod, '">', rule, '</style>'].join('');
						div.id = mod;
						(body ? div : fakeBody).innerHTML += style;
						fakeBody.appendChild(div);
						if ( !body ) {
							fakeBody.style.background = '';
							fakeBody.style.overflow = 'hidden';
							docOverflow = docElement.style.overflow;
							docElement.style.overflow = 'hidden';
							docElement.appendChild(fakeBody);
						}

						ret = callback(div, rule);
						if ( !body ) {
							fakeBody.parentNode.removeChild(fakeBody);
							docElement.style.overflow = docOverflow;
						} else {
							div.parentNode.removeChild(div);
						}

						return !!ret;
					},
	// 自定义事件操作
 	_handleEvent 	: function (type) {
						if ( !this._events[type] ) {
							return;
						}

						var i = 0,
							l = this._events[type].length;

						if ( !l ) {
							return;
						}

						for ( ; i < l; i++ ) {
							this._events[type][i].apply(this, [].slice.call(arguments, 1));	
						}
					},
	// 给自定义事件绑定函数
	_on				: function (type, fn) {
						if ( !this._events[type] ) {
							this._events[type] = [];
						}

						this._events[type].push(fn);
					},
	//禁止滚动条
	_scrollStop		: function(){
						//禁止滚动
						$(window).on('touchmove.scroll',this._scrollControl);
						$(window).on('scroll.scroll',this._scrollControl);
					},
	//启动滚动条
	_scrollStart 	: function(){		
						//开启屏幕禁止
						$(window).off('touchmove.scroll');
						$(window).off('scroll.scroll');
					},
	//滚动条控制事件
	_scrollControl	: function(e){e.preventDefault();},

/**************************************************************************************************************/
/*  关联处理函数
***************************************************************************************************************/
/**
 *  单页面-m-page 切换的函数处理
 *  -->绑定事件
 *  -->事件处理函数
 *  -->事件回调函数
 *  -->事件关联函数【
 */
 	// 页面切换开始
 	page_start		: function(){
 		tong._page.on('touchstart mousedown',tong.page_touch_start);
 		tong._page.on('touchmove mousemove',tong.page_touch_move);
 		tong._page.on('touchend mouseup',tong.page_touch_end);
 	},

 	// 页面切换停止
 	page_stop		: function(){
		tong._page.off('touchstart mousedown');
 		tong._page.off('touchmove mousemove');
 		tong._page.off('touchend mouseup');
 	},

 	// page触摸移动start
 	page_touch_start: function(e){
 		if(!tong._moveStart) return;

 		if(e.type == "touchstart"){
        	tong._touchStartValY = window.event.touches[0].pageY;
        }else{
        	tong._touchStartValY = e.pageY||e.y;
        	tong._mouseDown = true;
        }

        tong._moveInit = true;

        // start事件
        tong._handleEvent('start');
 	},

 	// page触摸移动move
 	page_touch_move : function(e){
 		e.preventDefault();

		if(!tong._moveStart) return;
		if(!tong._moveInit) return;

		// 设置变量值
 		var $self = tong._page.eq(tong._pageNow),
 			h = parseInt($self.height()),
 			moveP,
 			scrollTop,
 			node=null,
 			move=false;

 		// 获取移动的值
 		if(e.type == "touchmove"){
        	moveP = window.event.touches[0].pageY;
        	move = true;
        }else{
        	if(tong._mouseDown){
        		moveP = e.pageY||e.y;
        		move = true;
        	}else return;
        }

		// 获取下次活动的page
        node = tong.page_position(e,moveP,$self);

		// page页面移动 		
 		tong.page_translate(node);

        // move事件
        tong._handleEvent('move');
		
		
		
		
		
 	},

 	// page触摸移动判断方向
 	page_position	: function(e,moveP,$self){ 		
 		var now,next;
	
 		// 设置移动的距离
 		if(moveP!='undefined') tong._touchDeltaY = moveP - tong._touchStartValY;

 		// 设置移动方向
    	tong._movePosition = moveP - tong._touchStartValY >0 ? 'down' : 'up';
    	if(tong._movePosition!=tong._movePosition_c){
    		tong._moveFirst = true;
    		tong._movePosition_c = tong._movePosition;
    	}else{
			tong._moveFirst = false;
    	}

		// 设置下一页面的显示和位置        
        if(tong._touchDeltaY<=0){
        	if($self.next('.m-page').length == 0){
        		tong._pageNext = 0;
        	} else {
        		tong._pageNext = tong._pageNow+1;	
        	}
 			
 			next = tong._page.eq(tong._pageNext)[0];
 		}else{
 			if($self.prev('.m-page').length == 0 ) {
 				if (tong._firstChange) {
 					tong._pageNext = tong._pageNum - 1;
 				} else {
 					return;
 				}
 			} else {
 				tong._pageNext = tong._pageNow-1;	
 			}
 			
 			next = tong._page.eq(tong._pageNext)[0];
 		}

 		now = tong._page.eq(tong._pageNow)[0];
 		node = [next,now];

 		// move阶段根据方向设置页面的初始化位置--执行一次
 		if(tong._moveFirst) init_next(node);

 		function init_next(node){
 			var s,l,_translateZ = tong._translateZ();

 			tong._page.removeClass('action');
 			$(node[1]).addClass('action').removeClass('f-hide');
 			tong._page.not('.action').addClass('f-hide');
 			
 			// 模版高度适配函数处理
	 		tong.height_auto(tong._page.eq(tong._pageNext),'false');

 			// 显示对应移动的page
			$(node[0]).removeClass('f-hide').addClass('active'); 

	 		// 设置下一页面的显示和位置        
	        if(tong._movePosition=='up'){
 				s = parseInt($(window).scrollTop());
 				if(s>0) l = $(window).height()+s;
 				else l = $(window).height();
 				node[0].style[tong._prefixStyle('transform')] = 'translate(0,'+l+'px)'+_translateZ;
 				$(node[0]).attr('data-translate',l);

 				$(node[1]).attr('data-translate',0);
	 		}else{
 				node[0].style[tong._prefixStyle('transform')] = 'translate(0,-'+Math.max($(window).height(),$(node[0]).height())+'px)'+_translateZ;
 				$(node[0]).attr('data-translate',-Math.max($(window).height(),$(node[0]).height()));

 				$(node[1]).attr('data-translate',0);
	 		}
 		}
 		
 		return node;
 	},

 	// page触摸移动设置函数
 	page_translate	: function(node){
 		// 没有传值返回
 		if(!node) return;
		
 		var _translateZ = tong._translateZ(),
 			y_1,y_2,scale,
 			y = tong._touchDeltaY;

 		// 切换的页面移动
 		if($(node[0]).attr('data-translate')) y_1 = y + parseInt($(node[0]).attr('data-translate'));
		node[0].style[tong._prefixStyle('transform')] = 'translate(0,'+y_1+'px)'+_translateZ;
		
		// 当前的页面移动
		if($(node[1]).attr('data-translate')) y_2 = y + parseInt($(node[1]).attr('data-translate'));
		scale = 1 - Math.abs(y*0.2/$(window).height());
		y_2 = y_2/5;
		node[1].style[tong._prefixStyle('transform')] = 'translate(0,'+y_2+'px)'+_translateZ+' scale('+scale+')';
 	},

 	// page触摸移动end
 	page_touch_end	: function(e){
 		tong._moveInit = false;
 		tong._mouseDown = false;
 		if(!tong._moveStart) return;
 		if(!tong._pageNext&&tong._pageNext!=0) return;

 		tong._moveStart = false;

 		// 确保移动了
 		if(Math.abs(tong._touchDeltaY)>10){
 			tong._page.eq(tong._pageNext)[0].style[tong._prefixStyle('transition')] = 'all .3s';
 			tong._page.eq(tong._pageNow)[0].style[tong._prefixStyle('transition')] = 'all .3s';
 		}
			
		// 页面切换
 		if(Math.abs(tong._touchDeltaY)>=100){		// 切换成功
 			tong.page_success();
 		}else if(Math.abs(tong._touchDeltaY)>10&&Math.abs(tong._touchDeltaY)<100){	// 切换失败		
 			tong.page_fial();
 		}else{									// 没有切换
 			tong.page_fial();
 		}

 		// end事件
        tong._handleEvent('end');

        // 注销控制值
 		tong._movePosition = null;
 		tong._movePosition_c = null;
 		tong._touchStartValY = 0;
		
         
		 if($('#j-mengban').hasClass('z-show')){
			 if(tong._pageNext == 14){
			  tong.page_stop();
			  
		   }
		 }
		 



 	},

 	// 切换成功
 	page_success	: function(){
 		var _translateZ = tong._translateZ();

 		// 下一个页面的移动
 		tong._page.eq(tong._pageNext)[0].style[tong._prefixStyle('transform')] = 'translate(0,0)'+_translateZ;

 		// 当前页面变小的移动
 		var y = tong._touchDeltaY > 0 ? $(window).height()/5 : -$(window).height()/5;
 		var scale = 0.8;
 		tong._page.eq(tong._pageNow)[0].style[tong._prefixStyle('transform')] = 'translate(0,'+y+'px)'+_translateZ+' scale('+scale+')';

 		// 成功事件
    	tong._handleEvent('success');
 	},

 	// 切换失败
 	page_fial	: function(){
 		var _translateZ = tong._translateZ();

 		// 判断是否移动了
		if(!tong._pageNext&&tong._pageNext!=0) {
			tong._moveStart = true;
			tong._moveFirst = true;
			return;
		}

 		if(tong._movePosition=='up'){
 			tong._page.eq(tong._pageNext)[0].style[tong._prefixStyle('transform')] = 'translate(0,'+$(window).height()+'px)'+_translateZ;
 		}else{
 			tong._page.eq(tong._pageNext)[0].style[tong._prefixStyle('transform')] = 'translate(0,-'+$(window).height()+'px)'+_translateZ;
 		}

 		tong._page.eq(tong._pageNow)[0].style[tong._prefixStyle('transform')] = 'translate(0,0)'+_translateZ+' scale(1)';

 		// fial事件
    	tong._handleEvent('fial');
 	},

/**
 *  对象函数事件绑定处理
 *  -->start touch开始事件
 *  -->mov   move移动事件
 *  -->end   end结束事件
 */
 	haddle_envent_fn : function(){
 		// 当前页面移动，延迟加载以后的图片
		tong._on('start',tong.lazy_bigP);

		// 当前页面移动
		tong._on('move',function(){
			
		});

		// 切换失败事件
		tong._on('fial',function(){
			setTimeout(function(){
				tong._page.eq(tong._pageNow).attr('data-translate','');
 				tong._page.eq(tong._pageNow)[0].style[tong._prefixStyle('transform')] = '';
 				tong._page.eq(tong._pageNow)[0].style[tong._prefixStyle('transition')] = '';
 				tong._page.eq(tong._pageNext)[0].style[tong._prefixStyle('transform')] = '';
	 			tong._page.eq(tong._pageNext)[0].style[tong._prefixStyle('transition')] = '';

	 			tong._page.eq(tong._pageNext).removeClass('active').addClass('f-hide');
				tong._moveStart = true;
				tong._moveFirst = true;
				tong._pageNext = null;
				tong._touchDeltaY = 0;
				tong._page.eq(tong._pageNow).attr('style','');
	 		},300)
		})

		// 切换成功事件
		tong._on('success',function(){
			// 判断最后一页让，开启循环切换
			if (tong._pageNext == 0 && tong._pageNow == tong._pageNum -1) {
				tong._firstChange = true;
			}

			// 判断是否是最后一页，让轻APP关联页面隐藏
 			if(tong._page.eq(tong._pageNext).next('.m-page').length != 0){
 				tong.app_intro_hide(true);
 			}
			setTimeout(function(){
				// 设置富文本的高度
				tong.Txt_init(tong._page.eq(tong._pageNow));

				// 判断是否为最后一页，显示或者隐藏箭头
				if(tong._pageNext == tong._pageNum-1 ) $('.u-arrow').addClass('f-hide');
				else  $('.u-arrow').removeClass('f-hide');

	 			tong._page.eq(tong._pageNow).addClass('f-hide');

				tong._page.eq(tong._pageNow).attr('data-translate','');
 				tong._page.eq(tong._pageNow)[0].style[tong._prefixStyle('transform')] = '';
 				tong._page.eq(tong._pageNow)[0].style[tong._prefixStyle('transition')] = '';
 				tong._page.eq(tong._pageNext)[0].style[tong._prefixStyle('transform')] = '';
	 			tong._page.eq(tong._pageNext)[0].style[tong._prefixStyle('transition')] = '';

	 			// 初始化切换的相关控制值
	 			$('.p-ct').removeClass('fixed');
	 			tong._page.eq(tong._pageNext).removeClass('active');
				tong._page.eq(tong._pageNext).removeClass('fixed');
				tong._pageNow = tong._pageNext;
				tong._moveStart = true;
				tong._moveFirst = true;
				tong._pageNext = null;
				tong._page.eq(tong._pageNow).attr('style','');
				tong._page.eq(tong._pageNow).removeClass('fixed');
				tong._page.eq(tong._pageNow).attr('data-translate','');
				tong._touchDeltaY = 0;

				// 切换成功后，执行当前页面的动画---延迟200ms
				setTimeout(function(){
					if(tong._page.eq(tong._pageNow).hasClass('z-animate')) return;
					tong._page.eq(tong._pageNow).addClass('z-animate');
				},20)

				// 隐藏图文组件的文本
				$('.j-detail').removeClass('z-show');
				$('.txt-arrow').removeClass('z-toggle');

				// 切换停止视频的播放
				$('video').each(function(){
					if(!this.paused) this.pause();
				})

				// 设置富文本的高度
				tong.Txt_init(tong._page.eq(tong._pageNow));

				// 判断是否滑动最后一页，并让轻APP介绍关联页面贤淑
	 			if(tong._page.eq(tong._pageNow).next('.m-page').length == 0){
	 				tong.app_intro_show();
	 				tong.app_intro();
	 			}
	 		},300)

			// 切换成功后，发送统计
			var laytouType = tong._page.eq(tong._pageNow).attr('data-statics');
			
			tong.ajaxTongji(laytouType);
		})
 	},

/**
 *  地图创建函数处理
 *  -->绑定事件
 *  -->事件处理函数
 *  -->创建地图
 *  -->函数传值
 *  -->关闭函数回调处理
 */
 	// 自定义绑定事件
	mapAddEventHandler	 : function(obj,eventType,fn,option){
	    var fnHandler = fn;
	    if(!tong._isOwnEmpty(option)){
	        fnHandler = function(e){
	            fn.call(this, option);  //继承监听函数,并传入参数以初始化;
	        }
	    }
	    obj.each(function(){
	  	  $(this).on(eventType,fnHandler);
	    })
	},

	//点击地图按钮显示地图
	mapShow : function(option){
		// 获取各自地图的资源信息
		var str_data = $(this).attr('data-detal');
		option.detal = str_data != '' ? eval('('+str_data+')') : '';
		option.latitude = $(this).attr('data-latitude');
		option.longitude = $(this).attr('data-longitude');

		// 地图添加
		var detal		= option.detal,
			latitude	= option.latitude,
			longitude	= option.longitude,
		 	fnOpen		= option.fnOpen,
			fnClose		= option.fnClose;

		tong._scrollStop();
		tong._map.addClass('show');
		$(document.body).animate({scrollTop: 0}, 0);
		
		//判断开启地图的位置是否是当前的
		if($(this).attr('data-mapIndex')!=tong._mapIndex){
			tong._map.html($('<div class="bk"><span class="css_sprite01 s-bg-map-logo"></span></div>'));
			tong._mapValue = false;
			tong._mapIndex = $(this).attr('data-mapIndex');

		}else{
			tong._mapValue = true;	
		} 

		setTimeout(function(){
			//将地图显示出来
			if(tong._map.find('div').length>=1){
				tong._map.addClass("mapOpen");
				tong.page_stop();
				tong._scrollStop();
				tong._audioNode.addClass('z-low');
				// 设置层级关系-z-index
				tong._page.eq(tong._pageNow).css('z-index',15);

				setTimeout(function(){
					//如果开启地图的位置不一样则，创建新的地图
					if(!tong._mapValue) tong.addMap(detal,latitude,longitude,fnOpen,fnClose);
				},500)
			}else return;
		},100)
	},	
	
	//地图关闭，将里面的内容清空（优化DON结构）
	mapSave	: function(){
		$(window).on('webkitTransitionEnd transitionend',mapClose);
		tong.page_start();
		tong._scrollStart();
		tong._map.removeClass("mapOpen");
		tong._audioNode.removeClass('z-low');

		if(!tong._mapValue) tong._mapValue = true;

		function mapClose(){
			tong._map.removeClass('show');
			// 设置层级关系-z-index
			tong._page.eq(tong._pageNow).css('z-index',9);
			$(window).off('webkitTransitionEnd transitionend');
		}
	},

	//地图函数传值，创建地图
	addMap	: function (detal,latitude,longitude,fnOpen,fnClose){
		var detal		= detal,
			latitude	= Number(latitude),
			longitude	= Number(longitude);

		var fnOpen		= typeof(fnOpen)==='function'? fnOpen : '',
			fnClose		= typeof(fnClose)==='function'? fnClose : '';

		//默认值设定
		var a = {sign_name:'',contact_tel:'',address:'天安门'};

		//检测传值是否为空，设置传值
		tong._isOwnEmpty(detal)	? detal=a:detal=detal;
		!latitude? latitude=39.915:latitude=latitude;
		!longitude? longitude=116.404:longitude=longitude;
		
		//创建地图
		tong._map.ylmap({
			/*参数传递，默认为天安门坐标*/
			//需要执行的函数（回调）
			detal		: detal,		//地址值
			latitude	: latitude,		//纬度
			longitude	: longitude,	//经度
			fnOpen		: fnOpen,		//回调函数，地图开启前
			fnClose		: fnClose		//回调函数，地图关闭后
		});	
	},

	//绑定地图出现函数
	mapCreate	: function(){
		if('.j-map'.length<=0) return;

		var node = $('.j-map');

		//option地图函数的参数
		var option ={
			fnOpen	: tong._scrollStop,
			fnClose	: tong.mapSave
		};
		tong.mapAddEventHandler(node,'click',tong.mapShow,option);
	},

/**
 *  media资源管理
 *  -->绑定声音控制事件
 *  -->函数处理声音的开启和关闭
 *  -->异步加载声音插件（延迟做）
 *  -->声音初始化
 *  -->视频初始化
 *  -->声音和视频切换的控制
 */
 	// 声音初始化
 	audio_init : function(){
 		// media资源的加载
		var options_audio = {
			loop: true,
            preload: "auto",
            src: tong._audioNode.attr('data-src')
		}
		
        tong._audio = new Audio(); 

        for(var key in options_audio){
            if(options_audio.hasOwnProperty(key) && (key in tong._audio)){
                tong._audio[key] = options_audio[key];
            }
        }
        tong._audio.load();
 	},

 	// 声音事件绑定
 	audio_addEvent : function(){
 		if(tong._audioNode.length<=0) return;

 		// 声音按钮点击事件
 		var txt = tong._audioNode.find('.txt_audio'),
 			time_txt = null;
 		tong._audioNode.find('.btn_audio').on('click',tong.audio_contorl);

 		// 声音打开事件
 		$(tong._audio).on('play',function(){
 			tong._audio_val = false;

 			audio_txt(txt,true,time_txt);
 			$("#imageaudio").addClass("imageaudio");
 			// 开启音符冒泡
 			$.fn.coffee.start();
 			$('.coffee-steam-box').show(500);
 		})

 		// 声音关闭事件
 		$(tong._audio).on('pause',function(){
 			audio_txt(txt,false,time_txt)
 			$("#imageaudio").removeClass("imageaudio");
 			// 关闭音符冒泡
 			$.fn.coffee.stop();
 			$('.coffee-steam-box').hide(500);
 		})

 		function audio_txt(txt,val,time_txt){
 			if(val) txt.text('打开');
 			else txt.text('关闭');

 			if(time_txt) clearTimeout(time_txt);

 			txt.removeClass('z-move z-hide');
 			time_txt = setTimeout(function(){
 				txt.addClass('z-move').addClass('z-hide');
 			},1000)
 		}
 	},

 	// 声音控制函数
 	audio_contorl : function(){
 		if(!tong._audio_val){
 			tong.audio_stop();
 		}else{
 			tong.audio_play();
 		}
 	},	

 	// 声音播放
 	audio_play : function(){
 		tong._audio_val = false;
 		if(tong._audio) tong._audio.play();
 	},

 	// 声音停止
 	audio_stop	: function(){
 		tong._audio_val = true;
 		if(tong._audio) tong._audio.pause(); 
 	},

 	// 视频初始化
 	video_init : function(){
 		// 视频
        $('.j-video').each(function(){
        	var option_video = {
        		controls: 'controls',
        		preload : 'none',
        		// poster : $(this).attr('data-poster'),
        		width : $(this).attr('data-width'),
        		height : $(this).attr('data-height'),
        		src : $(this).attr('data-src')
        	}

        	var video = $('<video class="f-hide"></video>')[0];

        	for(var key in option_video){
                if(option_video.hasOwnProperty(key) && (key in video)){
                    video[key] = option_video[key];
                }
                this.appendChild(video);
            }

            var img = $(video).prev();

            $(video).on('play',function(){
            	img.hide();
            	$(video).removeClass('f-hide');
            });

            $(video).on('pause',function(){
            	img.show();
            	$(video).addClass('f-hide');
            });
        })

        $('.j-video .img').on('click',function(){
        	var video = $(this).next()[0];

        	if(video.paused){
        		$(video).removeClass('f-hide');
        		video.play();
        		$(this).hide();
        	}
        })
 	},

 	//处理声音和动画的切换
	media_control : function(){
		if(!tong._audio) return;
		if($('video').length<=0) return;

		$(tong._audio).on('play', function(){
			$('video').each(function(){
				if(!this.paused){
					this.pause();
				}
			});	
		});

		$('video').on('play', function(){
			if(!tong._audio_val){
				tong.audio_contorl();			
			}
		});
	},

	// media管理初始化
	media_init : function(){
		// 声音初始化
		tong.audio_init();

        // 视频初始化
        tong.video_init();

		// 绑定音乐加载事件
		tong.audio_addEvent();

		// 音频切换
		tong.media_control();
	},

/**
 *  图片延迟加载功能
 *  -->替代需要延迟加载的图片
 *  -->优化加载替代图片
 *  -->切换功能触发图片的延迟加载
 *  -->替代图片为400*400的透明大图片
 */
	/* 图片延迟加载 */
	lazy_img : function(){
		var lazyNode = $('.lazy-img');
		lazyNode.each(function(){
			var self = $(this);
			if(self.is('img')){
				self.attr('src','img/loading_large.gif');
			}else{
				// 把原来的图片预先保存下来
				var position = self.css('background-position'),
					size = self.css('background-size');

				self.attr({
					'data-position' : position,
					'data-size'	: size
				});

				if(self.attr('data-bg')=='no'){
					self.css({
						'background-repeat'	: 'no-repeat'
					})
				}

				self.css({
					'background-image'	: 'url(img/loading_large.gif)',
					'background-size'	: '120px 120px',
					'background-position': 'center'
				})

				if(self.attr('data-image')=='no'){
					self.css({
						'background-image'	: 'none'
					})
				}
			}
		})
	},

	// 开始加载前三个页面
	lazy_start : function(){
		// 前三个页面的图片延迟加载
		setTimeout(function(){
			for(var i=0;i<3;i++){
				var node = $(".m-page").eq(i);
				if(node.length==0) break;
				if(node.find('.lazy-img').length!=0){
					tong.lazy_change(node,false);
					// 飞出窗口的延迟
					if(node.attr('data-page-type')=='flyCon'){
						tong.lazy_change($('.m-flypop'),false);
					}
				}else continue;
			}
		},200)
	},
	
	// 加载当前后面第三个
	lazy_bigP : function(){
		for(var i=3;i<=5;i++){
			var node = $(".m-page").eq(tong._pageNow+i);
			if(node.length==0) break;
			if(node.find('.lazy-img').length!=0){
				tong.lazy_change(node,true);
				// 飞出窗口的延迟
				if(node.attr('data-page-type')=='flyCon'){
					tong.lazy_change($('.m-flypop'),false);
				}
			}else continue;
		}
	},

	// 图片延迟替换函数
	lazy_change : function(node,goon){
		// 3d图片的延迟加载
		if(node.attr('data-page-type')=='3d') tong.lazy_3d(node);

		// 飞出窗口的延迟
		if(node.attr('data-page-type')=='flyCon'){
			var img = $('.m-flypop').find('.lazy-img');
			img.each(function(){
				var self = $(this),
					srcImg = self.attr('data-src');

				$('<img />')
					.on('load',function(){
						if(self.is('img')){
							self.attr('src',srcImg)
						}
					})
					.attr("src",srcImg);
			})
		}

		// 其他图片的延迟加载
		var lazy = node.find('.lazy-img');
		lazy.each(function(){
			var self = $(this),
				srcImg = self.attr('data-src'),
				position = self.attr('data-position'),
				size = self.attr('data-size');

			if(self.attr('data-bg')!='no'){
				$('<img />')
					.on('load',function(){
						if(self.is('img')){
							self.attr('src',srcImg)
						}else{
							self.css({
								'background-image'	: 'url('+srcImg+')',
								'background-position'	: position,
								'background-size' : size
							})
						}

						// 判断下面页面进行加载
						if(goon){
							for(var i =0;i<$(".m-page").size();i++){
								var page = $(".m-page").eq(i);
								if($(".m-page").find('.lazy-img').length==0) continue
								else{
									tong.lazy_change(page,true);
								}
							}
						}
					})
					.attr("src",srcImg);

				self.removeClass('lazy-img').addClass('lazy-finish');
			}else{
				if(self.attr('data-auto')=='yes') self.css('background','none');
			}
		})	
	},
/**
 * 表单验证函数控制
 * -->提交按钮的点击事件
 * -->每一个表单的输入值进行验证
 * -->正则验证的函数
 * -->异步提交的函数
 * -->提交显示信息的函数
 */
 	// 提交按钮点击，进行验证函数
 	signUp_submit 	: function(){
 		$('#j-signUp-submit').on('click',function(e){
 		console.log('click')
	 		e.preventDefault();
			var form = $(this).parents('#j-signUp');
	 		var valid = tong.signUpCheck_input(form);
	 		if(valid) {
	 			tong.signUpCheck_submit(form);
	 		}
	 		else return;
	 	})
 	},

 
 	// 我要报名表单验证函数
 	signUpCheck_input	: function (form, type){
		var valid = true;
		var inputs = form.find('input');

		inputs.each(function(){
			if(this.name != '' && this.name != 'undefined'){
				//函数验证
				var name = this.name;
				var backData	= tong.regFunction(name);
					
				var empty_tip = backData.empty_tip,
					reg       = backData.reg,
					reg_tip   = backData.reg_tip;
						
				//根据结果处理
				if ($.trim($(this).val()) == '') {
					tong.showCheckMessage(empty_tip, true);
					$(this).focus();
					$(this).addClass('z-error');
					valid = false;
					return false;
				}
				if (reg != undefined && reg != '') {
					if(!$(this).val().match(reg)){
						$(this).focus();
						$(this).addClass('z-error');
						tong.showCheckMessage(reg_tip, true);
						valid = false;
						return false;		
					}
				}
				$(this).removeClass('z-error');
				$('.u-note-error').html('');	
			}
		});
		if (valid == false) {
			return false;
		}else{
			return true;
		}
	},
	
	// 正则函数验证
	regFunction	: function(inputName){
		var empty_tip = '',
			reg_tip = '',
			reg = '';

		//判断
		switch (inputName) {
			case 'name':
				reg = /^[\u4e00-\u9fa5|a-z|A-Z|\s]{1,20}$/;
				empty_tip = '不能落下姓名哦！';
				reg_tip = '这名字太怪了！';
				break;
			case 'sex':
				empty_tip = '想想，该怎么称呼您呢？';
				reg_tip = '想想，该怎么称呼您呢？';
				break;
			case 'tel':
				reg = /^1[0-9][0-9]\d{8}$/;
				empty_tip = '有个联系方式，就更好了！';
				reg_tip = '这号码,可打不通... ';
				break;
			case 'email':
				reg = /(^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$)/i;
				empty_tip = '都21世纪了，应该有个电子邮箱吧！';
				reg_tip = '邮箱格式有问题哦！';
				break;
			case 'company':
				reg = /^[\u4e00-\u9fa5|a-z|A-Z|\s|\d]{1,20}$/;
				empty_tip = '填个公司吧！';
				reg_tip = '这个公司太奇怪了！';
				break;
			case 'job':
				reg = /^[\u4e00-\u9fa5|a-z|A-Z|\s]{1,20}$/;
				empty_tip = '请您填个职位';
				reg_tip = '这个职位太奇怪了！';
				break;
			case 'date':
				empty_tip = '给个日期吧！';
				reg_tip = '';
				break;
			case 'time':
				empty_tip = '填下具体时间更好哦！' ;
				reg_tip = '' ;
				break;
			case 'age':
				reg = /^([3-9])|([1-9][0-9])|([1][0-3][0-9])$/;
				empty_tip = '有个年龄就更好了！';
				reg_tip = '这年龄可不对哦！' ;
				break;
		}
		return {
			empty_tip	:empty_tip,
			reg_tip		:reg_tip,
			reg 		:reg
		}
	},

	// ajax异步提交表单数据
	signUpCheck_submit	: function (form){
		 tong.loadingPageShow();

		 var url = '/auto/submit/'+$('#activity_id').val();
		// // ajax提交数据
		 $.ajax({
		 	url: url,
		 	cache: false,
		 	dataType: 'json',
		 	async: true,
		 	type:'POST',
		 	data: form.serialize(),
		 	success: function(msg){
			
		 		tong.loadingPageHide();
			
		 		 if(msg.code==200){
						// 提示成功
		 		tong.showCheckMessage('提交成功！',true)

	 			// 关闭窗口
		 		setTimeout(function(){
		 			$('.book-form').removeClass('z-show');
		 			$('.book-bg').removeClass('z-show');
		 			setTimeout(function(){
		 				$(document.body).css('height','100%');
		 				tong.page_start();
		 				tong._scrollStop();
						
						$('.book-bg').addClass('f-hide');
		 				$('.book-form').addClass('f-hide');
		 			},500)
		 		},1000)

		 		// 按钮变色
		 		$('.book-bd .bd-form .btn').addClass("z-stop");
		 		$('.book-bd .bd-form .btn').attr("data-submit",'true');
				
				}else if(msg.code=='400'){
					tong.showCheckMessage('提交失败',false);
		 		 }
				
				
		 	},
		 	error : function (XMLHttpRequest, textStatus, errorThrown) {
		 		tong.showCheckMessage(errorThrown,true);
		 		setTimeout(function(){
		 			tong.loadingPageHide();
		 		},500)
		 	}
		 })
	},

	// 显示验证信息
	showCheckMessage	: function (msg, error) {
		if (error) {
			$('.u-note-error').html(msg);
			$(".u-note-error").addClass("on");
			$(".u-note-sucess").removeClass("on");

			setTimeout(function(){
				$(".u-note").removeClass("on");
			},2000);
		} else {
			$(".u-note-sucess").addClass("on");
			$(".u-note-error").removeClass("on");

			setTimeout(function(){
				$(".u-note").removeClass("on");
			},2000);
		}
	},

/**************************************************************************************************************/
/*  单个处理函数
***************************************************************************************************************/
/**
 * 单个函数处理-unit
 * -->高度的计算
 * -->文本的展开
 * -->文本的收起
 * -->输入表单的操作
 * -->微信的分享提示
 */
	// 根据设备的高度，来适配每一个模版的高度，并且静止滑动
	// --文档初始化计算
	// --页面切换完成计算
	height_auto	: function(ele,val){
		ele.children('.page-con').css('height','auto');
		var height = $(window).height();

		// 需要解除固定高度的page卡片
		var vial = true;
		if(!vial){
			if(ele.height()<=height){
				ele.children('.page-con').height(height+2);
				if((!$('.p-ct').hasClass('fixed'))&&val=='true') $('.p-ct').addClass('fixed');
			}else{
				tong._scrollStart();
				if(val=='true') $('.p-ct').removeClass('fixed');
				ele.children('.page-con').css('height','100%');
				return;
			}
		}else{
			ele.children('.page-con').height(height+2);
			if((!$('.p-ct').hasClass('fixed'))&&val=='true') $('.p-ct').addClass('fixed');
		}
	},

	// 富文本的设置
	Txt_init : function(node){
		if(node.find('.j-txt').length<=0) return;
		if(node.find('.j-txt').find('.j-detail p').length<=0) return;

		node.find('.j-txt').each(function(){
			var txt = $(this).find('.j-detail'),
				title = $(this).find('.j-title'),
				arrow = title.find('.txt-arrow'),
				p = txt.find('p'),
				height_t = parseInt(title.height()),
				height_p = parseInt(p.height()),
				height_a = height_p+height_t;

			if ($(this).parents('.m-page').hasClass('m-smallTxt')) {
				if ($(this).parents('.smallTxt-bd').index() == 0) {
					txt.css('top',height_t);
				} else {
					txt.css('bottom',height_t);
				}
			}

			txt.attr('data-height',height_p);
			$(this).attr('data-height-init',height_t);
			$(this).attr('data-height-extand',height_a);

			p[0].style[tong._prefixStyle('transform')] = 'translate(0,-'+height_p+'px)';
			if($(this.parentNode).hasClass('z-left')) p[0].style[tong._prefixStyle('transform')] = 'translate(0,'+height_p+'px)';

			txt.css('height','0');
			arrow.removeClass('z-toggle');
			$(this).css('height',height_t);
		})
	},

	// 富文本组件点击展开详细内容
	bigTxt_extand : function(){
		$('body').on('click','.j-title',function(){
			if($('.j-detail').length<=0) return;

			// 定位
			var detail = $(this.parentNode).find('.j-detail');
			$('.j-detail').removeClass('action');
			detail.addClass('action');
			if($(this).hasClass('smallTxt-arrow')){
				$('.smallTxt-bd').removeClass('action');
				detail.parent().addClass('action');
			}

			// 设置
			if(detail.hasClass('z-show')){
				detail.removeClass('z-show');
				detail.css('height',0);
				$(this.parentNode).css('height',parseInt($(this.parentNode).attr('data-height-init')));
			}
			else{
				detail.addClass('z-show');
				detail.css('height',parseInt(detail.attr('data-height')));
				$(this.parentNode).css('height',parseInt($(this.parentNode).attr('data-height-extand')));
			}

			$('.j-detail').not('.action').removeClass('z-show');
			$('.txt-arrow').removeClass('z-toggle');

			detail.hasClass('z-show') ? ($(this).find('.txt-arrow').addClass('z-toggle')) : ($(this).find('.txt-arrow').removeClass('z-toggle'))
		})
	}(),

	// 文本点击其他地方收起
	Txt_back : function(){
		$('body').on('click','.m-page',function(e){
			e.stopPropagation();

			// 判断
			var node = $(e.target);
			var page = node.parents('.m-page');
			var txtWrap = node.parents('.j-txtWrap').length==0 ? node : node.parents('.j-txtWrap');
			if(page.find('.j-txt').find('.j-detail p').length<=0) return;
			if(page.find('.j-txt').length<=0||node.parents('.j-txt').length>=1 || node.hasClass('bigTxt-btn') || node.parents('.bigTxt-btn').length>=1) return;

			// 定位
			var detail = txtWrap.find('.j-detail');
			$('.j-detail').removeClass('action');
			detail.addClass('action');
			$('.j-detail').not('.action').removeClass('z-show');

			// 设置
			txtWrap.each(function(){
				var detail = $(this).find('.j-detail');
				var arrow = $(this).find('.txt-arrow');
				var txt = $(this).find('.j-txt');

				if(detail.hasClass('z-show')){
					detail.removeClass('z-show');
					detail.css('height',0);
					txt.css('height',parseInt(txt.attr('data-height-init')));
				}else{
					detail.addClass('z-show');
					detail.css('height',parseInt(detail.attr('data-height')));
					txt.css('height',parseInt(txt.attr('data-height-extand')));
				}

				detail.hasClass('z-show') ? (arrow.addClass('z-toggle')) : (arrow.removeClass('z-toggle'));
			})
		})
	}(),

	// 表单显示，输入
	input_form : function(){
		$('body').on('click','.book-bd .bd-form .btn',function(){
			var type_show = $(this).attr("data-submit");
			if (type_show == 'true') {
				return;
			}

			var heigt = $(window).height();

			$(document.body).css('height',heigt);
			tong.page_stop();
			tong._scrollStart();
			// 设置层级关系-z-index
			tong._page.eq(tong._pageNow).css('z-index',15);

			$('.book-bg').removeClass('f-hide');
			$('.book-form').removeClass('f-hide');
			setTimeout(function(){
				$('.book-form').addClass('z-show');
				$('.book-bg').addClass('z-show');
			},50)

			$('.book-bg').off('click');
			$('.book-bg').on('click',function(e){
				e.stopPropagation();

				var node = $(e.target);

				if(node.parents('.book-form').length>=1 && !node.hasClass('j-close-img') && node.parents('.j-close').length<=0) return;

				$('.book-form').removeClass('z-show');
				$('.book-bg').removeClass('z-show');
				setTimeout(function(){
					$(document.body).css('height','100%');
					tong.page_start();
					tong._scrollStop();
					// 设置层级关系-z-index
					tong._page.eq(tong._pageNow).css('z-index',9);
					
					$('.book-bg').addClass('f-hide');
					$('.book-form').addClass('f-hide');
				},500)
			})
		})
	}(),

	sex_select : function(){
		var btn = $('#j-signUp').find('.sex p');
		var strongs = $('#j-signUp').find('.sex strong');
		var input = $('#j-signUp').find('.sex input');

		btn.on('click',function(){
			var strong = $(this).find('strong');
			strongs.removeClass('open');
			strong.addClass('open');

			var value = $(this).attr('data-sex');
			input.val(value);
		})
	}(),

	// 显示轻APP按钮
	app_intro_show : function(){
		$('.market-notice').removeClass('f-hide');
		setTimeout(function(){
			$('.market-notice').addClass('show');
		},100)
	},

	// 隐藏轻APP按钮
	app_intro_hide : function(val){
		if(val){
			$('.market-notice').addClass('f-hide').removeClass('show');
			return;
		} 

		$('.market-notice').removeClass('show');
		setTimeout(function(){
			$('.market-notice').addClass('f-hide')
		},500)
	},

	// 轻APP介绍弹窗关联
	app_intro : function(){
		// 点击按钮显示内容
		$('.market-notice').off('click');
		$('.market-notice').on('click',function(){
			$('.market-page').removeClass('f-hide');
			setTimeout(function(){
				$('.market-page').addClass('show');
				setTimeout(function(){
					$('.market-img').addClass('show');
				},100)
				tong.app_intro_hide();
			},100)

			// 禁止滑动
			tong.page_stop();
			tong._scrollStop();
		});

		// 点击窗口让内容隐藏
		$('.market-page').off('click');
		$('.market-page').on('click',function(e){
			if($(e.target).hasClass('market-page')){
				$('.market-img').removeClass('show');
				setTimeout(function(){
					$('.market-page').removeClass('show');
					setTimeout(function(){
						$('.market-page').addClass('f-hide');
					},200)
				},500)
				tong.app_intro_show();

				// 禁止滑动
				tong.page_start();
				tong._scrollStart();
			}
		});
	},

	//统计函数处理
 	ajaxTongji	: function(laytouType){
		var channel_id = location.search.substr(location.search.indexOf("channel=") + 8);
		channel_id= channel_id.match(/^\d+/) ; 
		if (!channel_id || isNaN(channel_id) || channel_id<0) {
		channel_id = 1;
	}
 	 	var activity_id = $('#activity_id').val();
 	 	var url = "/analyseplugin/plugin?activity_id="+activity_id + "&plugtype="+laytouType;
		 //报名统计请求
	 	//$.get(url,{},function(){});
 	},

 	// 微信的分享提示
 	wxShare : function(){
 		$('body').on('click','.bigTxt-btn-wx',function(){
 			var img_wx = $(this).parent().find('.bigTxt-weixin');
 			
 			img_wx.addClass('z-show');
 			tong.page_stop();

 			img_wx.on('click',function(){
 				$(this).removeClass('z-show');
 				tong.page_start();

 				$(this).off('click');
 			})
 		})
 	}(),

 	// loading显示
	loadingPageShow : function(){
		$('.u-pageLoading').show();
	},
	
	// loading隐藏
	loadingPageHide : function (){
		$('.u-pageLoading').hide();	
	},

	// 对象私有变量刷新
	refresh	: function(){
		$(window).height() = $(window).height();
		tong._windowWidth = $(window).width();
	},

/**************************************************************************************************************/
/*  函数初始化
***************************************************************************************************************/
/**
 *  相关插件的启动
 */
	//插件启动函数
 	plugin : function(){
		// 地图
		tong.mapCreate();

		// 音符飘逸
		$('#coffee_flow').coffee({
			steams				: ["<img src='http://120.24.73.10/wxmall/static/images/audio_widget.png' />","<img src='http://120.24.73.10/wxmall/static/images/audio_widget.png' />"], 
			steamHeight			: 100,
			steamWidth			: 44 
		});

 	    // 蒙板插件
		if ($('#j-mengban').attr("data-open") == "1") {
		    var node = $('#j-mengban')[0],
		        url = 'img/page_01_bg@2x.jpg',
		        canvas_url = $('#r-cover').val(),
		        type = 'image',
		        w = 640,
		        h = $(window).height(),
		        callback = tong.start_callback;

		    tong.cover_draw(node, url, canvas_url, type, w, h, callback);
		} else {
		    tong.start_callback();
		}
        


		// 微信分享
		var option_wx = {};

		if($('#r-wx-title').val()!='') option_wx.title = $('#r-wx-title').val();
		if($('#r-wx-img').val()!='') option_wx.img = $('#r-wx-img').val();
		if($('#r-wx-con').val()!='') option_wx.con = $('#r-wx-con').val();

		if(tong._weixin) $(document.body).wx(option_wx);
 	},

 	// 蒙板插件初始化函数处理
 	cover_draw : function(node,url,canvas_url,type,w,h,callback){
		if(node.style.display.indexOf('none')>-1) return;
		
		var lottery = new Lottery(node, canvas_url, type, w, h, callback);
		lottery.init();
	},

    menban_callback: function(){
		$('#j-mengban').removeClass('z-show');
 		setTimeout(function(){
 			$('#j-mengban').addClass('f-hide');
 		},1500);
		//alert(22);
		tong.page_start();
		//alert(11);
		},

	// 蒙板插件回调函数处理
 	start_callback : function(){
 		// 隐藏蒙板
 		$('#j-mengban').removeClass('z-show');
		setTimeout(function(){
			$('#j-mengban').addClass('f-hide');
		},1500)

 		// 开启window的滚动
 		tong._scrollStart();

 		// 开启页面切换
		tong.page_start();

		// 箭头显示
		$('.u-arrow').removeClass('f-hide');
       
		// 播放声音
		if(!tong._audio) return;
		tong._audioNode.removeClass('f-hide');
		tong._audio.play();
        
		// 声音启动
		$(document).one("touchstart", function(){
            tong._audio.play();
        });
		
		
		// 蒙板插件
		var node = $('#j-mengban')[0],
			url = 'img/page_01_bg@2x.jpg',
			canvas_url = $('#r-cover').val(),
			type = 'image',
			w = 640,
			h = $(window).height(),
			callback = tong.menban_callback;

		tong.cover_draw(node,url,canvas_url,type,w,h,callback);
		
 	},

/**
 * app初始化
 */
	// 样式适配
	styleInit : function(){
		// 禁止文版被拖动
		document.body.style.userSelect = 'none';
		document.body.style.mozUserSelect = 'none';
		document.body.style.webkitUserSelect = 'none';

		// 判断设备的类型并加上class
		if(tong._IsPC()) $(document.body).addClass('pc');
		else $(document.body).addClass('mobile');
		if(tong._Android) $(document.body).addClass('android');
		if(tong._iPhoen) $(document.body).addClass('iphone');

		// 判断是否有3d
		if(!tong._hasPerspective()){
			tong._rotateNode.addClass('transformNode-2d');
			$(document.body).addClass('no-3d');
		}
		else{
			tong._rotateNode.addClass('transformNode-3d');
			$(document.body).addClass('perspective');
			$(document.body).addClass('yes-3d');
		}

		// 图片延迟加载的处理
		this.lazy_img();

		// 设置富文本的高度
		tong.Txt_init(tong._page.eq(tong._pageNow));
		
		// 模版提示文字显示
		setTimeout(function(){
			$('.m-alert').find('strong').addClass('z-show');
		},1000)

		$('.u-arrow').on('touchmove',function(e){e.preventDefault()})

		$('.p-ct').height($(window).height());
		$('.m-page').height($(window).height());
		$('#j-mengban').height($(window).height());
		$('.translate-back').height($(window).height());
	},

	// 对象初始化
	init : function(){
		// 样式，标签的渲染
		// 对象操作事件处理
		this.styleInit();
		this.haddle_envent_fn();

		
		
		// 禁止滑动
		// this._scrollStop();

		// 绑定全局事件函数处理
		// $(window).on('resize',function(){
		// 	tong.refresh();
		// })
		
		$('input[type="hidden"]').appendTo($('body'));
		
		// 图片预先加载
		$('<img />').attr('src',$('#r-cover').val());
		$('<img />').attr('src',$('.m-fengye').find('.page-con').attr('data-src'));

		// loading执行一次
		var loading_time = new Date().getTime();
		
		$(window).on('load',function(){
			var now = new Date().getTime();
			var loading_end = false;
			var time;
			var time_del = now - loading_time;

			if ( time_del >= 500 ) {
				loading_end = true;
			}

			if ( loading_end ) {
				time = 0;
			} else {
				time = 500 - time_del;
			}

			// loading完成后请求
			setTimeout(function(){

				// 模版提示隐藏
				setTimeout(function(){
					$('.m-alert').addClass('f-hide');
				},1000)

				// 显示正面
				$('#j-mengban').addClass('z-show');

				// 显示封面内容
				setTimeout(function(){
					$('.translate-back').removeClass('f-hide');
					$('.m-fengye').removeClass('f-hide');
					tong.height_auto(tong._page.eq(tong._pageNow),'false');
				},1000)

				// setTimeout(function(){
	   //              window.scrollTo(0, 1);
	   //          }, 0);

				// media初始化
				tong.media_init();

				// 延迟加载后面三个页面图片
				tong.lazy_start();

				// 报名提交执行
				tong.signUp_submit();
				
				// 插件加载
		        tong.plugin();
				
				var channel_id = location.search.substr(location.search.indexOf("channel=") + 8);
				channel_id= channel_id.match(/^\d+/) ; 
				if (!channel_id || isNaN(channel_id) || channel_id<0) {
				channel_id = 1;
				}
		 	 	var activity_id = $('#activity_id').val();
		 	 	var url = "/auto/analyse/"+activity_id + "?channel="+channel_id;
				 //报名统计请求
			 	$.get(url,{},function(){});

			 	$('.p-ct').height($(window).height());
				$('.m-page').height($(window).height());
				$('#j-mengban').height($(window).height());
				$('.translate-back').height($(window).height());
			},time)
		})
	}
};
/*初始化对象函数*/
tong.init();

