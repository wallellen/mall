package com.freelywx.admin.admin.rbac;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.freelywx.common.cache.DictCache;
import com.freelywx.common.model.sys.SysDictDetail;
import com.freelywx.common.util.ComboxModel;

/**
 * 首页控制类
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping("/combox")
public class ComboxController {
	
	@Autowired
	DictCache dictCache;

	@ResponseBody
	@RequestMapping(value = "/dict/{dictId}")
	public List<ComboxModel> combox(@PathVariable String dictId) {
		List<ComboxModel> list = new ArrayList<ComboxModel>();
		List<SysDictDetail> detailList = dictCache.get(dictId);
		if(detailList != null && detailList.size() > 0){
			for (SysDictDetail detail : detailList) {
				ComboxModel comboxModel = new ComboxModel();
				int id = Integer.valueOf(detail.getDict_param_value());
				comboxModel.setId(id);
				comboxModel.setText(detail.getDict_param_name());
				list.add(comboxModel);
			}
		}
		return list;
	}

}
