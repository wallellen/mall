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
	<input name="category_id" id="category_id" class="mini-hidden" />
    <table style="margin-top: 5px;margin-left: 15px;">
        <tr>
            <td>
                <div id="listbox1" class="mini-listbox" style="width:150px;height:250px;"
                    textField="attr_name" valueField="attr_id" showCheckBox="true" multiSelect="true" >
                </div>
            </td>
            <td style="width:120px;text-align:center;">
                <input type="button" value=">" onclick="add()" style="width:40px;"/><br />
                <input type="button" value=">>" onclick="addAll()" style="width:40px;"/><br />
                <input type="button" value="&lt;&lt;" onclick="removeAll()" style="width:40px;"/><br />
                <input type="button" value="&lt;" onclick="removes()" style="width:40px;"/><br />

            </td>
            <td>
                <div id="listbox2" class="mini-listbox" style="width:250px;height:250px;"                     
                     showCheckBox="true" multiSelect="true" >     
                    <div property="columns">
                        <div header="属性名称" field="attr_name"></div>
                        <div header="属性类型" field="attr_type" renderer="onTypeRenderer"></div>
                       <!--  <div header="属性类型" field="attr_name"></div> -->
                    </div>
                </div>
            </td>
            <!-- <td style="width:50px;text-align:center;vertical-align:bottom">
                <input type="button" value="Up" onclick="upItem()" style="width:55px;"/>
                <input type="button" value="Down" onclick="downItem()" style="width:55px;"/>

            </td> -->
        </tr>
        <tr>
        	<td colspan="3">
        		<input type="button" value="确定" onclick="saveData()" style="width:55px;"/>
        		<input type="button" value="取消" onclick="saveData()" style="width:55px;"/>
        	</td>
        </tr>
    </table>    
    </form>
    <script type="text/javascript">
        mini.parse();
        var listbox1 = mini.get("listbox1");
        var listbox2 = mini.get("listbox2");

        //标准方法接口定义
        function SetData(data) {
        	//跨页面传递的数据对象，克隆后才可以安全使用
            data = mini.clone(data);
        	mini.get("category_id").setValue(data.id);
        	var listAllUrl = "${ctx}/prodAttr/listAll?categoryId="+data.id;
        	var listSelectUrl = "${ctx}/prodAttr/listSelect?categoryId="+data.id;
            listbox1.load(listAllUrl);
            listbox2.load(listSelectUrl);
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
        
        
        
        
        function add() {
            var items = listbox1.getSelecteds();
            listbox1.removeItems(items);
            listbox2.addItems(items);
        }
        function addAll() {        
            var items = listbox1.getData();
            listbox1.removeItems(items);
            listbox2.addItems(items);
        }
        function removes() {
            var items = listbox2.getSelecteds();
            listbox2.removeItems(items);
            listbox1.addItems(items);
        }
        function removeAll() {
            var items = listbox2.getData();
            listbox2.removeItems(items);
            listbox1.addItems(items);
        }
        function saveData() {
            var data = listbox2.getData();
            var attrIds = [];
            for (var i = 0, l = data.length; i < l; i++) {
                var r = data[i];
                attrIds.push(r.attr_id);
            }
            var id = attrIds.join(',');
            var categoryId = mini.get("category_id").getValue();
            $.ajax({
                url: "${ctx }/prodCate/bindAttr" ,
                //url: "${ctx }/prodCate/bindAttr?attrIds=" +id+"&categoryId="+categoryId,
                type : "POST",
                data:{"attrIds":id,"categoryId":categoryId},
                success: function (text) {
                	CloseWindow("save");
					notify("操作成功!");
                },
                error: function () {
                	alert("服务器异常，请稍后重试");
                }
            });
           
        }
        
        
        
        
        
        
        
        var attrType;
		function onTypeRenderer(e) {
			if(!attrType){
				$.ajax({
					url : "${ctx}/comboBox/attrType",
    	            async:false,		
					success : function(text) {
						attrType = text;
					},
					error : function() {
					}
				});
			}
            for (var i = 0, l = attrType.length; i < l; i++) {
                var g = attrType[i];
                if (g.id == e.value) return g.text;
            }
            return "";
			
		}
    </script>
</body>
</html>