package com.freelywx.common.model.visit;

import java.util.Date;

import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_V_SHARE")
public class TVShare {
	@Id
	@GenerateByDb
	private Integer share_id;

	/** 商户ID */
	private Integer merchant_id;

	private Integer member_id;

	/** 分享类型 */
	private String share_type;

	private Date shate_time;

	private Integer prod_id;

	/** 类型.1、普通；2、众筹 */
	private String type;

	/** IP地址 */
	private String ip_address;

	private String url;

	/** 众筹订单ID */
	private Integer order_id;

	private String ext1;

	private String ext2;

	private String ext3;

	private String ext4;

	private String ext5;

	public Integer getShare_id() {
		return share_id;
	}

	public void setShare_id(Integer share_id) {
		this.share_id = share_id;
	}

	public Integer getMerchant_id() {
		return merchant_id;
	}

	public void setMerchant_id(Integer merchant_id) {
		this.merchant_id = merchant_id;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public String getShare_type() {
		return share_type;
	}

	public void setShare_type(String share_type) {
		this.share_type = share_type;
	}

	public Date getShate_time() {
		return shate_time;
	}

	public void setShate_time(Date shate_time) {
		this.shate_time = shate_time;
	}

	public Integer getProd_id() {
		return prod_id;
	}

	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIp_address() {
		return ip_address;
	}

	public void setIp_address(String ip_address) {
		this.ip_address = ip_address;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
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
}
