<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp" %>
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
        <input name="attr_id" id="attr_id" class="mini-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;">属性名称：</td>
                    <td style="width:150px;">    
                        <input name="attr_name" class="mini-textbox" required="true" onvalidation="checkName"  emptyText="请输入名称"/>
                    </td>
                </tr>
               <!--  <tr>
                    <td style="width:100px;">属性类型：</td>
                    <td style="width:150px;">    
                        <input id="attrTypeCombo" name="attr_type" valueField="id" class="mini-comboBox" url="${ctx}/comboBox/attrType"   required="true" emptyText="请选择类型"/>
                    </td>
                </tr>
                <tr id="res" style="display: none">
                    <td style="width:100px;">属性单位：</td>
                    <td style="width:150px;">    
                        <input id="attrResCombo" name="res_id" class="mini-comboBox" />
                    </td>
                </tr> -->
                <tr>
                     <td>排序：</td>
                     <td>    
                         <input name="display_order" class="mini-textbox" vtype="int" />
                     </td>
                </tr>
                <tr>
                    <td>属性描述：</td>
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
        var attrTypeCombo = mini.get("attrTypeCombo");
        var attrResCombo = mini.get("attrResCombo");
        
        function onDrawCell(e) {
            var item = e.record, field = e.field, value = e.value;
            //组织HTML设置给cellHtml
            e.cellHtml = '<span class="'+e.value+' myiconspan">'+value+'</span>';   
        }
        function SaveData() {
            var o = form.getData();            
            form.validate();
            var json = mini.encode(o);
            if (form.isValid() == false) return;
            $.ajax({
				url : "${ctx}/prodAttr/save",
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
                    url: "${ctx}/prodAttr/attr?attrId=" + data.id,
                    cache: false,
                    success: function (text) {
                        var o = mini.decode(text);
                        form.setData(o);
                        //设置属性单位的默认值
                        var text = attrTypeCombo.getText();
                        //1、文本属性；2、单位属性
            			if(text === "单位属性"){
            				$("#res").show();
            				attrResCombo.setValue("");
            				var url = "${ctx}/comboBox/attrDict";
            				attrResCombo.load(url);
            				attrResCombo.setValue(o.res_id);
            			}
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
       
        var attrTypeCombo = mini.get("attrTypeCombo");
        var attrResCombo = mini.get("attrResCombo");
        function onTypeChanged(e) {
            var id = attrTypeCombo.getValue();
            var text = attrTypeCombo.getText();
            //1、文本属性；2、单位属性
			if(text === "单位属性"){
				$("#res").show();
				attrResCombo.setValue("");
				var url = "${ctx}/comboBox/attrDict";
				attrResCombo.load(url);
				attrResCombo.select(0);
			}else{
				attrResCombo.setValue("");
				$("#res").hide();
			}
            //positionCombo.setValue("");
        }
        function checkName(e){
			if (e.isValid) {
				$.ajax({
                    url: "${ctx}/prodAttr/check",
                    data : {"attrName":e.value,"attrId":mini.get("attr_id").getValue()},
                    cache: false,
                	async: false,
                    success: function (text) {
                    	if(!text){
                    		 e.errorText = "该属性名称已经存在!";
                             e.isValid = false;
                    	}
                    }
                });
            }
		}
    </script>
</body>
</html>