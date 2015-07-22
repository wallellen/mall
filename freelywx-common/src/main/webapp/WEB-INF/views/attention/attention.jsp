<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
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
	<form id="form" method="post">
		<div>
			<input class="mini-hidden" name="id" /> 
			<input class="mini-hidden"	name="keyword_id" />

			<table style="width: 100%;">

				<tr>
					<td style="width: 80px;">关键词：</td>
					<td style="width: 150px;"><input name="keyword"
						class="mini-textbox" required="true" /></td>


					<td style="width: 80px;">内容 ：</td>
					<td style="width: 150px;"><input name="content"
						class="mini-textbox" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">IS_KEY：</td>
					<td style="width: 150px;"><input name="is_key"
						class="mini-combobox" errorMode="border" required="true"
					textField="text"    url="${ctx}/combox/dict/IS_KEY" /></td>


					<td style="width: 80px;">开始时间 ：</td>
					<td style="width: 150px;"><input name="start_time"
						 class="mini-datepicker" value="2010-10-12" /></td>
				</tr>



				<tr>
					<td style="width: 80px;">结束时间：</td>
					<td style="width: 150px;"><input name="end_time"
						 class="mini-datepicker" value="2010-10-12" /></td>


					<td style="width: 80px;">状态 ：</td>
					<td style="width: 150px;"><input name="status"
						class="mini-combobox" errorMode="border" required="true"
					textField="text"    url="${ctx}/combox/dict/STATE" /></td>
				</tr>
				
				
				
				<tr>
				<td></td>
				<td><a class="mini-button" onclick="SaveData()"
					style="width: 60px;">提交</a>&nbsp;&nbsp; <a class="mini-button"
					onclick="onCancel" style="width: 60px;">取消</a></td>
			</tr>
			
			


			</table>
		</div>
	</form>

	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("form");

		$.ajax({
			url : "${ctx}/attention/list",
			success : function(text) {
				var o = mini.decode(text);
				form.setData(o);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				notify("服务器繁忙，请扫后重试");
			}
		});

		
		
		
		function SaveData() {
			var o = form.getData(true);
			form.validate();
			if (form.isValid() == false)
				return;
			var json = mini.encode(o);
			alert(o.start_time);
			$.ajax({
                url: "${ctx}/attention/save",
                type:"POST", 
                dataType:"json",      
                contentType:'application/json;charset=UTF-8',  
                data:json, 
                success: function (text) {
                	if(text){
                		notify("修改成功");
                	}else{
                		notify("服务器繁忙，请扫后重试");
                	}
                	CloseWindow("save");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	notify("服务器繁忙，请扫后重试");
                }
            });   
		}
		
		
		
		
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if (confirm("数据被修改了，是否先保存？")) {
					return false;
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		} 
		function onCancel(e) {
			CloseWindow("cancel");
		}
		
		
		/*      
		      grid.sortBy("user_id", "asc");
		      function add() {
		      	var data = { action : "new" };
		      	mini.open({
					url : "${ctx }/merchantwx/add",
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
						$.post('${ctx}/merchantwx/delete/' + row.wx_id, function(data) {
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
		   				url : "${ctx }/merchantwx/add",
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
		 */
	</script>
</body>
</html>