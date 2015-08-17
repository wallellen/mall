package com.freelywx.common.model.order;

import java.util.List;
import java.util.Map;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_o_order_detail")
public class OrderDetail {
	@Id
	@GenerateByDb
	private Integer detail_id;

	private Integer order_id;

	private Integer prod_id;

	private String prod_code;

	private String prod_name;
	
	private Integer amount;			//数量

	private Integer price;			//单价

	private Integer discount_price;

	private Integer transit_price;

	private Integer pay_price;

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

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Integer getDiscount_price() {
		return discount_price;
	}

	public void setDiscount_price(Integer discount_price) {
		this.discount_price = discount_price;
	}

	public Integer getTransit_price() {
		return transit_price;
	}

	public void setTransit_price(Integer transit_price) {
		this.transit_price = transit_price;
	}

	public Integer getPay_price() {
		return pay_price;
	}

	public void setPay_price(Integer pay_price) {
		this.pay_price = pay_price;
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