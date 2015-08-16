<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp" %>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<script type="text/javascript" charset="utf-8" src="${res}/swfupload/swfupload.js"></script>
<script type="text/javascript" charset="utf-8" src="${res}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${res}/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${res}/ueditor/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet" href="${res}/ueditor/themes/default/css/ueditor.css" type="text/css">
<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%; overflow-x:hidden;word-break:break-all; 
    }    
    </style>
</head>
<body>
	<form id="form" method="post">
    <div style="padding-left:11px;padding-bottom:5px;">
	    <input name="id" id="id" class="mini-hidden" />
		<table  style="table-layout:fixed;">
			<tr>
				<td>匹配类型：</td>
				<td><input id="type" name="type" 
					emptyText="请选择匹配类型"
					url="${ctx}/combox/dict/MATCH_TYPE" class="mini-combobox"    style="width:600px;"/>
				</td>
			</tr>
			<tr>
				<td>关键字：</td>
				<td>
					<input id="keyword" name="keyword" class="mini-textarea"  
					emptyText="多个关键词请用空格格开：例如: 美丽 漂亮 "
					 style="width:600px;"  onvalidation="onKeyValidation"/>
				</td>
			</tr>
			<tr>
				<td>作者：</td>
				<td><input id="writer" name="writer" 
					emptyText="请输入作者名称"
					class="mini-textbox" errorMode="border"   style="width:600px;"/></td>
			</tr>
			<tr>
				<td>标题：</td>
				<td><input id="title" name="title" 
					emptyText="请输入标题"
					class="mini-textbox" errorMode="border"  style="width:600px;"/></td>
			</tr>
			<tr>
				<td>简介：</td>
				<td><input id="remark" name="remark" class="mini-textarea"
						emptyText="不能超过200字 " vtype="maxLength:200"
				 		   style="width:600px;"/>
				</td>
			</tr>
			<!-- <tr>
				<td>内容：</td>
				<td><input id="content" name="content" class="mini-textarea"    style="width:600px;" /></td>
			</tr> -->
			<tr>
				<td>封面地址：</td>
				<td>
					<input class="mini-fileupload"  id="picUpload"  
					flashUrl="${res}/swfupload/swfupload.swf"
					onfileselect="onFileSelect"
					onuploadsuccess="onUploadSuccess" 
					onuploaderror="onUploadError" 
					uploadUrl="${ctx}/file/upload"
					limitSize = "3MB"
					itType="*.jpg;*gif;*.png" />
					  <input name="pic" id="pic" class="mini-hidden" />
				</td>
			</tr>
			<tr>
				<td>链接地址：</td>
				<!--  
				<td><input id="url" name="url" vtype="url" class="mini-textbox"   style="width:600px;"/></td>
				 -->
	                <td style="width:600px;">
	                	<input id="btnEdit" width="250px" class="mini-buttonedit" vtype="url" onbuttonclick="onButtonEdit" name="url"  />
	                </td>
	                
				
			</tr>
			<tr>
			    <td>图文详情：</td>
			    <td>
			        <script id="editorEdit" charset="UTF-8" type="text/plain" style="width:600px;height:300px;"></script>
			        <input class="mini-hidden"  id="content" name="content"/>
			    </td>
			</tr>
			<tr> <td style="text-align:center;padding-top:5px;padding-right:20px;" colspan="6">
	                   <a class="mini-button" onclick="SaveData()" style="width: 60px;">提交</a>&nbsp;&nbsp; 
					   <a class="mini-button" onclick="onCancel" style="width: 60px;">取消</a> 
	             </td>                
	        </tr>
		</table>
	</div>
	</form>
    <script type="text/javascript">
    	mini.parse();
		var form = new mini.Form("form");
		var editor = UE.getEditor('editorEdit')
        
		function SaveData() {
	        form.validate();
	        if (form.isValid() == true) {
	        	mini.get("content").setValue(editor.getContent());
	        	var o = form.getData();
	            var json = mini.encode(o);
	            alert(json);
	            $.ajax({
	                url: "${ctx}/reply/img/save",
	                type:"POST", 
	                dataType:"json",      
	                contentType:'application/json;charset=UTF-8',  
	                data:json, 
	                success: function (text) {
	                	if(text){
	                		notify("添加 成功");
	                	}else{
	                		notify("服务器繁忙，请扫后重试");
	                	}
	                	CloseWindow("save");
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                	notify("服务器繁忙，请扫后重试");
	                }
	            });  
	        }
		}
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				data = mini.clone(data);
				$.ajax({
					url : "${ctx }/reply/img/getImg/" + data.id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
						editor.setContent(o.content)
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
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
		function onOk(e) {
			SaveData();
		}
		function onCancel(e) {
			CloseWindow("cancel");
		}
		function onKeyValidation(e){
	    	if (e.isValid) {
	        	$.ajax({
		            url: "${ctx}/reply/img/check",
		            type: "post",
		            data: { keyword: e.value ,id:mini.get("id").getValue()},
		            success: function (result) {
		           		if(!result){
	                   	   e.errorText = "该名称已经存在!";
	                       e.isValid = false; 
	                    }
	                },
	                error: function () {
	                  	notify("表单加载错误");
	                   	// e.errorText = "密码不能少于5个字符";
	                    e.isValid = false;
	               }
		       }); 
	        }
	    }
		
		function onUploadSuccess(e) {
			var json = mini.decode (e.serverData);
			if(json.status == "1"){
				mini.get("pic").setValue(json.previewUrl);
			}else{
				alert("服务器繁忙，请稍后重试！");
			}
		}
		 function onUploadError(e) {
			 alert("服务器繁忙，请稍后重试！");
		}
		function onFileSelect(e) {
			var fileupload = mini.get("picUpload");
			fileupload.setPostParam({path:"imgnews"});
			fileupload.startUpload();
		}

		
		
		
	   	 function onButtonEdit(e) {
	            var btnEdit = this;
	            mini.open({
	                url: "${ctx }//reply/img/select_url_tree",
	                title: "选择微网站页页",
	                width: 650,
	                height: 380,
	                ondestroy: function (action) {
	                    //if (action == "close") return false;
	                    if (action == "ok") {
	                        var iframe = this.getIFrameEl();
	                        var data = iframe.contentWindow.GetData();
	                        data = mini.clone(data);    //必须
	                        if (data) {
	                        	
	                        	btnEdit.setValue("");
	                            btnEdit.setText("");
	                            
	                            btnEdit.setValue(data.url);
	                            btnEdit.setText(data.url);
	                            
	                            
	                        }
	                    }
	                }
	            });     
	        }      
	   	 
	   	 
	   	 
    </script>
</body>
</html>