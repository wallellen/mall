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
        <span>多图文回复的关键字：</span><input type="text" id="keyword"  />
        <!--  
        <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <span>公众号名称：</span><input type="text" id="public_name"  />
        -->
        <input type="button" value="查找" onclick="search()"/>
        <span >&nbsp;</span>
        <input type="button" value="重置" onclick="reset()"/>
    </div>
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="mini-button" iconCls="icon-add" onclick="add()">增加多图文详情模板</a>
                        <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改多图文详情模板</a>
                        <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除多图文详情模板</a>  
                       <!--  <a class="mini-button" iconCls="icon-users" onclick="bandUserInfo()">绑定用户组</a>        -->
                       <!--   <a class="mini-button" iconCls="icon-role" onclick="bandRoleInfo()">绑定角色</a>  -->     
                             
                    </td>
                </tr>
            </table>           
        </div>
    <div class="mini-fit" >
    <div id="userDategrid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
        url="${ctx}/reply/imgmulti/list"  idField="id" multiSelect="true" >
        <div property="columns">
        	<div type="indexcolumn"></div>
             <div type="checkcolumn"></div> 
            
            
            <div name="uid"  field="uid" headerAlign="center" allowSort="true" width="100" >uid
                <input   class="mini-textbox" style="width:100%;" minWidth="100" />
            </div>
            
            <div name="keyword"  field="keyword" headerAlign="center" allowSort="true" width="150" >回复关键字
                <input   class="mini-textbox" style="width:100%;" minWidth="100" />
            </div>
             
             
             <div name="imgids"  field="imgids" headerAlign="center" allowSort="true" width="150" >单图文列表
                <input   class="mini-textbox" style="width:100%;" minWidth="100" />
            </div>
            
            
             
             <div name="public_name"  field="public_name" headerAlign="center" allowSort="true" width="150" >微信用户
                <input   class="mini-textbox" style="width:100%;" minWidth="100" />
            </div>
            
            
             
            
        </div>
    </div>
    </div>
	
    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("userDategrid");
        grid.load(); 
        grid.sortBy("id", "asc");
        
        function search() { 
        	grid.load({
        		keyword: $("#keyword").val()
            	});
        }
        function add() {
        	var data = { action : "new" };
        	mini.open({
				url : "${ctx }/reply/imgmulti/edit",
				title : "新增",
				width : 850,
				height : 650,
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
            	 var data = { action : "edit",id : row.id };
             	mini.open({
     				url : "${ctx }/reply/imgmulti/edit",
     				title : "修改多图文",
     				width : 650,
     				height : 450,
     				onload : function() {
     					var iframe = this.getIFrameEl();
     					iframe.contentWindow.SetData(data);
     				},
     				ondestroy : function(action) {
     					grid.reload();
     				}
     				
     			});
             }else{
            	 alert("请选中一条记录");
             }
        }
        
        function remove() {   
          	 var row = grid.getSelected();
          	 if(row){
          		//删除之前验证所选记录是否存在
       			if (confirm("确定删除选中记录？")) {
       				//删除
   					$.post('${ctx}/reply/imgmulti/delete/' + row.id, function(data) {
   						if (data) {
   							notify('记录删除成功!');
   							 grid.reload();
   						} else {
   							notify('记录删除失败!');
   						}
   					});			
   				 }		 				
          	 }else {
                   alert("请选中一条记录");
               }
          }
        
        
       
        function reset() {
        	$("#keyword").val("");
        }
        //////////// /////////////////////////////////////
        var dictMap = new Map();
		function onDict(e) {
			if (e.column.field == 'industry'){
				return getDict(e, e.column.field, "INDUSTRY");
			}else if(e.column.field == 'label'){
				return getDict(e, e.column.field, "LABEL");
			}
				
		}

    </script>
</body>
</html>