package com.freelywx.common.model.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.GenerateByDb;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_cus_service")
public class TCusService {
	@Id
	@GenerateByDb
	private Integer service_id;

	private Integer member_id;

	private String title;

	private String description;

	private Date create_time;

	/** 联系电话 */
	private String mobile;

	private String email;

	/** 状态 */
	private String status;

	private Integer order_id;

	private String ext1;

	private String ext2;

	private String ext3;

	private String ext4;

	private String ext5;

	@ColumnIgnore
	private List<TCusProcess> processList;
	@ColumnIgnore
	private List<TCusPic> picList;
	@ColumnIgnore
	private String member_name;

	public Integer getService_id() {
		return service_id;
	}

	public void setService_id(Integer service_id) {
		this.service_id = service_id;
	}

	public Integer getMember_id() {
		return member_id;
	}

	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public List<TCusProcess> getProcessList() {
		return processList;
	}

	public void setProcessList(List<TCusProcess> processList) {
		this.processList = processList;
	}

	public List<TCusPic> getPicList() {
		return picList;
	}

	public void setPicList(List<TCusPic> picList) {
		this.picList = picList;
	}

	public String getMember_name() {
		if (StringUtils.isNotEmpty(member_name)) {
			return new String(Base64.decodeBase64(member_name));
		}
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

}
