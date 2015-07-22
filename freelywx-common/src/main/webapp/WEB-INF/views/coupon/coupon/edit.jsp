<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%; 
    }    
</style>
</head>
<body>
	 <form id="form1" method="post">
        <input name="coupon_id" id="coupon_id" class="mini-hidden" value="0"/>
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">优惠券名称：</td>
                    <td style="width:150px;">    
                        <input name="coupon_name" class="mini-textbox" required="true"  emptyText="请输入名称" onvalidation="checkName"  maxLength="256" style="width: 300px;"/>
                    </td>
                </tr>
                <tr>
                    <td>有效时间范围：</td>
                    <td>    
                        <input id="coupon_start_time" name="coupon_start_time"  class="mini-datepicker"  style="width: 100px;" required="true"  vtype="date:yyyy-MM-dd" />
                        至
                        <input id="coupon_end_time" name="coupon_end_time"  class="mini-datepicker"  style="width: 100px;" required="true"  vtype="date:yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">消费金额(元)：</td>
                    <td style="width:150px;">    
                        <input id="coupon_reach" name="coupon_reach" class="mini-textbox" required="true"  vtype="int"/>
                        减少
                        <input id="coupon_value" name="coupon_value" class="mini-textbox" required="true"  vtype="int"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;">发行量：</td>
                    <td style="width:150px;">    
                        <input name="coupon_sum" class="mini-textbox" required="true"  vtype="int" style="width: 300px;"/>
                    </td>
                </tr>
                <tr>
                    <td>简介：</td>
                    <td>    
                        <input name="coupon_desc"  class="mini-textArea"  style="width: 300px;" maxLength="256"/>
                    </td>
                </tr>
            </table>
        </div>
        <fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >使用限制条件</legend>
	        <div style="padding-left:11px;padding-bottom:5px;">
	            <table style="table-layout:fixed;">
	                <tr>
	                    <td style="width:100px;">交易金额(元)：</td>
	                    <td style="width:150px;">    
	                        <input name="more_than" class="mini-textbox" required="true"  vtype="int"/>
	                        至
	                        <input name="less_than" class="mini-textbox" required="true"  vtype="int"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td>商品分类：</td>
	                    <td>    
		                        <input name="type" id="type" class="mini-treeselect" url="${ctx}/prodCate/list" multiSelect="true"  valueFromSelect="false"
							        textField="category_name" parentField="parent_category_id" valueField="category_id"   allowInput="true"
							        showCheckBox="true" showFolderCheckBox="false" popupWidth="200"  style="width: 300px;" required="true"
							    />
	                    </td>
	                </tr>
	            </table>
	        </div>
        </fieldset>
    
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
     <script type="text/javascript">
        mini.parse();
        var form = new mini.Form("form1");
        var coupon_reach = mini.get("coupon_reach");
        var coupon_value = mini.get("coupon_value");
        
        function SaveData() {
        	// 验证
            form.validate();
            if (form.isValid() == false) return;
            if(mini.get("coupon_start_time").getValue()>mini.get("coupon_end_time").getValue()){
				alert("有效开始时间必须小于有效结束时间");
				return;
            }

            // 修改值
	    	coupon_reach.setValue(coupon_reach.getValue()*100);
	    	coupon_value.setValue(coupon_value.getValue()*100);
            
            //保存值
            var o = form.getData();            
            var json = mini.encode(o);
            json = json.replace(/T00:00:00/g,' 00:00:00');
            
            $.ajax({
				url : "${ctx}/coupon/coupon/save",
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
                    url: "${ctx}/coupon/coupon/getEditR?coupon_id=" + data.coupon_id,
                    cache: false,
                    success: function (text) {
                        var o = mini.decode(text);
                        form.setData(o);
                        // 修改值
            	    	coupon_reach.setValue(coupon_reach.getValue()/100);
            	    	coupon_value.setValue(coupon_value.getValue()/100);
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
        function checkName(e){
			if (e.isValid) {
				$.ajax({
                    url: "${ctx}/coupon/coupon/checkName",
                    data : {"coupon_name":e.value,"coupon_id":mini.get("coupon_id").getValue()},
                    cache: false,
                	async: false,
                    success: function (text) {
                    	if(!text){
                    		 e.errorText = "该名称已经存在!";
                             e.isValid = false;
                    	}
                    }
                });
            }
		}
    </script>
</body>
</html>