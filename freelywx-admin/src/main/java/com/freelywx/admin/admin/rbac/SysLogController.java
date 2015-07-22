package com.freelywx.admin.admin.rbac;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.model.user.TpSysLog;
import com.freelywx.common.util.Collections3;
import com.freelywx.common.util.Excels;
import com.freelywx.common.util.PageModel;
import com.freelywx.common.util.PageUtil;
import com.google.common.collect.ImmutableMap;
import com.rps.util.D;

/**
 * 系统日志控制器类
 * 方法上的注释为页面中Button的标题
 */
@Controller
@RequestMapping(value = "/admin/sysLog")
public class SysLogController {
	@RequestMapping()
	public String init() {
		return "admin/rbac/sysLog";
	}

	/*
	 * 显示-日志列表
	 */
	@ResponseBody
	@RequestMapping(value = "list")
	public PageModel list(HttpServletRequest request) {
		return PageUtil.getPageModel(TpSysLog.class, "sql.tpLog/getPageLog",request);
	}
	/*
	 * 清空日志-将日志全部删除
	 */
	@ResponseBody
	@RequestMapping(value = "delete")
	public boolean delete() {
		int count = D.sql("delete from T_P_SYS_LOG").update();
		if(count > 0) {
			return true;
		} else {
			return false;
		}
	}
	/*
	 * 导出日志
	 */
	@ResponseBody
	@RequestMapping(value = "exportSysLog")
	public boolean exportSysLog(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		//获取页面列表中显示的数据
		List<TpSysLog> logList = (List<TpSysLog>) PageUtil.getPageModel(TpSysLog.class, "sql.tpLog/getPageLog",request).getData();
		
		if(!Collections3.isEmpty(logList)) {
			//将数据传到Excels类中并以ImmutableMap.of()中的格式进行处理
			byte[] excelContent = Excels.exportExcel("系统日志列表", ImmutableMap.of(
					"user_id", "操作者", 
					"oper_time", "操作时间", 
					"url", "功能地址",
					"param", "参数"), logList,
					"yyyy/mm/dd hh:mm:ss");
			
			//设置文档标编码、类型、和格式后从网络中导出
			String fileName = "系统日志列表";
			if (request.getHeader("User-Agent").toUpperCase().contains("MSIE")) {
				fileName = URLEncoder.encode(fileName, "UTF-8");
			} else {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
			}
			response.setHeader("Content-Disposition", "attachment;filename="
					+ fileName + ".xls");
			response.setContentType("application/vnd.ms-excel");
			response.getOutputStream().write(excelContent);
			
			return true;
		} else {
			return false;
		}
	}
}
