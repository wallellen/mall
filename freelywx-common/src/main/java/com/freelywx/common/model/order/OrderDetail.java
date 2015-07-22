package com.freelywx.common.model.order;

import java.util.List;
import java.util.Map;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_O_ORDER_DETAIL")
public class OrderDetail {
	@Id
	@GenerateByDb
	private Integer detail_id;

	private Integer order_id;
	private Integer prod_id;
	private String prod_code;
	private String prod_name;
	private Integer prod_amount;
	private Integer prod_price;
	private Integer prod_discount_price;
	private Integer prod_transit_price;
	private String prod_img_url;
	@ColumnIgnore
	private List<OrderDetailAttr> detailAttr;
	@ColumnIgnore
	private List<Map<String, String>> attrList;

	public Integer getDetail_id() {
		return detail_id;
	}

	public void setDetail_id(Integer detail_id) {
		this.detail_id = detail_id;
	}

	public Integer getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}

	public String getProd_code() {
		return prod_code;
	}

	public void setProd_code(String prod_code) {
		this.prod_code = prod_code;
	}

	public String getProd_name() {
		return prod_name;
	}

	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}

	public Integer getProd_amount() {
		return prod_amount;
	}

	public void setProd_amount(Integer prod_amount) {
		this.prod_amount = prod_amount;
	}

	public Integer getProd_price() {
		return prod_price;
	}

	public void setProd_price(Integer prod_price) {
		this.prod_price = prod_price;
	}

	public Integer getProd_discount_price() {
		return prod_discount_price;
	}

	public void setProd_discount_price(Integer prod_discount_price) {
		this.prod_discount_price = prod_discount_price;
	}

	public Integer getProd_transit_price() {
		return prod_transit_price;
	}

	public void setProd_transit_price(Integer prod_transit_price) {
		this.prod_transit_price = prod_transit_price;
	}

	public String getProd_img_url() {
		return prod_img_url;
	}

	public void setProd_img_url(String prod_img_url) {
		this.prod_img_url = prod_img_url;
	}

	public List<OrderDetailAttr> getDetailAttr() {
		return detailAttr;
	}

	public void setDetailAttr(List<OrderDetailAttr> detailAttr) {
		this.detailAttr = detailAttr;
	}

	public List<Map<String, String>> getAttrList() {
		return attrList;
	}

	public void setAttrList(List<Map<String, String>> attrList) {
		this.attrList = attrList;
	}

}