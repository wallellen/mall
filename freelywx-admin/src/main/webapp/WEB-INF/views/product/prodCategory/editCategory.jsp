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
        <input name="category_id" id="category_id" class="mini-hidden" />
        <input name="parent_category_id" id="parent_category_id" class="mini-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">分类名称：</td>
                    <td style="width:150px;">    
                        <input name="category_name" class="mini-textbox" required="true" onvalidation="checkName" emptyText="请输入名称"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">父分类：</td>
                    <td style="width:150px;">    
                        <input id="buttonedit" class="mini-buttonedit"  onbuttonclick="opeoTreeWindow" />
                    </td>
                </tr>
                <tr>
                     <td>排序：</td>
                     <td>    
                         <input name="display_order" class="mini-textbox" vtype="int"/>
                     </td>
                </tr>
                <tr>
                    <td>分类图片：</td>
                    <td>    
                        <input name="category_url" id="category_url" class="mini-hidden" />
						<img id="pic" src="${img}/noPic.jpg" alt="" width="130px" height="90px" style="margin-bottom: 10px;"/>
						<input type="file" multiple="true" id="imgUpload" />
                    </td>
                </tr> 
                <tr>
                    <td>分类描述：</td>
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
    		    queueID:true,
    	        swf           : '${res}/uploadify/uploadify.swf',  // uploadify.swf在项目中的路径 
    	        uploader      : '${ctx}/file/upload;jsessionid=<%=session.getId()%>',  // 后台UploadController处理上传的方法
    	        formData	  : {path:'category'},
    	        fileObjName     : 'file',         // The name of the file object to use in your server-side script  
    	        fileSizeLimit : '10MB', 
    	        height        : 26,  
    	        width         : 100 ,
    	        fileTypeExts  : '*.gif; *.jpg; *.png;*.jpeg',
    	        onUploadSuccess : function(file, data, response) {
    	        	var jsonOjb =eval("("+data+")");
    	        	if(jsonOjb.status == '1'){
    		        	mini.get('category_url').setValue(jsonOjb.url);
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
        function opeoTreeWindow() {
            var btnEdit = this;
            mini.open({
                url: "${ctx}/prodCate/selectCategory?id="+mini.get("category_id").getValue()+"&pid="+ mini.get("parent_category_id").getValue(),
                showMaxButton: false,
                title: "选择上级分类",
                width: 350,
                height: 420,
                ondestroy: function (action) {                    
                    if (action == "ok") {
                        var iframe = this.getIFrameEl();
                        var data = iframe.contentWindow.GetData();
                        data = mini.clone(data);
                        if (data) {
                            mini.get("parent_category_id").setValue(data.category_id);
                            btnEdit.setValue(data.category_name);
                            btnEdit.setText(data.category_name);
                        }
                    }
                }
            });            
		}
        function SaveData() {
            var o = form.getData();            
            form.validate();
            if (form.isValid() == false) return;
            if(o.category_url === ""){
            	alert('请上传分类图片！');
            	return;
            }
            $.post( "${ctx }/prodCate/save",o,function(){
            	CloseWindow("save");
            });
        }
        //标准方法接口定义
        function SetData(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                data = mini.clone(data);
                $.ajax({
                    url: "${ctx}/prodCate/category?categoryId=" + data.id,
                    cache: false,
                    success: function (text) {
                        var o = mini.decode(text);
                        form.setData(o);
                        //父级分类的填充
                        mini.get("parent_category_id").setValue(o.parent_category_id);
                        mini.get("buttonedit").setValue(o.pName);
                        mini.get("buttonedit").setText(o.pName);
                        var url = (mini.get("server_url").getValue()+o.category_url).replace("\"","");
                        $("#pic").attr('src',url);
                        form.setChanged(false);
                    }
                });
            }else{
            	var pid=data.pid?data.pid:1;
            	var pname=data.pname?data.pname:"产品分类";
            	mini.get("parent_category_id").setValue(pid);
            	
            	mini.get("buttonedit").setText(pname);
            	mini.get("buttonedit").setValue(pname);
            	
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
       
        function checkName(e){
        	if (e.isValid ) {
        		$.ajax({
    				url : "${ctx}/prodCate/check",
    				type : "POST",
    				async:false,	
    				data : {"categoryName":e.value,"categoryId":mini.get("category_id").getValue()},
    				success : function(text) {
    					if (!text) { 
    						e.errorText = "已经存在该分类名称";
    	                    e.isValid = false;
    					}
    				},
    				error : function(jqXHR, textStatus, errorThrown) {
    					alert("服务器繁忙，请稍后重试");
    				}
    			});
            }
        }


    </script>
</body>
</html>