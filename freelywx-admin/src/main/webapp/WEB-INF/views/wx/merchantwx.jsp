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
        <span>帐号：</span><input type="text" id="user_id"  />
        <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <span>公众号名称：</span><input type="text" id="public_name"  />
        <input type="button" value="查找" onclick="search()"/>
        <span >&nbsp;</span>
        <input type="button" value="重置" onclick="reset()"/>
    </div>
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="mini-button" iconCls="icon-add" onclick="add()">增加微信号</a>
                        <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改微信号</a>
                        <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除微信号</a>  
                       <!--  <a class="mini-button" iconCls="icon-users" onclick="bandUserInfo()">绑定用户组</a>        -->
                       <!--   <a class="mini-button" iconCls="icon-role" onclick="bandRoleInfo()">绑定角色</a>  -->     
                             
                    </td>
                </tr>
            </table>           
        </div>
    <div class="mini-fit" >
    <div id="userDategrid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
        url="${ctx}/wx/list"  idField="wx_id" multiSelect="true" >
        <div property="columns">
        	<div type="indexcolumn"></div>
             <div type="checkcolumn"></div> 
            
            <div name="public_name"  field="public_name" headerAlign="center" allowSort="true" width="60" >公众号名称
                <input   class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="wx_number"  field="wx_number" headerAlign="center" allowSort="true" width="60" >微信号
                <input  class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="app_id"  field="app_id" headerAlign="center" allowSort="true" width="60" >app_id
                <input  class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="app_secret"  field="app_secret" headerAlign="center" allowSort="true" width="60" >app_secret
                <input  class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="encodetype"  field="encodetype" headerAlign="center" allowSort="true" width="60" >消息加密模式
                <input   class="mini-textbox" style="width:100%;" minWidth="200"  />
            </div>
            
             
            
            <div name="encodekey"  field="encodekey" headerAlign="center" allowSort="true" width="60" >加密密钥
                <input  class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="matchinfo"  field="matchinfo" headerAlign="center" allowSort="true" width="60" >matchinfo
                <input   class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="lbs"  field="lbs" headerAlign="center" allowSort="true" width="60" >地理位置
                <input   class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="token"  field="token" headerAlign="center" allowSort="true" width="60" >token
                <input   class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="portrait_url"  field="portrait_url" headerAlign="center" allowSort="true" width="60" >图像地址
                <input  class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            <div name="port_url"  field="port_url" headerAlign="center" allowSort="true" width="60" >接口地址
                <input  class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
             
            
            <div field="public_type" width="30" renderer="onDict" >公众号类型</div>
            
            
            <div name="qr_url"  field="qr_url" headerAlign="center" allowSort="true" width="60" >二维码地址
                <input   class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
            
            <div name="ur_text"  field="ur_text" headerAlign="center" allowSort="true" width="60" >公众号详情说明
                <input   class="mini-textbox" style="width:100%;" minWidth="200" />
            </div>
            
        </div>
    </div>
    </div>
	
    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("userDategrid");
        grid.load();
        
        function add() {
        	var data = { action : "new" };
        	mini.open({
				url : "${ctx }/wx/add",
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
        function remove() {   
       	 var row = grid.getSelected();
       	 if(row){
       		//删除之前验证所选记录是否存在
    			if (confirm("确定删除选中记录？")) {
    				//删除
					$.post('${ctx}/wx/delete/' + row.wx_id, function(data) {
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
            	 var data = { action : "edit",wx_id : row.wx_id };
             	mini.open({
     				url : "${ctx }/wx/edit",
     				title : "新增",
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
        function search() { 
        	grid.load({
        		user_id: $("#user_id").val(), 
        		public_name: $("#public_name").val()
        	});
        }
        function reset() {
        	$("#user_id").val("");
        	$("#public_name").val("");
        }
        //////////// /////////////////////////////////////
        var dictMap = new Map();
		function onDict(e) {
			if (e.column.field == 'public_type'){
				return getDict(e, e.column.field, "PUBLIC_TYPE");
			}else if(e.column.field == 'user_type'){
				return getDict(e, e.column.field, "USER_TYPE");
			}
				
		}

    </script>
</body>
</html>