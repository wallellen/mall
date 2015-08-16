package com.freelywx.common.model.interal;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_integral_cycle_detail")
public class IntegralCycleDetail {
	@Id
	@GenerateByDb
	private Integer id;

	private Integer cycle_id;

	/** 周期可选择的数量。如：1,3,5 表示（对应天） ，可以为1 天，3天和5天 */
	private String content;

	private String desc;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCycle_id() {
		return cycle_id;
	}

	public void setCycle_id(Integer cycle_id) {
		this.cycle_id = cycle_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}
}
