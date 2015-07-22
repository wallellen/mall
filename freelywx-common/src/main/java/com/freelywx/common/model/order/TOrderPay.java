package com.freelywx.common.model.order;

import java.util.Date;

import com.freelywx.common.model.member.Member;
import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_O_ORDER_PAY")
public class TOrderPay {
	@Id
	@GenerateByDb
	private Integer id;

	/** 订单id */
	private Integer order_id;

	/** 会员ID */
	private Integer member_id;

	private String member_w_id;

	private String member_name;

	/** 支付金额 */
	private Integer pay_amount;

	/** 支付时间 */
	private Date pay_time;

	/** 支付完成时间 */
	private Date completa_time;

	/** 支付状态。待支付；支付成功；支付失败;取消支付； */
	private String status;

	/** 留言 */
	private String message;

	private String ext;

	private String ext1;

	private String ext2;

	private String ext3;

	private String ext4;

	@ColumnIgnore
	private String member_img;

	@ColumnIgnore
	private Member member;

	@ColumnIgnore
	private Order order;

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getMember_img() {
		return member_img;
	}

	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public String getMember_w_id() {
		return member_w_id;
	}

	public void setMember_w_id(String member_w_id) {
		this.member_w_id = member_w_id;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public Integer getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(Integer pay_amount) {
		this.pay_amount = pay_amount;
	}

	public Date getPay_time() {
		return pay_time;
	}

	public void setPay_time(Date pay_time) {
		this.pay_time = pay_time;
	}

	public Date getCompleta_time() {
		return completa_time;
	}

	public void setCompleta_time(Date completa_time) {
		this.completa_time = completa_time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getExt() {
		return ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
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
}
