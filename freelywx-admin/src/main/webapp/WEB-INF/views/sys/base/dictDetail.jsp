<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title></title>
<jsp:include page="/meta.jsp" />
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
</style>
</head>
<body>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
				<a class="mini-button" iconCls="icon-add" onclick="edit('f_insert')">增加</a> 
				<a class="mini-button" iconCls="icon-edit" onclick="edit('f_edit')">修改</a>
				<a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
				<a class="mini-button" iconCls="icon-upgrade" onclick="reback()">返回</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="mini-fit">
		<div id="dictDataGrid" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="true"
			url="${ctx}/sys/dictDetail/list?dictId=${dictId}" idField="dict_detail_id" multiSelect="true">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div field="dict_id" width="120" headerAlign="center" allowSort="true">字典编号</div>
				<div field="dict_param_value" width="120" headerAlign="center" allowSort="true">字典参数值</div>
				<div field="dict_param_name" width="240" headerAlign="center" allowSort="true">字典参数名称</div>
				<div field="dict_param_name_en" width="240" headerAlign="center" allowSort="true">字典参数标示</div>
				<div field="dict_param_status" width="120" renderer="onTypeRenderer" headerAlign="center" allowSort="true">字典参数状态</div>
			</div>
		</div>
	</div>
	<div id="addWindow" class="mini-window" title="增加"
		style="width: 320px;" showModal="true" allowResize="true"
		allowDrag="true">
		<div id="addform" class="form">
			<table style="width: 100%;">
				<input class="mini-hidden" name="dict_detail_id">
				<input class="mini-hidden" name="dict_id" value="${dictId}">
				<tr>
					<td style="width: 80px;">字典参数值：</td>
					<td style="width: 200px;">
						<input name="dict_param_value" class="mini-textbox" required="true" />
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">字典参数名称：</td>
					<td style="width: 200px;">
						<input name="dict_param_name" class="mini-textarea" required="true" />
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">字典参数标示：</td>
					<td style="width: 200px;">
						<input name="dict_param_name_en" class="mini-textarea" required="true" />
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">字典参数状态：</td>
					<td style="width: 200px;">
						<input name="dict_param_status"  url="${ctx }/combox/dict/STATE"  class="mini-combobox" required="true" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right; padding-top: 5px; padding-right: 20px;" colspan="6">
						<a class="Update_Button" href="javascript:save('f_insert')">确定</a> 
						<a class="Cancel_Button" href="javascript:cancel()">取消</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="editWindow" class="mini-window" title="修改"
		style="width: 350px;" showModal="true" allowResize="true"
		allowDrag="true">
		<div id="editform" class="form">
			<input class="mini-hidden" name="dict_detail_id">
			<input class="mini-hidden" name="dict_id" >
			<input class="mini-hidden" name="dict_param_value">
			<table style="width: 100%;">
				<tr>
					<td style="width: 80px;">字典参数名称：</td>
					<td style="width: 200px;"><input name="dict_param_name"
						class="mini-textarea" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">字典参数标示：</td>
					<td style="width: 200px;">
						<input name="dict_param_name_en" class="mini-textarea" required="true" />
					</td>
				</tr>
				<tr>
					<td style="width: 80px;">字典参数状态：</td>
					<td style="width: 200px;"><input name="dict_param_status" url="${ctx }/combox/dict/STATE" class="mini-combobox"
						required="true" /></td>
				</tr>
				<tr>
					<td
						style="text-align: right; padding-top: 5px; padding-right: 20px;"
						colspan="6"><a class="Update_Button"
						href="javascript:save('f_edit')">确定</a> <a class="Cancel_Button"
						href="javascript:cancel()">取消</a></td>
				</tr>
			</table>
		</div>
	</div>


	<script type="text/javascript">
		mini.parse();

		var grid = mini.get("dictDataGrid");
		grid.load();
		grid.sortBy("dict_id", "asc");
		var editWindow = mini.get("editWindow");
		var addWindow = mini.get("addWindow");

		function edit(flag) {
			if ("f_insert" == flag) {
				var form = new mini.Form("#addform");
				form.reset();
				addWindow.show();
			} else if ("f_edit" == flag) {
				var row = grid.getSelected();
				if (row) {
					editWindow.show();
					var form = new mini.Form("#editform");
					form.clear();
					form.loading();
					$.ajax({
						url : '${ctx}/sys/dictDetail/' + row.dict_id + "/" + row.dict_param_value + "/" + row.dict_param_name,
						success : function(text) {
							form.unmask();
							var o = mini.decode(text);
							form.setData(o);
						},
						error : function() {
							alert("表单加载错误");
							form.unmask();
						}
					});
				} else {
					alert("请选中一条记录");
				}
			}

		}

		function search() {
			var search_eq_dictId = $("#search_eq_dictId").val();
			var search_like_dictName = $("#search_like_dictName").val();
			var search_eq_dictType = $("#search_eq_dictType").val();
			var search_eq_dictStatus = $("#search_eq_dictStatus").val();
			grid.load({
				dict_id : search_eq_dictId,
				dict_name : search_like_dictName,
				dict_type : search_eq_dictType,
				dict_status : search_eq_dictStatus
			});
		}
		function reset() {
			$("#search_eq_dictId").val("");
			$("#search_like_dictName").val("");
			$("#search_eq_dictType").val("");
			$("#search_eq_dictStatus").val("");
		}
		function cancel() {
			grid.reload();
			addWindow.hide();
			editWindow.hide();
		}
		function remove() {
			var row = grid.getSelected();
			if (row) {
				if (confirm("确定删除字典？")) {
					//删除选中记录
					$.post("${ctx}/sys/dictDetail/delete/" + row.dict_id + "/"
							+ row.dict_param_value, function(result) {
						if (result) {
							notify('删除成功');
							grid.reload();
						} else {
							notify('删除失败');
						}
					});
				}
			} else {
				notify("请选中一条记录");
			}
		}
		function save(flag) {
			var url = "";
			var form;
			if ("f_insert" == flag) {
				form = new mini.Form("#addform");
				url = "${ctx}/sys/dictDetail/create";
			} else if ("f_edit" == flag) {
				form = new mini.Form("#editform");
				url = "${ctx}/sys/dictDetail/update";
			}
			form.validate();
			if (form.isValid() == true) {
				var o = form.getData();
				//optTreeGrid.loading("保存中，请稍后......");
				var json = mini.encode(o);
				$.ajax({
					url : url,
					type : "POST",
					dataType : "json",
					contentType : 'application/json;charset=UTF-8',
					data : json,
					success : function(text) {
						if (text) {
							if ("f_insert" == flag) {
								notify("添加资源成功");
							} else if ("f_edit" == flag) {
								notify("编辑资源成功");
							}
							grid.reload();
						} else {
							notify("服务器繁忙，请扫后重试");
							grid.reload();
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						// alert(jqXHR.responseText);
						notify("服务器繁忙，请扫后重试");
						grid.reload();
					}
				});
				editWindow.hide();
				addWindow.hide();
			}
		}

		function reback() {
			location.href = "${ctx}/sys/dict/";
		}
		//////////// /////////////////////////////////////

		var state = [ {
			dictStatus : 1,
			text : '业务级'
		}, {
			dictStatus : 0,
			text : '系统级'
		} ];
		function onStateRenderer(e) {
			for ( var i = 0, l = state.length; i < l; i++) {
				var g = state[i];
				if (g.dictStatus == e.value)
					return g.text;
			}
			return "";
		}

		var type = [ {
			dictType : 1,
			text : '有效'
		}, {
			dictType : 0,
			text : '无效'
		} ];
		function onTypeRenderer(e) {
			for ( var i = 0, l = type.length; i < l; i++) {
				var g = type[i];
				if (g.dictType == e.value)
					return g.text;
			}
			return "";
		}
		function onNmValidation(e) {
			if (e.isValid) {
				$.ajax({
					url : '${ctx}/sys/dict/check',
					async : false,
					data : {
						dictId : e.value
					},
					success : function(text) {
						if (!text) {
							e.errorText = "该名称已经存在!";
							e.isValid = false;
						}
					},
					error : function() {
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