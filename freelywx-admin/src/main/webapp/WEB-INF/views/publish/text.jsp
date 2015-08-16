<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<jsp:include page="/meta.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>文本回复管理</title>
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
<div style="width:100%;">
    <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="mini-button" iconCls="icon-add" onclick="add()">增加</a>
                    <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改</a>
                    <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除</a>
                </td>
                <td style="white-space:nowrap;">
                    <input id="keyword" class="mini-textbox" emptyText="请输入关键字" style="width:150px;" onenter="onKeyEnter"/>
                    <input id="content" class="mini-textbox" emptyText="请输入内容" style="width:150px;" onenter="onKeyEnter"/>
                    <a class="mini-button" onclick="search()">查询</a>
                </td>
            </tr>
        </table>           
    </div>
</div>
<div class="mini-fit" >
<div id="datagrid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true" url="${ctx}/reply/text/list"  idField="id" multiSelect="true" >
    <div property="columns">
        <div type="checkcolumn" ></div>        
        <!-- <div field="id" width="120" headerAlign="center" allowSort="true">编号</div> -->
        <!--  <div field="title" width="120" headerAlign="center" allowSort="true">说明</div>-->
        <div field="keyword" width="120" headerAlign="center" allowSort="true">关键字</div>
         <div field="content" width="120" headerAlign="center" allowSort="true">内容</div>
        <div field="type" width="120" headerAlign="center" allowSort="true" renderer="onMatchType"   >匹配類型</div>
        
    </div>
</div>





</div>

<script type="text/javascript">
    mini.parse();
    
    var grid = mini.get("datagrid");
    grid.load();

    function add() {
   	 	var data = { action : "new"};
   	 	mini.open({
			url : "${ctx }/reply/text/edit",
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
       	 var data = { action : "edit" ,id : row.id };
        	mini.open({
				url : "${ctx }/reply/text/edit",
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
   
    
    function remove() {
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
            if (confirm("确定删除选中记录？")) {
                var ids = [];
                for (var i = 0, l = rows.length; i < l; i++) {
                    var r = rows[i];
                    ids.push(r.id);
                }
                $.ajax({
                    url: "${ctx}/reply/text/delete/" +ids,
                    success: function (result) {
                    	if(result){
                        	grid.reload();
                        	notify("删除成功");
                        }else{
                        	notify("删除失败");
                        }
                    },
                    error: function () {
                    	notify("删除失败");
                    }
                });
            }
        } else {
            alert("请最少选中一条记录");
        }
    }
    
    
    //查询
    function search() {
        var keyword = mini.get("keyword").getValue();
        var content = mini.get("content").getValue();
        grid.load({ keyword: keyword, content: content });
    }
    function onKeyEnter(e) {
        search();
    }
    
    
    
    //数据处理显示
    var dictMap = new Map();
    function onDict(e) {
		if (e.column.field == 'type'){
			return getDict(e, e.column.field, "TYPE");
		}else if(e.column.field == 'status'){
			return getDict(e, e.column.field, "STATUS");
		}
	}	
    
    
    
    var match_type = [{ id: 1, text: '模糊匹配' }, { id: 2, text: '完全匹配'}];
    function onMatchType(e) {
        for (var i = 0, l = match_type.length; i < l; i++) {
            var g = match_type[i];
            if (g.id == e.value) return g.text;
        }
        return "";
    }
	
    
    
</script>

</body>
</html>