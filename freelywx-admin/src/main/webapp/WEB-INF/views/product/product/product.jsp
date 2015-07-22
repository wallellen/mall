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
	<!-- <div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		<div title="center" region="center" style="border:0;" bodyStyle="overflow:hidden;"> -->
        <!--Splitter-->
        <div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:1;">
            <div size="240" showCollapseButton="true">
            	 <div class="mini-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">                
		            <span style="padding-left:5px;">名称：</span>
		            <input class="mini-textbox" name="categoryName" id="categoryName" />
		            <a class="mini-button" iconCls="icon-search" plain="true" onclick="searchCate()">查找</a>                  
		        </div>
		        <div class="mini-fit">
		            <ul id="tree1" class="mini-tree" url="${ctx}/prodCate/list" style="width:300px;margin-top: 10px;" 
	                    showTreeIcon="true" textField="category_name" parentField="parent_category_id" idField="category_id" 
						expandOnLoad="true" resultAsTree="false" onnodeselect="onSelectNode">        
	                </ul>
		        </div>
                
            </div>
            <div showCollapseButton="false" style="border:0;">
               <div style="padding-bottom:5px;">
			        <span>商品编号：</span><input id="key1" name="prod_code" class="mini-textbox" emptyText="请输入商品编号" style="width: 150px;" onenter="onKeyEnter" /> 
			        <span>商品名称：</span><input id="key" name="prod_name" class="mini-textbox" emptyText="请输入商品名称" style="width: 150px;" onenter="onKeyEnter" /> 
			        <input type="button" value="查找" onclick="search()"/>
			   </div>
               <div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
					<table style="width: 100%;">
						<tr>
							<td style="width: 100%;">
								<a class="mini-button" iconCls="icon-add" onclick="add()">增加</a> 
								<a class="mini-button" iconCls="icon-edit" onclick="edit()">编辑</a> 
								<a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
								<a class="mini-button" iconCls="icon-upload" onclick="shelfOn()">上架</a>
								<a class="mini-button" iconCls="icon-download" onclick="shelfOff()">下架</a>
								<a class="mini-button" iconCls="icon-download" onclick="qrcode()">生成二维码</a>
							</td>
						</tr>
					</table>
				</div>

				<div class="mini-fit">
					<div id="datagrid1" class="mini-datagrid"
						style="width: 100%; height: 100%;" allowResize="true"
						url="${ctx }/prod/list" idField="prod_id" multiSelect="true">
						<div property="columns">
							<div type="indexcolumn"></div>
							<div type="checkcolumn"></div>
							<div field="prod_name" width="120" headerAlign="center" align="center" allowSort="true">商品名称</div>
							<div field="prod_code" width="160" headerAlign="center" align="center" allowSort="true">商品编号</div>
							<div field="status" width="120" headerAlign="center" renderer="onDict" align="center" allowSort="true">状态</div>
							<div field="brandName" width="120" headerAlign="center" align="center" allowSort="true">商品品牌</div>
							<div field="origin" width="120" headerAlign="center" align="center" allowSort="true">产地</div>
							<div field="sale_price" width="120" headerAlign="center"  renderer="gridPriceRender" align="right" allowSort="true">商品价格</div>
							<div field="description" width="120" headerAlign="center" align="center" allowSort="true">商品描述</div>
							<div field="create_time" width="150" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" headerAlign="center">创建时间</div>
							<!-- <div field="free_shipping" width="120" headerAlign="center"  align="center" allowSort="true">是否免运费</div> -->
							<div field="freigh_price" width="120" headerAlign="center" renderer="gridPriceRender" align="right" allowSort="true">运费</div>
							
							
							<!-- <div name="action" width="120" headerAlign="center" align="center"	renderer="onActionRenderer" cellStyle="padding:0;">操作</div> -->
						</div>
					</div>
				</div>
            </div>        
     <!--    </div>
	</div> -->


			<script type="text/javascript">
				mini.parse();
				var grid = mini.get("datagrid1");
				grid.load();
				var tree = mini.get("tree1");
				
				function onSelectNode(e) {
		            var tree = e.sender;
		            var node = tree.getSelectedNode();
		            grid.load({
		            	category_id:node.category_id
		            });
		            //document.getElementById("nodeText").innerHTML = node.text;
		        }
				
				function add() {
		        	var node = tree.getSelectedNode();
		        	if(node ){
		        		if (node.category_id != 1){
		        			mini.open({
								url : "${ctx}/prod/edit?categoryId="+node.category_id,
								title : "新增",
								width : 1020,
								height : 800,
								onload : function() {
									var iframe = this.getIFrameEl();
									var data = {
										action : "new",
										categoryId: node.category_id,
										categoryName: node.category_name
									};
									iframe.contentWindow.SetData(data);
								},
								ondestroy : function(action) {
									grid.reload();
								}
		        			});
		        		}else{
		        			alert("请选择'商品分类'之外的分类");
		        		}
			        }else{
			        	alert("请选择一个分类");
			        }
					
				}
				function edit() {
					var row = grid.getSelected();
					if (row && row.status ==='1') {
						mini.open({
							url : "${ctx}/prod/edit?prodId="+row.prod_id,
							title : "编辑",
							width : 1020,
							height : 800,
							onload : function() {
								var iframe = this.getIFrameEl();
								var data = {
									action : "edit",
									id : row.prod_id
								};
								iframe.contentWindow.SetData(data); 
							},
							ondestroy : function(action) {
								grid.reload();
							}
						});

					} else {
						alert("请选中一条未上架的商品");
					}
				}
				function shelfOn() {
					var rows = grid.getSelecteds();
					var array  = new Array();
					
					$.each(rows, function(index, row) {
						if (row && row.status == '1') {
							array.push(row.prod_id);
						}
					});
					
					if (array.length != 0) {
						if (confirm("将选中商品上架？")) {
						$.ajax({
							url : "${ctx}/prod/shelf?flag=on&prodId="+array.join(),
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
						alert("请至少选中一条未上架商品");
					} 
				}
				function shelfOff() {
					var rows = grid.getSelecteds();
					var array  = new Array();
					
					$.each(rows, function(index, row) {
						if (row && row.status == '2') {
							array.push(row.prod_id);
						}
					});
					
					if (array.length != 0) {
						if (confirm("将选中商品下架？")) {
						$.ajax({
							url : "${ctx}/prod/shelf?flag=off&prodId="+array.join(),
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
						alert("请至少选中一条已上架商品");
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
					var key = mini.get("key").getValue();
					var key1 = mini.get("key1").getValue();
					grid.load({
						prod_code : key1,
						prod_name : key
					});
				}
				function searchCate() {
					var categoryName = mini.get("categoryName").getValue();
					tree.load("${ctx}/prodCate/list?category_name="+categoryName);
				}
				function onKeyEnter(e) {
					search();
				}
				
				var dictMap = new Map();
				function onDict(e) {
					if (e.column.field == 'status'){
							return getDict(e, e.column.field, "PROD_SHELF");
					} 
				}
					
					function qrcode() {
						var rows = grid.getSelecteds();
						var array  = new Array();
						
						$.each(rows, function(index, row) {
							array.push(row.prod_id);
						});
						
						if (array.length != 0) {
							if (confirm("确定生成二维码？")) {
								grid.loading("操作中，请稍后......");
								$.ajax({
									url : "${ctx}/prod/qrcode?prodId=" + array.join(),
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
			</script>
</body>
</html>