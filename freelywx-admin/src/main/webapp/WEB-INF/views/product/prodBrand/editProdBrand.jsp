<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp" %>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<link href="${res}/uploadify/uploadify.css" rel="stylesheet"type="text/css" />
<script src="${res}/uploadify/jquery.uploadify.js" type="text/javascript"></script>
<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%; 
    }    
</style>
</head>
<body>
	<input name="server_url" id="server_url" class="mini-hidden" value="${server_url }" />
	 <form id="form1" method="post">
        <input name="brand_id" id="brand_id" class="mini-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">品牌名称：</td>
                    <td style="width:150px;">    
                        <input name="brand_name" class="mini-textbox" required="true" onvalidation="checkCnName" emptyText="请输入品牌名称"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">英文名称：</td>
                    <td style="width:150px;">    
                        <input name="brand_name_en" class="mini-textbox" required="true" onvalidation="checkEnName" emptyText="请输入品牌名称"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">品牌排序：</td>
                    <td style="width:150px;">    
                        <input name="display_order" class="mini-textbox" vtype="int"/>
                    </td>
                </tr>
                <tr>
                    <td>品牌图片：</td>
                    <td>    
                        <input name="brand_url" id="brand_url" class="mini-hidden" />
						<img id="pic" src="${img}/noPic.jpg" alt="" width="130px" height="90px" style="margin-bottom: 10px;"/>
						<input type="file" multiple="true" id="imgUpload" />
                    </td>
                </tr> 
                <tr>
                    <td>品牌说明：</td>
                    <td>    
                        <input name="description"  class="mini-textArea"  style="width: 300px;"  />
                    </td>
                </tr> 
            </table>
        </div>
    
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
     <script type="text/javascript">
        mini.parse();
        var form = new mini.Form("form1");
        mini.get("server_url").setValue("${server_url}");
        $(function(){
        	$("#imgUpload").uploadify({
    		    buttonImage:"${img}/browse-btn.png",
    	        swf           : '${res}/uploadify/uploadify.swf',  // uploadify.swf在项目中的路径 
    	        uploader      : '${ctx}/file/upload;jsessionid=<%=session.getId()%>',  // 后台UploadController处理上传的方法
    	        formData	  : {path:'brand'},
    	        queueID		  :true,
    	        fileObjName     : 'file',         // The name of the file object to use in your server-side script  
    	        fileSizeLimit : '10MB', 
    	        height        : 26,  
    	        width         : 100 ,
    	        fileTypeExts  : '*.gif; *.jpg; *.png;*.jpeg',
    	        onUploadSuccess : function(file, data, response) {
    	        	var jsonOjb =eval("("+data+")");
    	        	if(jsonOjb.status == '1'){
    		        	mini.get('brand_url').setValue(jsonOjb.url);
    		        	$('#pic').attr("src",jsonOjb.previewUrl);
    	        	}else{
    	        		alert("服务器异常，请稍后重试!");
    	        	}
    	        },
    	        onUploadError : function(file, errorCode, errorMsg, errorString) {
                	//alert('文件: ' + file.name + ' 上传失败，原因: ' + errorString);
    	        	alert("服务器异常，请稍后重试!");
            	},
    	        onCancel : function(file) {
    	            alert('文件： ' + file.name + ' 取消上传');
    	        }
    	    });
        });
        
        function SaveData() {
            var o = form.getData();            
            form.validate();
            if (form.isValid() == false) return;
            if(o.brand_url === ""){
            	alert('请上传品牌图片！');
            	return;
            }
            var json = mini.encode(o);
            $.ajax({
				url : "${ctx}/prodBrand/save",
				type : "POST",
				dataType : "json",
				contentType : 'application/json;charset=UTF-8',
				data : json,
				success : function(text) {
					if (text) {
						CloseWindow("save");
						notify("操作成功!");
					} else {
						alert("服务器繁忙，请稍后重试");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("服务器繁忙，请稍后重试");
				}
			});
        }
        //标准方法接口定义
        function SetData(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                data = mini.clone(data);
                $.ajax({
                    url: "${ctx}/prodBrand/brand?brandId=" + data.id,
                    cache: false,
                    success: function (text) {
                        var o = mini.decode(text);
                        form.setData(o);
                        var url = (mini.get("server_url").getValue()+o.brand_url).replace("\"","");
                        $("#pic").attr('src',url);
                        form.setChanged(false);
                    }
                });
            }
        }

        function GetData() {
            var o = form.getData();
            return o;
        }
        function CloseWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();            
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        function checkCnName(e){
			if (e.isValid) {
				$.ajax({
                    url: "${ctx}/prodBrand/checkCn",
                    cache: false,
                	async: false,
                	data : {"brandName":e.value,"brandId":mini.get("brand_id").getValue()},
                    success: function (text) {
                    	if(!text){
                    		 e.errorText = "该品牌名称已经存在!";
                             e.isValid = false;
                    	}
                    }
                });
            }
		}
        function checkEnName(e){
			if (e.isValid) {
				$.ajax({
                    url: "${ctx}/prodBrand/checkEn",
                    cache: false,
                	async: false,
                	data : {"brandEnName":e.value,"brandId":mini.get("brand_id").getValue()},
                    success: function (text) {
                    	if(!text){
                    		 e.errorText = "该品牌名称已经存在!";
                             e.isValid = false;
                    	}
                    }
                });
            }
		}


    </script>
</body>
</html>