<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
}
</style>
<link href="${res}/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />
<script src="${res}/uploadify/jquery.uploadify.js"
	type="text/javascript"></script>

<script type="text/javascript" charset="utf-8"
	src="${ueditor }/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${ueditor }/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8"
	src="${ueditor }/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet"
	href="${res}/ueditor/themes/default/css/ueditor.css" type="text/css" />
</head>
<body>
	<div class="mini-fit">
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<div>
				<form id="form1" method="post">
					<input name="prod_id" id="prod_id" class="mini-hidden" />
					<table style="table-layout: fixed; width: 100%">
						<tr>
							<td style="width: 100px;">商品分类：</td>
							<td>
								<!-- <input name="category_name" class="mini-textBox" url=""/> -->
								<input name="category_id" id="category_id"
								class="mini-treeselect" url="${ctx}/prodCate/list"
								multiSelect="false" valueFromSelect="false"
								textField="category_name" parentField="parent_category_id"
								valueField="category_id" allowInput="true" multiSelect="false"
								showRadioButton="true" showFolderCheckBox="false"
								popupWidth="200" width="250px" />
							</td>
							<td style="width: 100px;">商品名称：</td>
							<td><input name="prod_name" class="mini-textbox"
								required="true" onvalidation="checkName" width="250px" /></td>
						</tr>
						<tr>
							<td>商品产地：</td>
							<td><input name="origin" class="mini-textbox"
								required="true" width="250px" /></td>
							<td style="width: 100px;">商品价格(元)：</td>
							<td><input id="sale_price_float" class="mini-textbox"
								onvalidation="checkSaleMoney" required="true" width="250px" /> <input
								name="sale_price" id="sale_price" class="mini-hidden" /></td>
						</tr>
						<tr>
							<td style="width: 100px;">生效时间：</td>
							<td><input name="active_start_date"
								class="mini-datepicker" required="true" format="yyyy-MM-dd"
								width="250px" /></td>
							<td style="width: 100px;">失效时间：</td>
							<td style="width: 150px;"><input name="active_end_date"
								class="mini-datepicker" required="true" format="yyyy-MM-dd"
								width="250px" /></td>
						</tr>

						<tr>
							<td style="width: 100px;">是否免运费：</td>
							<td><input name="free_shipping" id="free_shipping"
								class="mini-comboBox"
								url="${ctx}/comboBox/dictDetail?dictKey=COMMON_BOOLEAN_STATUS"
								required="true" onvaluechanged="onTypeChanged" width="250px" />
							</td>
							<td style="width: 100px;">库存：</td>
							<td><input name="stock" class="mini-textbox" required="true"
								vtype="int" width="250px" /></td>
						</tr>
						<tr id="prodFreigh" style="display: none">
							<td style="width: 100px;">商品运费(元)：</td>
							<td colspan="3"><input id="freigh_price_float"
								class="mini-textbox" onvalidation="checkFreighMoney"
								required="true" /> <input name="freigh_price"
								id="freigh_price" class="mini-hidden" /></td>
						</tr>
						<tr>
							<td>商品品牌：</td>
							<td><input name="brand_id" class="mini-comboBox"
								url="${ctx}/comboBox/brand" width="250px" /></td>
							<td>剩余数量：</td>
							<td><input name="remain_num" class="mini-textbox"
								required="true" vtype="int" width="250px" /></td>
						</tr>
						<tr>
							<td>排序：</td>
							<td><input name="display_order" class="mini-textbox"
								vtype="int" value="0" required="true" width="250px" /></td>
							<td style="width: 100px;">商品原价(元)：</td>
							<td><input id="retail_price_float" class="mini-textbox"
								onvalidation="checkRetailMoney" required="true" width="250px" />
								<input name="retail_price" id="retail_price" class="mini-hidden" />
							</td>
						</tr>
						<tr>
							<td style="width: 100px;">商品描述：</td>
							<td colspan="3"><input name="description"
								class="mini-textArea" style="width: 550px; height: 100px;"
								required="true" /></td>
						</tr>
						<tr>
							<td style="width: 100px;">功能描述：</td>
							<td colspan="3"><input id="long_description"
								name="long_description" class="mini-hidden"
								style="width: 550px; height: 100px;" required="true" /> <script
									id="editor" charset="UTF-8" type="text/plain"
									style="width: 600px; height: 300px;"></script></td>
						</tr>
					</table>
				</form>
				<form id="picForm" method="post">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td width="100">商品图片：</td>
							<td align="left">
								<table
									style="table-layout: fixed; width: 100%; text-align: left;">
									<tr>
										<td height="150px" width="150px" align="left">
											<span>
												<input name="url_1" id="h_imgUpload1" class="mini-hidden  hidinput" /> <img
												id="showUrl" name="pic1" src="${img}/noPic.jpg" alt=""		width="130px" height="90px" />
											</span>
											<p>
												<input type="file" id="imgUpload1" class="fileUploadClass" />
											<div class="divDeleClass uploadify-button "
												style="background-image: url('${res}/images/browse-btn-del.png'); text-indent: -9999px; height: 26px; line-height: 26px; width: 100px;">
												<span class="uploadify-button-text">删除图片</span>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<td align="left">
								<table
									style="table-layout: fixed; width: 100%; text-align: left;">
									<tr>
										<td height="150px" width="150px" align="left">
											<span>
												<input name="url_2" id="h_imgUpload2" class="mini-hidden  hidinput" value="" />
												<img id="showUrl" name="pic2" src="${img}/noPic.jpg" alt=""
												width="130px" height="90px" />
											</span>
											<p>
												<input type="file" id="imgUpload2" class="fileUploadClass" />
											<div class="divDeleClass uploadify-button "
												style="background-image: url('${res}/images/browse-btn-del.png'); text-indent: -9999px; height: 26px; line-height: 26px; width: 100px;">
												<span class="uploadify-button-text">删除图片</span>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<td align="left">
								<table
									style="table-layout: fixed; width: 100%; text-align: left;">
									<tr>
										<td height="150px" width="150px" align="left">
											<span>
												<input name="url_3" id="h_imgUpload3" class="mini-hidden  hidinput" /> <img
												id="showUrl" name="pic3" src="${img}/noPic.jpg" alt=""
												width="130px" height="90px" />
											</span>
											<p>
												<input type="file" id="imgUpload3" class="fileUploadClass" />
											<div class="divDeleClass uploadify-button "
												style="background-image: url('${res}/images/browse-btn-del.png'); text-indent: -9999px; height: 26px; line-height: 26px; width: 100px;">
												<span class="uploadify-button-text">删除图片</span>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<td align="left">
								<table
									style="table-layout: fixed; width: 100%; text-align: left;">
									<tr>
										<td height="150px" width="150px" align="left">
											<span>
												<input name="url_4" id="h_imgUpload4" class="mini-hidden  hidinput" /> <img
												id="showUrl" name="pic4" src="${img}/noPic.jpg" alt=""
												width="130px" height="90px" />
											</span>
											<p>
												<input type="file" id="imgUpload4" class="fileUploadClass" />
											<div class="divDeleClass uploadify-button "
												style="background-image: url('${res}/images/browse-btn-del.png'); text-indent: -9999px; height: 26px; line-height: 26px; width: 100px;">
												<span class="uploadify-button-text">删除图片</span>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<td align="left">
								<table
									style="table-layout: fixed; width: 100%; text-align: left;">
									<tr>
										<td height="150px" width="150px" align="left">
											<span>
												<input name="url_5" id="h_imgUpload5" class="mini-hidden  hidinput" /> <img
												id="showUrl" name="pic5" src="${img}/noPic.jpg" alt=""
												width="130px" height="90px" />
											</span>
											<p>
												<input type="file" id="imgUpload5" class="fileUploadClass" />
											<div class="divDeleClass uploadify-button "
												style="background-image: url('${res}/images/browse-btn-del.png'); text-indent: -9999px; height: 26px; line-height: 26px; width: 100px;">
												<span class="uploadify-button-text">删除图片</span>
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</form>
			</div>


			<div style="float: left;">
				<form id="form2" method="post">
					<table style="table-layout: fixed;" id="prodAttrTable">
						<c:if test="${! empty attrList }">
							<tr>
								<td colspan="4">商品属性<font color="red">(动态属性以竖线（|）作为分割)</font>：
								</td>
							</tr>
							<c:forEach var="item" items="${attrList}">
								<tr>
									<td style="width: 100px;">${item.attr_name }：</td>
									<td colspan="3"><input style="width: 300px;"
										id="${item.attr_id}_text" name="${item.attr_id}_text"
										class="mini-textbox prodAttrs" />
										<div id="${item.attr_id}_attr_type"
											name="${item.attr_id}_attr_type" class="mini-checkbox"
											checked="false" readOnly="false" text="动态属性"
											onvaluechanged="onValueChanged"
											style="color: red; margin-left: 40px;"></div>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</form>
				<div style="float: left; margin-top: 10px">
					<a class="mini-button" onclick="onOk"
						style="width: 60px; margin-right: 20px;">确定</a> <a
						class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
     	var editor = UE.getEditor('editor');
     	
        mini.parse();
        var form1 = new mini.Form("form1");
        var form2 = new mini.Form("form2");
        var picForm = new mini.Form("picForm");
        //默认为server_url 赋值
         $('.fileUploadClass').each(function(){
    		var obj = $(this).parent().parent(); 
    		var id = $(this).attr("id");
    		$("#"+id).uploadify({
    		    buttonImage:"${res}/images/browse-btn.png",
    	        swf           : '${res}/uploadify/uploadify.swf',  // uploadify.swf在项目中的路径 
    	        uploader      : '${ctx}/file/upload;jsessionid=<%=session.getId()%>', // 后台UploadController处理上传的方法
    	        formData : {
					path : 'prod',
					key	 : id
				},
				queueID : true,
				fileObjName : 'file', // The name of the file object to use in your server-side script  
				fileSizeLimit : '10MB',
				height : 26,
				width : 100,
				fileTypeExts : '*.gif; *.jpg; *.png;*.jpeg',
				onUploadSuccess : function(
						file, data, response) {
					var jsonOjb = eval("("+ data + ")");
					if (jsonOjb.status == '1') {
						//obj.find("#picur").val(	jsonOjb.url);
						mini.get("h_"+jsonOjb.key).setValue(jsonOjb.url);
						obj.find("#showUrl").attr("src",jsonOjb.previewUrl);
					} else {
						alert("服务器异常，请稍后重试!");
					}
				},
				onUploadError : function(file,
						errorCode, errorMsg,
						errorString) {
					//alert('文件: ' + file.name + ' 上传失败，原因: ' + errorString);
					alert("服务器异常，请稍后重试!");
				},
				onCancel : function(file) {
					alert('文件： ' + file.name+ ' 取消上传');
				}
			});								
		});
		$('.divDeleClass').live("click", function() {
			var obj = $(this).parent().parent();
			var id = obj.find(".hidinput").attr("id");
			if (id) {
				mini.get(id).setValue("");
				obj.find("#showUrl").attr("src", "${img}/noPic.jpg");
			} else {
				alert("请先上传图片");
			}

		});
		function SaveData() {
			mini.get("#long_description").setValue(editor.getContent());

			var o1 = form1.getData(true, false);
			form1.validate();
			var o2 = form2.getData();
			form2.validate();
			var o3 = picForm.getData();
			if (form1.isValid() && form2.isValid()) {
				if (o3.url_1 != "" || o3.url_2 != "" || o3.url_3 != "") {
					var json_1 = mini.encode(o1);
					var json_2 = mini.encode(o2);
					var json_3 = mini.encode(o3);
					$.ajax({
						url : "${ctx}/prod/save",
						type : "POST",
						data : {
							prodStr : json_1,
							picStr : json_3,
							attrStr : json_2
						},
						success : function(text) {
							if (text) {
								CloseWindow("save");
								//window.parent.notify("操作成功!");
							} else {
								alert("服务器繁忙，请稍后重试");
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							alert("服务器繁忙，请稍后重试");
						}
					});
				} else {
					alert("请至少上传一张产品图片!");
				}
			}
		}
		function timeOutFun() {
			editor.setContent(mini.get("#long_description").getValue());
		}
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "edit") {
				//跨页面传递的数据对象，克隆后才可以安全使用
				data = mini.clone(data);
				//商品基本信息
				$.ajax({
					url : "${ctx}/prod/product?prodId=" + data.id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form1.setData(o);
						if (o.free_shipping === "2") {
							$("#prodFreigh").show();
						}

						mini.get("sale_price_float").setValue(o.sale_price / 100);
						mini.get("retail_price_float").setValue(o.retail_price / 100);					
						mini.get("freigh_price_float").setValue(o.freigh_price / 100);
						form1.setChanged(false);
					}
				});
				setTimeout("timeOutFun()", 500);
				//商品属性信息
				$.ajax({
					url : "${ctx}/prod/attr?prodId=" + data.id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						/*  form2.setData(o);
						 form.setChanged(false); */
						for ( var i = 0; i < o.length; i++) {
							var id = o[i].attr_id + "_text";
							mini.get(id).setValue(o[i].attr_value);
							if (o[i].attr_type == 2) {
								//动态属性的情况
								mini.get(o[i].attr_id + "_attr_type").setChecked(true);
							}
						}
					}
				});
				//商品图片信息
				$.ajax({
					url : "${ctx}/prod/pic?prodId=" + data.id,
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						for ( var i = 0; i < o.length; i++) {
							var id = "url_" + (i + 1);
							var picId = "pic" + (i + 1);
							var url = ("${server_url}"+o[i].pic_url).replace("\"","");
							mini.getbyName(id).setValue(o[i].pic_url);
							$("img[name=" + picId + "]").attr('src', url);
						}
					}
				});
			} else {
				mini.get("category_id").setValue(data.categoryId);
				mini.get("category_id").disable();
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

		//var obj = mini.getByname("free_shipping");
		function onTypeChanged(e) {
			var obj = mini.get("free_shipping");
			var text = obj.getText();
			//1、文本属性；2、单位属性
			if (text === "否") {
				$("#prodFreigh").show();
			} else {
				$("#prodFreigh").hide();
			}
			//positionCombo.setValue("");
		}
		var exp = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
		function checkSaleMoney(e) {
			if (e.isValid) {
				if (!exp.test(e.value)) {
					e.errorText = "输入格式：12.03";
					e.isValid = false;
				} else {
					mini.get("sale_price").setValue(parseInt(e.value * 100));
				}
			}
		}
		function checkRetailMoney(e) {
			if (e.isValid) {
				if (!exp.test(e.value)) {
					e.errorText = "输入格式：12.03";
					e.isValid = false;
				} else {
					mini.get("retail_price").setValue(parseInt(e.value * 100));
				}
			}
		}
		function checkFreighMoney(e) {
			if (e.isValid) {
				if (!exp.test(e.value)) {
					e.errorText = "输入格式：12.03";
					e.isValid = false;
				} else {
					mini.get("freigh_price").setValue(parseInt(e.value * 100));
				}
			}
		}

		function checkName(e) {
			if (e.isValid) {
				$.ajax({
					url : "${ctx}/prod/check",
					data : {
						"prodName" : e.value,
						"prodId" : mini.get("prod_id").getValue()
					},
					cache : false,
					async : false,
					success : function(text) {
						if (!text) {
							e.errorText = "该名称商品已经存在!";
							e.isValid = false;
						}
					}
				});
			}
		}
		function onValueChanged(e) {
			var checked = this.getChecked();
			if (true) {

			}
		}
 
	</script>
</body>
</html>