<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp" %>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
</head>
<body>
	<!-- <div style="padding-bottom:5px;">
        <span>角色名称：</span><input type="text" id="search_like_roleNm"  />
        <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <span>描述：</span><input type="text" id="search_like_roleDesc"  />
        <input type="button" value="查找" onclick="search()"/>
        <span >&nbsp;</span>
        <input type="button" value="重置" onclick="reset()"/>
    </div> -->
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="mini-button" iconCls="icon-add" onclick="add()">增加</a>
                        <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改</a>
                        <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>       
                    </td>
                </tr>
            </table>           
        </div>
    <div class="mini-fit" >
    <div id="optTreeGrid" class="mini-treegrid" style="width:100%;height:100%;"  url="${ctx}/admin/funopt/listAll" showTreeIcon="true" treeColumn="fun_opt_nm" idField="fun_opt_id" parentField="parent_fun_opt_id" resultAsTree="false"  allowResize="true" expandOnLoad="true">
	    <div property="columns">
	        <div type="indexcolumn"></div>
	        <div name="fun_opt_nm" field="fun_opt_nm" width="160" >功能操作名称</div>
	        <div field="url" width="240">URL前缀</div>
	        <div field="remarks" width="300" align="right">备注</div>
	    </div>
	</div>
	</div>
	
    <script type="text/javascript">
        mini.parse();
        var optTreeGrid = mini.get("optTreeGrid");
        optTreeGrid.load();
        optTreeGrid.sortBy("fun_opt_id", "asc");
        
        function add() {
       	 var row = optTreeGrid.getSelected();
       	 var data ;
            if (row) {
           	 data = { action : "new" ,parent_fun_opt_id : row.fun_opt_id};
            }else{
           	 data = { action : "new" };
            }
        
       	mini.open({
				url : "${ctx }/admin/funopt/edit",
				title : "新增",
				width : 650,
				height : 350,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					optTreeGrid.reload();
				}
			});
       }
       
       function edit() {
       	 var row = optTreeGrid.getSelected();
            if (row) {
           	 var data = { action : "edit" ,fun_opt_id : row.fun_opt_id };
            	mini.open({
    				url : "${ctx }/admin/funopt/edit",
    				title : "新增",
    				width : 650,
    				height : 350,
    				onload : function() {
    					var iframe = this.getIFrameEl();
    					iframe.contentWindow.SetData(data);
    				},
    				ondestroy : function(action) {
    					optTreeGrid.reload();
    				}
    			});
            }
       	
       }
        
        function remove() {   
        	 var row = optTreeGrid.getSelected();
        	 if(row){
        		//删除之前验证所选记录是否存在
     			$.post('${ctx}/admin/funopt/delFreCheck/' + row.fun_opt_id, function(msg){
     				if(msg){
     					$.post('${ctx}/admin/funopt/checkChild/' + row.fun_opt_id, function(checkMsg){
    						if(checkMsg){
    							 if (confirm("确定删除选中资源？")) {
    								 $.post('${ctx}/admin/funopt/delete/' + row.fun_opt_id, function(data) {
 										if(data) {
 											notify('记录删除成功!');
 											optTreeGrid.reload();
 										} else {
 											notify('记录删除失败!');
 										}
 									});	
    							 }
    						}else{
    							notify('不能删除有子节点的父节点');
    						}
    					});
    				}else{
    					LG.tip("请确认记录是否存在.");
    				}
     			});
        	 }else {
                 alert("请选中一条记录");
             }
        }
    </script>
</body>
</html>