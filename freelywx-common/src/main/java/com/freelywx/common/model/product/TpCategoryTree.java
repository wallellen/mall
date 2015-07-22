package com.freelywx.common.model.product;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_CATEGORY_TREE")
public class TpCategoryTree {
	@GenerateByDb
	@Id
	private Integer category_tree_id;
	private Integer category_id;
	private Integer child_category_id;

	public Integer getCategory_tree_id() {
		return category_tree_id;
	}

	public void setCategory_tree_id(Integer category_tree_id) {
		this.category_tree_id = category_tree_id;
	}

	public Integer getCategory_id() {
		return category_id;
	}

	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}

	public Integer getChild_category_id() {
		return child_category_id;
	}

	public void setChild_category_id(Integer child_category_id) {
		this.child_category_id = child_category_id;
	}

}
