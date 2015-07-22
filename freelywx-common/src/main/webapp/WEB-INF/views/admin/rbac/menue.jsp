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
    <div id="optTreeGrid" class="mini-treegrid" style="width:100%;height:100%;"  url="${ctx}/admin/menue/listAll" showTreeIcon="true" treeColumn="menue_nm" idField="menue_id" parentField="par_menue_id" resultAsTree="false"  allowResize="true" expandOnLoad="true">
	    <div property="columns">
	        <div type="indexcolumn"></div>
	        <div name="menue_nm" field="menue_nm" width="260" >菜单名称</div>
	        <div field="remarks" width="240">备注</div>
	      <!--   <div field="state" renderer="onStateRenderer" width="100" align="left">状态</div> -->
	    </div>
	</div>
	</div>
    <script type="text/javascript">
        mini.parse();
        var optTreeGrid = mini.get("optTreeGrid");
        optTreeGrid.sortBy("menue_order", "desc");
        optTreeGrid.load();
       
        function add() {
        	 var row = optTreeGrid.getSelected();
        	 var data ;
             if (row) {
            	 data = { action : "new" ,par_menue_id : row.menue_id};
             }else{
            	 data = { action : "new" };
             }
         
        	mini.open({
				url : "${ctx }/admin/menue/edit",
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
            	 var data = { action : "edit" ,menue_id : row.menue_id };
             	mini.open({
     				url : "${ctx }/admin/menue/edit",
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
        		$.post("${ctx}/admin/menue/fredelcheck/"+ row.menue_id,function(msg) {
        			if (msg) {
						$.post("${ctx}/admin/menue/checkChild/"+ row.menue_id,function(checkMsg) {
							if (checkMsg) {
								if (confirm("确定删除菜单？")) {
									//删除选中记录
									$.post("${ctx}/admin/menue/deleteMenue/"+ row.menue_id,function(result) {
										if (result) {
											notify('删除成功');
											optTreeGrid.reload();
										} else {
											notify('删除失败');
										}
									});		
								}
							} else {
								notify('不能删除有叶子节点的父节点');
							}
						});
					} else {
						notify('您选择的记录不存在');
					}				
				});
        	 }else {
        		 notify("请选中一条记录");
             }
        }
    </script>
</body>
</html>