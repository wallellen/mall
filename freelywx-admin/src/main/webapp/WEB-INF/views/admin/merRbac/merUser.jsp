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
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:1;">
            <div size="240" showCollapseButton="true">
            	 <div class="mini-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">                
		            <span style="padding-left:5px;">名称：</span>
		            <input class="mini-textbox" name="site_name" id="site_name" />
		            <a class="mini-button" iconCls="icon-search" plain="true" onclick="searchSite()">查找</a>                  
		        </div>
		        <div class="mini-fit">
		            <ul id="tree1" class="mini-tree" url="${ctx}/site/all" style="width:300px;margin-top: 10px;" 
	                    showTreeIcon="true" textField="site_name" parentField="par_id" idField="site_id" 
						expandOnLoad="true" resultAsTree="false" onnodeselect="onSelectNode">        
	                </ul>
		        </div>
                
            </div>
            <div showCollapseButton="false" style="border:0;">
			<div style="padding-bottom:5px;">
		        <span>登录名：</span><input type="text" id="search_like_loginId"  />
		        <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		        <span>真实姓名：</span><input type="text" id="search_like_userName"  />
		        <input type="button" value="查找" onclick="search()"/>
		        <span >&nbsp;</span>
		        <input type="button" value="重置" onclick="reset()"/>
		    </div>
		        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;">
		                <tr>
		                    <td style="width:100%;">
		                        <a class="mini-button" iconCls="icon-add" onclick="add()">增加用户</a>
		                        <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改用户</a>
		                        <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除用户</a>  
		                       <!--  <a class="mini-button" iconCls="icon-users" onclick="bandUserInfo()">绑定用户组</a>        -->
		                        <a class="mini-button" iconCls="icon-role" onclick="bandRoleInfo()">绑定角色</a>       
		                             
		                    </td>
		                </tr>
		            </table>           
		        </div>
		    <div class="mini-fit" >
		    <div id="userDategrid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
		        url="${ctx}/admin/merUser/list"  idField="user_id" multiSelect="true" >
		        <div property="columns">
		        	<div type="indexcolumn"></div>
		            <!-- <div type="checkcolumn"></div> -->
		            <div field="login_id" width="120" headerAlign="center" allowSort="true">登录名称</div>    
		            <div field="user_name" width="120" headerAlign="center" allowSort="true">真实姓名</div>    
		            <div field="user_status" width="120"  renderer="onDict" headerAlign="center" allowSort="true">用户状态</div>    
		           <!--  <div field="user_type" width="120"  renderer="onDict" headerAlign="center" allowSort="true">用户状态</div>   -->  
		        </div>
		    </div>
		    </div>
		    </div>
	</div>
	<div id="userBindWindow" class="mini-window" title="用户组绑定" style="width:350px;"  showModal="true" allowResize="true" allowDrag="true" >
		    <div id="listUser" class="mini-listbox" style="width:340px;height:120px;"   showCheckBox="true" multiSelect="true" >     
			    <div property="columns">
			        <div header="用户组" field="text"></div>
			    </div>
			</div>
		    <div id="userGroupDiv" style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">     
			  <a class="Update_Button" href="javascript:doBandUserInfo()" >确定</a> 
	          <a class="Cancel_Button" href="javascript:cancel()">取消</a>
			</div>
	</div>
	<div id="roleBindWindow" class="mini-window" title="角色绑定" style="width:350px;"  showModal="true" allowResize="true" allowDrag="true" >
		    <div id="listRole" class="mini-listbox" style="width:340px;height:120px;"   showCheckBox="true" multiSelect="true" >     
			    <div property="columns">
			        <div header="角色" field="text"></div>
			    </div>
			</div>
		    <div id="userRoleDiv" style="text-align:right;padding-top:5px;padding-right:20px; " colspan="6">     
			  <a class="Update_Button" href="javascript:doBandRoleInfo()" >确定</a> 
	          <a class="Cancel_Button" href="javascript:cancel()">取消</a>
			</div>
	</div>
    
	
    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("userDategrid");
        grid.load();
        grid.sortBy("user_id", "asc");
        var editWindow = mini.get("editWindow");
        var addWindow = mini.get("addWindow");
        var userBindWindow =  mini.get("userBindWindow");
        var roleBindWindow =  mini.get("roleBindWindow");
        var listUser = mini.get("listUser");
        var listRole = mini.get("listRole");
    	var tree = mini.get("tree1");
        
        function searchSite() {
			var site_name = mini.get("site_name").getValue();
			tree.load("${ctx}/site/all?site_name="+site_name);
		}
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
        		var data = { action : "new",site_id:node.site_id };
            	mini.open({
    				url : "${ctx }/admin/merUser/add",
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
        	}else{
        		alert("清先选择树节点！");
        	}
        	
        }
        function remove() {   
       	 var row = grid.getSelected();
       	 if(row){
       		//删除之前验证所选记录是否存在
    			if (confirm("确定删除选中记录？")) {
    				//删除
					$.post('${ctx}/admin/merUser/delete/' + row.user_id, function(data) {
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
        function edit() {
        	 var row = grid.getSelected();
             if (row) {
            	 var data = { action : "edit",userId : row.user_id };
             	mini.open({
     				url : "${ctx }/admin/merUser/add",
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
             }else{
            	 alert("请选中一条记录");
             }
            
        }
        function search() {
        	var search_like_loginId = $("#search_like_loginId").val();
        	var search_like_userName = $("#search_like_userName").val();
        	grid.load({
        		login_id: search_like_loginId, 
        		user_name: search_like_userName
        	});
        }
        function reset() {
        	$("#search_like_loginId").val("");
        	$("#search_like_userName").val("");
        }
        function cancel() {
            grid.reload();
            userBindWindow.hide();
            roleBindWindow.hide();
        }
        
        function bandUserInfo() {  
        	var row = grid.getSelected();
            if (row) {
            	var url  = "${ctx}/admin/merUser/getAllUserGroup/";
            	 $.ajax({
                     url: url + row.user_id,
                     dataType:"json",
                     type:"get", 
                     contentType:'application/json;charset=UTF-8',  
                     success: function (text) {
                    	 var myobj=eval(text);   
                    	 var str ="";
                    	 for(var i=0;i<myobj.length;i++){   
                    		 if(myobj[i].ischecked){
                    			 str  += myobj[i].id +","; 
                    		 }
                    	 }  
                    	 listUser.loadData(myobj);
                    	 listUser.setValue(str);
                    	 userBindWindow.show(); 
                     },
                     error: function () {
                    	 notify("表单加载错误");
                         form.unmask();
                     }
                 });
            }else{
            	alert("请选择一个用户");
            }
        }
        
        function  doBandUserInfo(){
        	var row = grid.getSelected();
        	var value = listUser.getValue();
        	var url = "${ctx}/admin/merUser/insertUesrGroupUser/";
        	$.post(url + row.user_id, {'boundInfos' : value}, function(data) {
				if (data) {
					userBindWindow.hide(); 
					notify("保存成功");
				} else {
					userBindWindow.hide(); 
					notify("保存失败");
				}
			}); 
        }
        function bandRoleInfo() {  
        	var row = grid.getSelected();
            if (row) {
            	 $.ajax({
                     url: "${ctx}/admin/merUser/getAllRole/" + row.user_id,
                     dataType:"json",
                     type:"get", 
                     contentType:'application/json;charset=UTF-8',  
                     success: function (text) {
                    	 var myobj=eval(text);   
                    	 var str ="";
                    	 for(var i=0;i<myobj.length;i++){   
                    		 if(myobj[i].ischecked){
                    			 str  += myobj[i].id +","; 
                    		 }
                    	 }  
                    	 listRole.loadData(myobj);
                    	 listRole.setValue(str);
                    	 roleBindWindow.show(); 
                     },
                     error: function () {
                    	 notify("表单加载错误");
                         form.unmask();
                     }
                 });
            }else{
            	alert("请选择一个用户");
            }
        }
        
        function  doBandRoleInfo(){
        	var row = grid.getSelected();
        	var value = listRole.getValue();
        	var url  = "${ctx}/admin/merUser/insertUesrRole/";
        	$.post(url + row.user_id, {'boundInfos' : value}, function(data) {
				if (data) {
					roleBindWindow.hide(); 
					notify("保存成功");
				} else {
					roleBindWindow.hide(); 
					notify("保存失败");
				}
			}); 
        }
        //////////// /////////////////////////////////////
        var dictMap = new Map();
		function onDict(e) {
			if (e.column.field == 'user_status'){
				return getDict(e, e.column.field, "USER_STATUS");
			}else if(e.column.field == 'user_type'){
				return getDict(e, e.column.field, "USER_TYPE");
			}
				
		}

    </script>
</body>
</html>