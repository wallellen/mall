/**
 * myloading.js 显示或隐藏loading控件,依赖jquery.js, spin.js, jquery.spin.js
 */

 //默认配置
var opts = {
    lines: 12,            // The number of lines to draw
    length: 7,            // The length of each line
    width: 5,             // The line thickness
    radius: 10,           // The radius of the inner circle
    rotate: 0,            // Rotation offset
    corners: 1,           // Roundness (0..1)
    color: '#000',        // #rgb or #rrggbb
    direction: 1,         // 1: clockwise, -1: counterclockwise
    speed: 1,             // Rounds per second
    trail: 100,           // Afterglow percentage
    shadow: false,        // Whether to render a shadow
    hwaccel: false,       // Whether to use hardware acceleration
    opacity: 1/4,         // Opacity of the lines
    fps: 20,              // Frames per second when using setTimeout()
    zIndex: 2e9,          // Use a high z-index by default
    className: 'spinner', // CSS class to assign to the element
    top: '40%',           // center vertically
    left: '50%',          // center horizontally
    position: 'absolute'  // element position
};

//显示loading，传入idstr:所在div的id，opts:用户自定义配置(不传则用默认)
function showloading(idstr,opts){
    //$("body").remove("#"+idstr);
    var loading_fade = $("<div style='position: absolute;top: 0%;left: 0%;width: 100%;height: 100%;background-color: gray;z-index:31;-moz-opacity: 0.8;opacity:.40;filter: alpha(opacity=40); float:left; display:block;'></div>");
    loading_fade.attr("id",idstr).appendTo("body").spin(opts);
}

//隐藏loading，传入idstr:所在div的id
function stoploading(idstr) {
    $("#"+idstr).spin(false).remove();
}