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
        <div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:1;">
            <div size="240" showCollapseButton="true">
            	 <div class="mini-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">                
		            <span style="padding-left:5px;">名称：</span>
		            <input class="mini-textbox" name="siteName" id="siteName" />
		            <a class="mini-button" iconCls="icon-search" plain="true" onclick="searchCate()">查找</a>                  
		        </div>
		        <div class="mini-fit">
		            <ul id="tree1" class="mini-tree" url="${ctx}/site/all" style="width:300px;margin-top: 10px;" 
	                    showTreeIcon="true" textField="site_name"  idField="site_id" 
						expandOnLoad="true" resultAsTree="false" onnodeselect="onSelectNode">        
	                </ul>
		        </div>
                
            </div>
            <div showCollapseButton="false" style="border:0;">
               <div style="padding-bottom:5px;">
			        <span>建筑名称：</span><input id="build_name" name="build_name" class="mini-textbox" emptyText="请输入建筑名称" style="width: 150px;" onenter="onKeyEnter" /> 
			        <input type="button" value="查找" onclick="search()"/>
			   </div>
               <div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
					<table style="width: 100%;">
						<tr>
							<td style="width: 100%;">
								<a class="mini-button" iconCls="icon-add" onclick="add()">增加</a> 
								<a class="mini-button" iconCls="icon-edit" onclick="edit()">编辑</a> 
								<a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
							</td>
						</tr>
					</table>
				</div>

				<div class="mini-fit">
					<div id="datagrid1" class="mini-datagrid"
						style="width: 100%; height: 100%;" allowResize="true"
						url="${ctx }/build/list" idField="prod_id" multiSelect="true">
						<div property="columns">
							<div type="indexcolumn"></div>
							<div type="checkcolumn"></div>
							<div field="site_name" width="120" headerAlign="center" align="center" allowSort="true">店铺名称</div>
							<div field="build_name" width="120" headerAlign="center" align="center" allowSort="true">名称</div>
							<div field="latitude" width="160" headerAlign="center" align="center" allowSort="true">经度</div>
							<div field="longitude" width="160" headerAlign="center" align="center" allowSort="true">纬度</div>
							<div field="description" width="160" headerAlign="center" align="center" allowSort="true">描述</div>
							<div field="sort" width="160" headerAlign="center" align="center" allowSort="true">排序</div>
						</div>
					</div>
				</div>
            </div>        
			<script type="text/javascript">
				mini.parse();
				var grid = mini.get("datagrid1");
				grid.load();
				var tree = mini.get("tree1");
				
				function onSelectNode(e) {
		            var tree = e.sender;
		            var node = tree.getSelectedNode();
		            grid.load({
		            	site_id:node.site_id
		            });
		            //document.getElementById("nodeText").innerHTML = node.text;
		        }
				
				function add() {
		        	var node = tree.getSelectedNode();
		        	if(node ){
		        		mini.open({
							url : "${ctx}/build/edit" ,
							title : "新增",
							width : "100%",
							height : "100%",
							onload : function() {
								var iframe = this.getIFrameEl();
								var data = {
									action : "new",
									site_id: node.site_id 
								};
								iframe.contentWindow.SetData(data);
							},
							ondestroy : function(action) {
								grid.reload();
							}
	        			});
			        }else{
			        	alert("请选择一个分类");
			        }
					
				}
				function edit() {
					var row = grid.getSelected();
					if (row ) {
						mini.open({
							url : "${ctx}/build/edit" ,
							title : "编辑",
							width : "100%",
							height : "100%",
							onload : function() {
								var iframe = this.getIFrameEl();
								var data = {
									action : "edit",
									build_id : row.build_id
								};
								iframe.contentWindow.SetData(data); 
							},
							ondestroy : function(action) {
								grid.reload();
							}
						});
					}  
				}
				function remove() {
					var rows = grid.getSelecteds();
					var array  = new Array();
					
					$.each(rows, function(index, row) {
						array.push(row.prod_id);
					});
					
					if (array.length != 0) {
						if (confirm("确定删除选中记录？")) {
							grid.loading("操作中，请稍后......");
							$.ajax({
								url : "${ctx}/prod/delete?prodId=" + array.join(),
								success : function(text) {
									if(text){
										notify("操作成功!");
										grid.reload();
									}else{
										alert("服务器异常，请稍后重试!");
									}
								},
								error : function() {
									alert("服务器异常，请稍后重试!");
								}
							});
						}
					} else {
						alert("请选中一条记录");
					}
				}
				function search() {
					var build_name = mini.get("build_name").getValue();
					grid.load({
						build_name : build_name 
					});
				}
				function searchCate() {
					var siteName = mini.get("siteName").getValue();
					tree.load("${ctx}/site/list?site_name="+siteName);
				}
				function onKeyEnter(e) {
					search();
				}
			</script>
</body>
</html>