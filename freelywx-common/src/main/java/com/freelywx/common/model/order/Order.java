package com.freelywx.common.model.order;

import java.util.Date;
import java.util.List;

import com.freelywx.common.model.product.TpProduct;
import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_o_order")
public class Order {
	@Id
	private Integer order_id;

	private Integer site_id;

	private String order_type;

	private Integer member_id;

	private Integer level;

	/**订购商品的种类数量*/
	private Integer type_amount;

	private Integer prod_amount;

	/**参考总价*/
	private Integer retail_price;

	private Integer amount_price;

	private Integer discount_price;

	/**积分抵用金额*/
	private Integer integral_price;

	private Integer total_coupon_price;

	private Integer transit_price;

	private Integer payment_price;

	private String payment_type;

	private String payment_channel;

	private String logistics_id;

	private String shipper;

	/**工作日（周一至周五），双休（周六、周日），所有时间段*/
	private String payment_delivery;

	private String address;

	private String phone;

	private String mobile;

	private String mobile_confirm;

	private String email;

	private Date create_time;

	private Date payment_time;

	private Date send_time;

	private Date receive_time;

	private String invoice_type;

	private String invoice_title;

	private String invoice_content;

	private String order_status;

	private Date update_time;

	/**是否返还积分*/
	private String is_return;

	/**总返还数量*/
	private Integer integral_num;

	private String cycle_id;

	/**返还周期*/
	private Integer cycle_num;

	/**是否计算返还任务*/
	private String is_computed;
	@ColumnIgnore
	private String nickname;
	
	@ColumnIgnore
	private List<TpProduct> prodList;

	public Integer getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
	}

	public String getOrder_type() {
		return order_type;
	}

	public void setOrder_type(String order_type) {
		this.order_type = order_type;
	}

	public Integer getSite_id() {
		return site_id;
	}

	public void setSite_id(Integer site_id) {
		this.site_id = site_id;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getType_amount() {
		return type_amount;
	}

	public void setType_amount(Integer type_amount) {
		this.type_amount = type_amount;
	}

	public Integer getProd_amount() {
		return prod_amount;
	}

	public void setProd_amount(Integer prod_amount) {
		this.prod_amount = prod_amount;
	}

	public Integer getRetail_price() {
		return retail_price;
	}

	public void setRetail_price(Integer retail_price) {
		this.retail_price = retail_price;
	}

	public Integer getAmount_price() {
		return amount_price;
	}

	public void setAmount_price(Integer amount_price) {
		this.amount_price = amount_price;
	}

	public Integer getDiscount_price() {
		return discount_price;
	}

	public void setDiscount_price(Integer discount_price) {
		this.discount_price = discount_price;
	}

	public Integer getIntegral_price() {
		return integral_price;
	}

	public void setIntegral_price(Integer integral_price) {
		this.integral_price = integral_price;
	}

	public Integer getTotal_coupon_price() {
		return total_coupon_price;
	}

	public void setTotal_coupon_price(Integer total_coupon_price) {
		this.total_coupon_price = total_coupon_price;
	}

	public Integer getTransit_price() {
		return transit_price;
	}

	public void setTransit_price(Integer transit_price) {
		this.transit_price = transit_price;
	}

	public Integer getPayment_price() {
		return payment_price;
	}

	public void setPayment_price(Integer payment_price) {
		this.payment_price = payment_price;
	}

	public String getPayment_type() {
		return payment_type;
	}

	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}

	public String getPayment_channel() {
		return payment_channel;
	}

	public void setPayment_channel(String payment_channel) {
		this.payment_channel = payment_channel;
	}

	public String getLogistics_id() {
		return logistics_id;
	}

	public void setLogistics_id(String logistics_id) {
		this.logistics_id = logistics_id;
	}

	public String getShipper() {
		return shipper;
	}

	public void setShipper(String shipper) {
		this.shipper = shipper;
	}

	public String getPayment_delivery() {
		return payment_delivery;
	}

	public void setPayment_delivery(String payment_delivery) {
		this.payment_delivery = payment_delivery;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getMobile_confirm() {
		return mobile_confirm;
	}

	public void setMobile_confirm(String mobile_confirm) {
		this.mobile_confirm = mobile_confirm;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Date getPayment_time() {
		return payment_time;
	}

	public void setPayment_time(Date payment_time) {
		this.payment_time = payment_time;
	}

	public Date getSend_time() {
		return send_time;
	}

	public void setSend_time(Date send_time) {
		this.send_time = send_time;
	}

	public Date getReceive_time() {
		return receive_time;
	}

	public void setReceive_time(Date receive_time) {
		this.receive_time = receive_time;
	}

	public String getInvoice_type() {
		return invoice_type;
	}

	public void setInvoice_type(String invoice_type) {
		this.invoice_type = invoice_type;
	}

	public String getInvoice_title() {
		return invoice_title;
	}

	public void setInvoice_title(String invoice_title) {
		this.invoice_title = invoice_title;
	}

	public String getInvoice_content() {
		return invoice_content;
	}

	public void setInvoice_content(String invoice_content) {
		this.invoice_content = invoice_content;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public String getIs_return() {
		return is_return;
	}

	public void setIs_return(String is_return) {
		this.is_return = is_return;
	}

	public Integer getIntegral_num() {
		return integral_num;
	}

	public void setIntegral_num(Integer integral_num) {
		this.integral_num = integral_num;
	}

	public String getCycle_id() {
		return cycle_id;
	}

	public void setCycle_id(String cycle_id) {
		this.cycle_id = cycle_id;
	}

	public Integer getCycle_num() {
		return cycle_num;
	}

	public void setCycle_num(Integer cycle_num) {
		this.cycle_num = cycle_num;
	}

	public String getIs_computed() {
		return is_computed;
	}

	public void setIs_computed(String is_computed) {
		this.is_computed = is_computed;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public List<TpProduct> getProdList() {
		return prodList;
	}

	public void setProdList(List<TpProduct> prodList) {
		this.prodList = prodList;
	}

	
}
