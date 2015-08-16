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



 



<div class="mini-splitter" vertical="true" style="width:100%;height:100%;">
    <div size="20px" showCollapseButton="true">
        <input id="keyword"  class="mini-textbox" emptyText="请输入关键词" style="width:150px;" />
                  <input type="text" id="id"  class="mini-hidden" />
    </div>
    <div showCollapseButton="false">
        



<div style="width:100%;">
    <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                <!--  
                    <a class="mini-button" iconCls="icon-add" onclick="add()">增加多图文</a>
                    <a class="mini-button" iconCls="icon-edit" onclick="edit()">修改多图文</a>
                    <a class="mini-button" iconCls="icon-remove" onclick="remove()">删除多图文</a>
                  -->  
                  
                 
                </td>
                <td style="white-space:nowrap;">
                    <input id="title" class="mini-textbox" emptyText="请输入说明" style="width:150px;" onenter="onKeyEnter"/>
                    <input id="content" class="mini-textbox" emptyText="请输入内容" style="width:150px;" onenter="onKeyEnter"/>
                    <a class="mini-button" onclick="search()">查询</a>
                </td>
            </tr>
        </table>           
    </div>
</div>


<div class="mini-fit" >
<div id="datagrid" class="mini-datagrid" style="width:100%;height:100%;" allowResize="true" url="${ctx}/reply/img/list"  idField="id" multiSelect="true" >
    <div property="columns">
     
        <div type="checkcolumn" ></div> 
        
        
               
        <div field="title" width="120" headerAlign="center" allowSort="true">说明</div>
        <div field="keyword" width="120" headerAlign="center" allowSort="true">关键字</div>
        <div field="content" width="120" headerAlign="center" allowSort="true">内容</div>
        <div field="type" width="120" headerAlign="center" allowSort="true" renderer="onDict">匹配類型</div>
    </div>
</div>
</div>



 <form id="form" method="post">

    <div style="padding-left:11px;padding-bottom:5px;">
	  <!--   <input name="iddd" id="iddd" class="mini-hidden" />--> 
		<table  style="table-layout:fixed;">
			<tr> <td style="text-align:center;padding-top:5px;padding-right:20px;" colspan="6">
	                   <a class="mini-button" onclick="SaveData()" style="width: 60px;">提交</a>&nbsp;&nbsp; 
					   <a class="mini-button" onclick="onCancel" style="width: 60px;">取消</a> 
	             </td>                
	        </tr>
		</table>
	</div>
	</form>


    </div>        
</div>






<script type="text/javascript">
    mini.parse();
    var grid = mini.get("datagrid");
    grid.load();
    
    //由于提交按钮有两个作用，一个是新增，一个是修改，要起不同的作用
    var action="add";
    
    //查询
    function search() {
        var titles = mini.get("title").getValue();
        var contents = mini.get("content").getValue();
        alert(titles);
        grid.load({ title: titles, content: contents });
    }
  
    function SaveData() {
    	var rows = grid.getSelecteds();
        if (rows.length > 0) {
            if (confirm("确定提交选中的图文组合成一个多图文吗？")) {
                var ids = [];
                for (var i = 0, l = rows.length; i < l; i++) {
                    var r = rows[i];
                    ids.push(r.id);
                }
                $.ajax({
                    url: "${ctx}/reply/imgmulti/save" ,
                    data:{ids:ids.toString(),keyword:mini.get("keyword").getValue(),id: mini.get("id").getValue()},
                    success: function (result) {
                    	if(result){
                        	grid.reload();
                        	notify("提交成功");
                        	CloseWindow();
                        }else{
                        	notify("提交失败");
                        }
                    },
                    error: function () {
                    	notify("提交失败");
                    }
                });
            }
        } else {
            alert("请最少选中一条记录");
        }
    }
    
  //标准方法接口定义
	function SetData(data) {
		if (data.action == "edit") {
			action="edit";
			data = mini.clone(data);
			$.ajax({
				url : "${ctx }/reply/imgmulti/getImgMulti/" + data.id,
				cache : false,
				success : function(text) {
					var o = mini.decode(text);
					mini.get("keyword").setValue(o.keyword);
					mini.get("id").setValue(o.id);
					
					var ids = o.imgids.split(","); 
					var rows = grid.findRows(function (row) {
						for(var i = 0 ;i < ids.length; i++ ){
		               	 	if (row.id == ids[i]) {
		               			return true;
		               	 	} 
						}
		            });
		            grid.selects(rows); 
				}
			});
		} 
	}
    
    //数据处理显示
    var dictMap = new Map();
    function onDict(e) {
		if (e.column.field == 'type'){
			return getDict(e, e.column.field, "MATCH_TYPE");
		}else if(e.column.field == 'status'){
			return getDict(e, e.column.field, "STATUS");
		}
	}	
    
    
    
    function CloseWindow() {
		 
		if (window.CloseOwnerWindow)
			return window.CloseOwnerWindow(action);
		else
			window.close();
	}
    
    
</script>

</body>
</html>