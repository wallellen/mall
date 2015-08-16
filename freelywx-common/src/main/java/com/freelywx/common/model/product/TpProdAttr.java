package com.freelywx.common.model.product;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_p_prod_attr")
public class TpProdAttr {

	/** 主键 */
	@Id
	@GenerateByDb
	private Integer id;

	/** 商品ID */
	private Integer prod_id;

	/** 属性ID */
	private Integer attr_id;

	/** 属性值 */
	private String attr_value;

	/** 未使用 */
	private String res_id;

	/** 未使用 */
	private String res_value;

	/** 1静态属性；2动态属性 */
	private String attr_type;

	/** 排序 */
	private Integer sort;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}

	public Integer getAttr_id() {
		return attr_id;
	}

	public void setAttr_id(Integer attr_id) {
		this.attr_id = attr_id;
	}

	public String getAttr_value() {
		return attr_value;
	}

	public void setAttr_value(String attr_value) {
		this.attr_value = attr_value;
	}

	public String getRes_id() {
		return res_id;
	}

	public void setRes_id(String res_id) {
		this.res_id = res_id;
	}

	public String getRes_value() {
		return res_value;
	}

	public void setRes_value(String res_value) {
		this.res_value = res_value;
	}

	public String getAttr_type() {
		return attr_type;
	}

	public void setAttr_type(String attr_type) {
		this.attr_type = attr_type;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

}