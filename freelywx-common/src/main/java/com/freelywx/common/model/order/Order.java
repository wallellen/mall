package com.freelywx.common.model.order;

import java.util.Date;
import java.util.List;

import com.freelywx.common.model.product.TpProduct;
import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_O_ORDER")
public class Order {
	@Id
	@GenerateByDb
	private Integer order_id;

	private String order_type;

	private Integer member_id;

	private Integer pay_member_id;

	private Integer member_level;

	private Integer type_amount;

	private Integer prod_amount;

	private Integer total_prod_price;

	private Integer total_discount_price;

	private Integer total_coupon_price;

	private Integer transit_price;

	/** 实际需要支付总金额 */
	private Integer payment_price;

	/** 已经支付金额 */
	private Integer payed_amount;

	/** 预定金额（众筹已经预定但是没有完成支付的金额） */
	private Integer reserve_amount;

	private String payment_type;

	private String payment_channel;

	private String logistics_id;

	private String shipper;

	/** 工作日（周一至周五），双休（周六、周日），所有时间段 */
	private String payment_delivery;

	private String address;

	private String phone;

	private String mobile;

	private String mobile_confirm;

	private String email;

	private Date create_time;

	private Date payment_time;

	private Date sender_time;

	private Date receiver_time;

	private String invoice_type;

	private String invoice_title;

	private String invoice_content;

	private String order_status;

	private Date last_update_time;

	/** 门店编号 */
	private Integer store_id;

	/** 留言信息 */
	private String message;

	/** 类型（预留） */
	private String type;

	private Integer share_id;

	private String ext1;

	private String ext2;

	private String ext3;

	private String ext4;

	private String ext5;
	
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

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public Integer getPay_member_id() {
		return pay_member_id;
	}

	public void setPay_member_id(Integer pay_member_id) {
		this.pay_member_id = pay_member_id;
	}

	public Integer getMember_level() {
		return member_level;
	}

	public void setMember_level(Integer member_level) {
		this.member_level = member_level;
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

	public Integer getTotal_prod_price() {
		return total_prod_price;
	}

	public void setTotal_prod_price(Integer total_prod_price) {
		this.total_prod_price = total_prod_price;
	}

	public Integer getTotal_discount_price() {
		return total_discount_price;
	}

	public void setTotal_discount_price(Integer total_discount_price) {
		this.total_discount_price = total_discount_price;
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

	public Integer getPayed_amount() {
		return payed_amount;
	}

	public void setPayed_amount(Integer payed_amount) {
		this.payed_amount = payed_amount;
	}

	public Integer getReserve_amount() {
		return reserve_amount;
	}

	public void setReserve_amount(Integer reserve_amount) {
		this.reserve_amount = reserve_amount;
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

	public Date getSender_time() {
		return sender_time;
	}

	public void setSender_time(Date sender_time) {
		this.sender_time = sender_time;
	}

	public Date getReceiver_time() {
		return receiver_time;
	}

	public void setReceiver_time(Date receiver_time) {
		this.receiver_time = receiver_time;
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

	public Date getLast_update_time() {
		return last_update_time;
	}

	public void setLast_update_time(Date last_update_time) {
		this.last_update_time = last_update_time;
	}

	public Integer getStore_id() {
		return store_id;
	}

	public void setStore_id(Integer store_id) {
		this.store_id = store_id;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getShare_id() {
		return share_id;
	}

	public void setShare_id(Integer share_id) {
		this.share_id = share_id;
	}

	public String getExt1() {
		return ext1;
	}

	public void setExt1(String ext1) {
		this.ext1 = ext1;
	}

	public String getExt2() {
		return ext2;
	}

	public void setExt2(String ext2) {
		this.ext2 = ext2;
	}

	public String getExt3() {
		return ext3;
	}

	public void setExt3(String ext3) {
		this.ext3 = ext3;
	}

	public String getExt4() {
		return ext4;
	}

	public void setExt4(String ext4) {
		this.ext4 = ext4;
	}

	public String getExt5() {
		return ext5;
	}

	public void setExt5(String ext5) {
		this.ext5 = ext5;
	}

	public List<TpProduct> getProdList() {
		return prodList;
	}

	public void setProdList(List<TpProduct> prodList) {
		this.prodList = prodList;
	}
	
	
}
