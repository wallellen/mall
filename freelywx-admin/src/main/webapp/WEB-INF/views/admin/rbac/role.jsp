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
        <span>角色名称：</span><input type="text" id="search_like_roleNm"  />
        <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <span>描述：</span><input type="text" id="search_like_roleDesc"  />
        <input type="button" value="查找" onclick="search()"/>
        <span >&nbsp;</span>
        <input type="button" value="重置" onclick="reset()"/>
    </div>
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="mini-button" iconCls="icon-add" onclick="edit('f_insert')">增加角色</a>
                        <a class="mini-button" iconCls="icon-edit" onclick="edit('f_edit')">修改角色</a>
                        <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除角色</a>       
                        <a class="mini-button" iconCls="icon-resource" onclick="bandResource()">绑定资源</a>       
                    </td>
                </tr>
            </table>           
        </div>
     <div class="mini-fit" >
    <div id="roleDategrid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
        url="${ctx}/admin/role/listAll"  idField="role_id" multiSelect="true" >
        <div property="columns">
        	<div type="indexcolumn"></div>
           <!--  <div type="checkcolumn"></div> -->
            <div field="role_nm" width="120" headerAlign="center" allowSort="true">角色名称</div>    
            <div field="role_desc" width="120" headerAlign="center" allowSort="true">描述</div>    
        </div>
    </div>
   	</div>
    <div id="editWindow" class="mini-window" title="修改" style="width:350px;"  showModal="true" allowResize="true" allowDrag="true" >
	    <div id="editform" class="form" >
	        <input class="mini-hidden" name="role_id" id="role_id"/>
	        <table style="width:100%;">
	            <tr>
	                <td style="width:80px;">角色名：</td>
	                <td style="width:150px;">
	                	<input name="role_nm" class="mini-textbox" onvalidation="onRoleNmValidation"   required="true" />
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">描述：</td>
	                <td style="width:150px;"><input name="role_desc" class="mini-textarea" /></td>
	            </tr>
	            <tr>
	                <td  style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">
	                    <a class="Update_Button" href="javascript:saveRole('f_edit')">确定</a> 
	                    <a class="Cancel_Button" href="javascript:cancel()">取消</a>
	                </td>                
	            </tr>
	        </table>
	    </div>
	</div>
    <div id="addWindow" class="mini-window" title="增加" style="width:350px;"  showModal="true" allowResize="true" allowDrag="true" >
	    <div id="addform" class="form" >
	        <input class="mini-hidden" name="role_id"/>
	        <table style="width:100%;">
	            <tr>
	                <td style="width:80px;">角色名：</td>
	                <td style="width:150px;">
	                	<input name="role_nm" class="mini-textbox" onvalidation="onRoleNmInValidation"   required="true" />
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">描述：</td>
	                <td style="width:150px;"><input name="role_desc" class="mini-textarea" /></td>
	            </tr>
	            <tr>
	                <td  style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">
	                    <a class="Update_Button" href="javascript:saveRole('f_insert')">确定</a> 
	                    <a class="Cancel_Button" href="javascript:cancel()">取消</a>
	                </td>                
	            </tr>
	        </table>
	    </div>
	</div>
	<div id="resourceWindow" class="mini-window" title="资源绑定" style="width:380px;height: 420px;"  showModal="true" allowResize="true" allowDrag="true" >
		<div class="mini-fit" >
		    <ul id="resourceTree" class="mini-tree"  style="width:200px;padding:5px;" 
		        showTreeIcon="true" textField="text" idField="id" parentField="pid" resultAsTree="false"  
		        showCheckBox="true" checkRecursive="true"  allowSelect="false" enableHotTrack="false" expandOnLoad="true">
		    </ul>
		</div>
		 <div  style="text-align:center;padding-top:5px;padding-right:20px;" colspan="6">     
			  <a class="Update_Button mini-button" href="javascript:doBandResource()" >确定</a> 
	          <a class="Update_Button mini-button" href="javascript:cancel()">取消</a>
		</div>
	</div>
	
    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("roleDategrid");
        grid.load();
        grid.sortBy("role_id", "asc");
        var addWindow = mini.get("addWindow");
        var editWindow = mini.get("editWindow");
        var resourceWindow =  mini.get("resourceWindow");
        var resourceTree = mini.get("resourceTree");
        
        function edit(flag) {
        	if("f_insert" == flag ){
        		var form = new mini.Form("#addform");
            	form.reset();
            	addWindow.show();
        	}else if("f_edit" == flag ){
        		var row = grid.getSelected();
                if (row) {
                    editWindow.show();
                    var form = new mini.Form("#editform");
                    form.clear();
                    form.loading();
                    $.ajax({
                        url: '${ctx}/admin/role/' + row.role_id,
                        success: function (text) {
                            form.unmask();
                            var o = mini.decode(text);
                            form.setData(o);
                        },
                        error: function () {
                            alert("表单加载错误");
                            form.unmask();
                        }
                    });
                }else{
               	 alert("请选中一条记录");
                }
        	}
        }
        function search() {
        	var search_like_roleNm = $("#search_like_roleNm").val();
        	var search_like_roleDesc = $("#search_like_roleDesc").val();
        	grid.load({
        		role_nm: search_like_roleNm, 
        		role_desc: search_like_roleDesc
        	});
        }
        function reset() {
        	$("#search_like_roleNm").val("");
        	$("#search_like_roleDesc").val("");
        }
        function cancel() {
            grid.reload();
            editWindow.hide();
            addWindow.hide();
            resourceWindow.hide();
        }
        function remove() {   
        	 var row = grid.getSelected();
        	 if(row){
        		//删除之前验证所选记录是否存在
     			$.post('${ctx}/admin/role/delCheckExits/' + row.role_id,function(checkmsg){
     				if(checkmsg){
     					 if (confirm("确定删除选中记录？")) {
     						$.post('${ctx}/admin/role/roleCheckExits/' + row.role_id,function(rolCheckmsg){
 								if(rolCheckmsg){
 										//删除
 											$.post('${ctx}/admin/role/delete/' + row.role_id, function(data) {
 												if (data) {
 													notify('记录删除成功!');
 													 grid.reload();
 												} else {
 													notify('记录删除失败!');
 												}
 											   });
 								}else{
 									notify('有用户绑定此角色，请先解除绑定关系');
 								}
 							});
     					 }
     				}else{
     					notify('请确认所选记录是否存在');
     				}
     			});
        	 }else {
                 alert("请选中一条记录");
             }
        }
        
        function saveRole(flag) {     
        	 var url = "";
        	 var form;
             if("f_insert" == flag ){
             	url = "${ctx}/admin/role/create";
             	form = new mini.Form("#addform");
             }else if("f_edit" == flag ){
             	url = "${ctx}/admin/role/update";
             	form = new mini.Form("#editform");
             }
            form.validate();
            if (form.isValid() == true) {
            	var o = form.getData();
                grid.loading("保存中，请稍后......");
                var json = mini.encode(o);
                $.ajax({
                    url: url,
                    type:"POST", 
                    dataType:"json",      
                    contentType:'application/json;charset=UTF-8',  
                    data:json, 
                    success: function (text) {
                    	if(text){
                    		 if("f_insert" == flag ){
                    			 notify("添加角色成功");
                    		 }else if("f_edit" == flag ){
                    			 notify("修改成功");
                    		 }
                            grid.reload();
                    	}else{
                    		notify("服务器繁忙，请扫后重试");
                    		grid.reload();
                    	}
                    	
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                       // alert(jqXHR.responseText);
                    	notify("服务器繁忙，请扫后重试");
                    	grid.reload();
                    }
                });  
                editWindow.hide(); 
                addWindow.hide();
            }
        }
        
        function bandResource() {  
        	var row = grid.getSelected();
            if (row) {
            	//funOptTree.loadData(null,'${ctx}/admin/role/allOpt/'+selected.role_id);
            	 $.ajax({
                     url: '${ctx}/admin/role/allOpt/' + row.role_id,
                     dataType:"json",
                     type:"get", 
                     contentType:'application/json;charset=UTF-8',  
                     success: function (text) {
                    	 var myobj=eval(text);   
                    	 resourceTree.loadData(myobj);
                    	 resourceWindow.show(); 
                     },
                     error: function () {
                    	 notify("表单加载错误");
                     }
                 });
            }else{
            	alert("请选择一个用户");
            }
        }
        
        function  doBandResource(){
        	var row = grid.getSelected();
        	var value = resourceTree.getValue(false);
        	if(value.length>0){
				$.post(
						'${ctx}/admin/role/customer_bund/'
								+ row.role_id + "/"
								+ value,
						function(data) {
							if (data) {
								notify('绑定操作成功!');
							} else {
								notify('绑定失败!');
							}
							 grid.reload();
						});
			}else{
				notify('请选择资源!');
			}
        	resourceWindow.hide();
        }
        //////////// /////////////////////////////////////
        
        function onRoleNmValidation(e) {
            if (e.isValid) {
            	var row = grid.getSelected();
            	var roleNm = row.role_nm;
            	if(roleNm != e.value){
            		$.ajax({
                        url: '${ctx}/admin/role/checkRoleNm',
                        async : false, 
                        data:{role_nm:e.value},
                        success: function (text) {
                       	 if(!text){
                       		e.errorText = "该名称已经存在!";
                            e.isValid = false; 
                       	 }
                        },
                        error: function () {
                       	    notify("表单加载错误");
                       	// e.errorText = "密码不能少于5个字符";
                         e.isValid = false;
                        }
                    });
            	}
            	
            }
        }
        function onRoleNmInValidation(e) {
            if (e.isValid) {
            		$.ajax({
                        url: '${ctx}/admin/role/checkRoleNm',
                        async : false, 
                        data:{role_nm:e.value},
                        success: function (text) {
                       	 if(!text){
                       		e.errorText = "该名称已经存在!";
                            e.isValid = false; 
                       	 }
                        },
                        error: function () {
                       	    notify("表单加载错误");
                       	// e.errorText = "密码不能少于5个字符";
                         e.isValid = false;
                        }
                    });
            }
        }
    </script>
</body>
</html>