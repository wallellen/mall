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
	<div style="padding-bottom:5px;">
        <span>字典编号：</span><input type="text" id="search_eq_dict_id"  />
        <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <span>字典名称：</span><input type="text" id="search_like_dict_name"  />
        <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <input type="button" value="查找" onclick="search()"/>
        <span >&nbsp;</span>
        <input type="button" value="重置" onclick="reset()"/>
    </div>
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                       <a class="mini-button" iconCls="icon-add" onclick="add()">增加</a>
                        <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改</a>
                        <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
                        <a class="mini-button" iconCls="icon-search" onclick="getDetail()">字典明细</a>       
                    </td>
                </tr>
            </table>           
        </div>
    <div class="mini-fit" >
    <div id="dictDataGrid" class="mini-datagrid" style="width:100%;height:100%;"  allowResize="true"
        url="${ctx}/sys/dict/list"  idField="dict_id" multiSelect="true" pageSize="100">
        <div property="columns">
        	<div type="indexcolumn"></div>
            <!-- <div type="checkcolumn"></div> -->
            <div field="dict_id" width="120" headerAlign="center" allowSort="true">字典编号</div>    
            <div field="dict_name" width="120" headerAlign="center" allowSort="true">字典名称</div>    
            <div field="dict_desc" width="240"   headerAlign="center" allowSort="true">字典描述</div>    
            <div field="dict_status" width="120" renderer="onDict"  headerAlign="center" allowSort="true">字典状态</div>    
          <!--   <div field="dict_type" width="120" renderer="onStateRenderer"   headerAlign="center" allowSort="true">字典类型</div>     -->
        </div>
    </div>
    </div>
    
	
    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("dictDataGrid");
        grid.load();
        grid.sortBy("dict_id", "asc");
        function add() {
       	 	var row = grid.getSelected();
       	 	var data = { action : "new"};
       	 	mini.open({
				url : "${ctx }/sys/dict/edit",
				title : "新增",
				width : 650,
				height : 350,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});	
       }
       
       function edit() {
       	 	var row = grid.getSelected();
       		if (row) {
          	var data = { action : "edit" ,dict_id : row.dict_id };
          	mini.open({
   				url : "${ctx }/sys/dict/edit",
   				title : "新增",
   				width : 650,
   				height : 350,
   				onload : function() {
   					var iframe = this.getIFrameEl();
   					iframe.contentWindow.SetData(data);
   				},
   				ondestroy : function(action) {
   					grid.reload();
   				}
   			});
           }   
       }
        
        //查询
        function search() {
        	var search_eq_dict_id = $("#search_eq_dict_id").val();
        	var search_like_dict_name = $("#search_like_dict_name").val();
        	grid.load({
        		dict_id: search_eq_dict_id, 
        		dict_name: search_like_dict_name
        	});
        }
        
        function reset() {
        	$("#search_eq_dict_id").val("");
        	$("#search_like_dict_name").val("");
        }
    
        //字典删除
        function remove() {   
	       	 var row = grid.getSelected();
	       	 if(row){
	       		if (confirm("确定删除字典？")) {
	       		//删除选中记录
					$.post("${ctx}/sys/dict/delete/"+ row.dict_id,function(result) {
						if (result) {
							notify('删除成功');
							grid.reload();
						} else {
							notify('删除失败');
						}
					});		
				}					
	       	 }else {
	       		 notify("请选中一条记录");
	            }
        }
        //字典详情
        function getDetail(){
        	var row = grid.getSelected();
	       	 if(row){
				window.location.href = "${ctx}/sys/dictDetail?dictId="+row.dict_id;	       				
	       	 }else {
	       		 notify("请选中一条记录");
	         }
        }
        var dictMap = new Map();
		function onDict(e) {
			if (e.column.field == 'dict_status'){
				return getDict(e, e.column.field, "STATE");
			}else if(e.column.field == 'dict_type'){
				return getDict(e, e.column.field, "USER_TYPE");
			}
				
		}
    </script>
</body>
</html>