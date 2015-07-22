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
        <span>用户组名称：</span><input type="text" id="search_like_grpNm"  />
        <input type="button" value="查找" onclick="search()"/>
        <span >&nbsp;</span>
        <input type="button" value="重置" onclick="reset()"/>
    </div>
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="mini-button" iconCls="icon-add" onclick="add()">增加用户组</a>
                        <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改用户组</a>
                        <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除用户组</a>       
                        <!-- <a class="mini-button" iconCls="icon-remove" onclick="getUserInfo()">查看用户</a>      -->  
                        <a class="mini-button" iconCls="icon-users" onclick="bandUserInfo()">绑定用户</a>       
                        <a class="mini-button" iconCls="icon-role" onclick="bandRoleInfo()">绑定角色</a>       
                    </td>
                </tr>
            </table>           
        </div>
    <div class="mini-fit" >
    <div id="userDategrid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true"
        url="${ctx}/admin/userGroup/list"  idField="grp_id" multiSelect="true" >
        <div property="columns">
        	<div type="indexcolumn"></div>
            <!-- <div type="checkcolumn"></div> -->
            <div field="grp_nm" width="120" headerAlign="center" allowSort="true">用户组名称</div>    
            <div field="grp_desc" width="120" headerAlign="center" allowSort="true">用户组描述</div>    
        </div>
    </div>
   	</div>
    <div id="editWindow" class="mini-window" title="修改" style="width:350px;"  showModal="true" allowResize="true" allowDrag="true" >
	    <div id="editform" class="form" >
	        <input class="mini-hidden" name="grp_id"/>
	        <table style="width:100%;">
	            <tr>
	                <td style="width:80px;">用户组名称：</td>
	                <td style="width:150px;">
	                	<input name="grp_nm" class="mini-textbox" onvalidation="onGroupNmValidation"   required="true" />
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">用户组描述：</td>
	                <td style="width:150px;"><input name="grp_desc" class="mini-textarea" /></td>
	            </tr>
	            <tr>
	                <td  style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">
	                    <a class="Update_Button" href="javascript:saveGroup('f_edit')">确定</a> 
	                    <a class="Cancel_Button" href="javascript:cancel()">取消</a>
	                </td>                
	            </tr>
	        </table>
	    </div>
	</div>
    <div id="addWindow" class="mini-window" title="修改" style="width:350px;"  showModal="true" allowResize="true" allowDrag="true" >
	    <div id="addform" class="form" >
	        <input class="mini-hidden" name="grp_id"/>
	        <table style="width:100%;">
	            <tr>
	                <td style="width:80px;">用户组名称：</td>
	                <td style="width:150px;">
	                	<input name="grp_nm" class="mini-textbox" onvalidation="onGroupNmInValidation"   required="true" />
	                </td>
	            </tr>
	            <tr>
	                <td style="width:80px;">用户组描述：</td>
	                <td style="width:150px;"><input name="grp_desc" class="mini-textarea" /></td>
	            </tr>
	            <tr>
	                <td  style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">
	                    <a class="Update_Button" href="javascript:saveGroup('f_insert')">确定</a> 
	                    <a class="Cancel_Button" href="javascript:cancel()">取消</a>
	                </td>                
	            </tr>
	        </table>
	    </div>
	</div>
	<div id="userInfoWindow" class="mini-window" title="绑定用户" width:350px;"  showModal="true" allowResize="true" allowDrag="true" >
		    <div id="userListBox" class="mini-listbox" style="width:240px;height:120px;"    >     
			    <div property="columns">
			        <div header="用户" field="text"></div>
			    </div>
			</div>
	</div>
	<div id="userBandWindow" class="mini-window" title="绑定用户" style="width:460px;height:220px;" showModal="true" allowResize="true" allowDrag="true" >
		    <div id="userBandListBox" class="mini-listbox" style="width:420px;height:140px;"  showCheckBox="true" multiSelect="true" >     
			    <div property="columns">
			        <div header="登录名" field="loginId"></div>
			        <div header="用户名" field="userName"></div>
			    </div>
			</div>
			 <div  style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">     
				  <a class="Update_Button" href="javascript:doBandUserInfo()" >确定</a> 
		          <a class="Cancel_Button" href="javascript:cancel()">取消</a>
			</div>
	</div>
	<div id="roleBandWindow" class="mini-window" title="绑定角色" width:350px;"  showModal="true" allowResize="true" allowDrag="true" >
		    <div id="roleBandListBox" class="mini-listbox" style="width:240px;height:120px;"  showCheckBox="true" multiSelect="true" >     
			    <div property="columns">
			        <div header="角色" field="text"></div>
			    </div>
			</div>
			 <div  style="text-align:right;padding-top:5px;padding-right:20px;" colspan="6">     
				  <a class="Update_Button" href="javascript:doBandRoleInfo()" >确定</a> 
		          <a class="Cancel_Button" href="javascript:cancel()">取消</a>
			</div>
	</div>
    
	
    <script type="text/javascript">
        mini.parse();

        var grid = mini.get("userDategrid");
        grid.load();
        grid.sortBy("grp_id", "asc");
        
        var editWindow = mini.get("editWindow");
        var addWindow = mini.get("addWindow");
        var userBindWindow =  mini.get("userBandWindow");
        var userInfoWindow =  mini.get("userInfoWindow");
        var roleBandWindow =  mini.get("roleBandWindow");
        
        var userListBox = mini.get("userListBox");
        var userBandListBox = mini.get("userBandListBox");
        var roleBandListBox = mini.get("roleBandListBox");
        
        function add() {
        	var form = new mini.Form("#addform");
        	form.reset();
        	addWindow.show();
        }
        function edit() {
        	 var row = grid.getSelected();
             if (row) {
                 editWindow.show();
                 var form = new mini.Form("#editform");
                 form.clear();
                 form.loading();
                 $.ajax({
                     url: '${ctx}/admin/userGroup/' + row.grp_id,
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
        function search() {
        	var search_like_grpNm = $("#search_like_grpNm").val();
        	/* var search_like_userName = $("#search_like_userName").val(); */
        	grid.load({
        		grp_nm: search_like_grpNm
        	});
        }
        
       /*  $("#search_like_loginId","#search_like_userName").keydown(function(){
       		alert("11");
            if (e.keyCode == 13) {
                search();
            }
        }); */
        function reset() {
        	$("#search_like_grpNm").val("");
        }
        function cancel() {
            grid.reload();
            addWindow.hide();
            editWindow.hide();
            userBindWindow.hide();
            userInfoWindow.hide();
            roleBandWindow.hide();
        }
        function remove() {   
	       	 var row = grid.getSelected();
	       	 if(row){
	    		if (confirm("确定删除选中记录？")) {
	    			$.post('${ctx}/admin/userGroup/delete/' + row.grp_id,
							function(data) {
								if (data) {
									notify('记录删除成功!');
									 grid.reload();
								} else {
									notify('删除失败,该组已绑定用户');
								}
					});
	    		}
	       	 }else {
	                alert("请选中一条记录");
	         }
        }
        function getUserInfo(){
        	//userListBox
        	var row = grid.getSelected();
            if (row) {
            	$.post('${ctx}/admin/userGroup/checkExits/' + row.grp_id,
						function(result) {
							if (!result) {
								$.post('${ctx}/admin/userGroup/getUserNameBygrp_id/' + row.grp_id,
										function(result) {
										    var myobj=eval(result); 
											userListBox.loadData(myobj);
											userInfoWindow.show();
								});
							} else {
								notify('该组中没有任何用户');
							}
						});
            	
            }else{
            	alert("请选择一行数据");
            }
        }
        function saveGroup(flag) {            
       	 var url = "";
       	 var form;
            if("f_insert" == flag ){
            	url = "${ctx}/admin/userGroup/create";
            	form = new mini.Form("#addform");
            }else if("f_edit" == flag ){
            	url = "${ctx}/admin/userGroup/update";
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
                   			 notify("增加成功");
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
        
        function bandUserInfo() {  
        	var row = grid.getSelected();
            if (row) {
            	var url = "${ctx}/admin/userGroup/getAllUser/";
            	 $.ajax({
                     url: url + row.grp_id,
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
                    	userBandListBox.loadData(myobj);
                    	userBandListBox.setValue(str);
                        userBindWindow.show(); 
                     },
                     error: function () {
                    	 notify("表单加载错误");
                     }
                 });
            }else{
            	alert("请选择一个用户");
            }
        }
        
        function  doBandUserInfo(){
        	var row = grid.getSelected();
        	var url = "${ctx}/admin/userGroup/insertUesrGroupUser/";
        	var value = userBandListBox.getValue();
        	var param = "userIds="+value;
        	$.ajax({
        		   type: "POST",
        		   url: url + row.grp_id,
        		   data: param,
        		   success: function(data){
        			   userBindWindow.hide(); 
  						roleBandWindow.hide(); 
   						if (data) {
       						notify("保存成功");
       					} else {
       						notify("保存失败");
       					}
        		   }
        		});
        }
        function bandRoleInfo() {  
        	var row = grid.getSelected();
            if (row) {
            	var url  = "${ctx}/admin/userGroup/getAllRole/";
            	 $.ajax({
                     url: url + row.grp_id,
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
                     		roleBandListBox.loadData(myobj);
                     		roleBandListBox.setValue(str);
                     		roleBandWindow.show(); 
                     },
                     error: function () {
                    	 notify("表单加载错误");
                     }
                 });
            }else{
            	alert("请选择一个用户");
            }
        }
        
        function  doBandRoleInfo(){
        	var row = grid.getSelected();
        	var value =roleBandListBox.getValue();
        	var url =  "${ctx}/admin/userGroup/insertUesrGroupRole/";
        	var param = "roleIds="+value;
        	$.ajax({
        		   type: "POST",
        		   url: url + row.grp_id,
        		   data: param,
        		   success: function(data){
        			   userBindWindow.hide(); 
 						roleBandWindow.hide(); 
  						if (data) {
      						notify("保存成功");
      					} else {
      						notify("保存失败");
      					}
        		   }
        		});
        }
        //////////// /////////////////////////////////////
        
        function onGroupNmValidation(e) {
            if (e.isValid) {
            	var row = grid.getSelected();
            	var grpNm = row.grp_nm;
            	if(grpNm != e.value){
            		$.ajax({
                        url: '${ctx}/admin/userGroup/check',
                        async : false, 
                        data:{grpNm:e.value},
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
        function onGroupNmInValidation(e) {
            if (e.isValid) {
            		$.ajax({
                        url: '${ctx}/admin/userGroup/check',
                        async : false, 
                        data:{grp_nm:e.value},
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