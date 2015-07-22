package com.freelywx.common.model.product;

import java.util.Date;
import java.util.List;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("T_P_PRODUCT")
public class TpProduct {
	@Id
	private Integer prod_id;
	private Integer category_id;
	private Integer site_id;
	private String prod_code;
	private String prod_name;
	private String origin; // 产地
	private String status; // 产地
	private Integer retail_price; // 备注字段，暂时无用
	private Integer sale_price; // 商品价格。在磨微门户显示的价格
	private String description; // 描述
	private String long_description;
	private Date active_start_date;
	private Date active_end_date;
	private String display_template;
	private String free_shipping;
	private Integer freigh_price; // 运费
	private Integer brand_id;
	private String have_accessory;
	private Date create_time;
	private Integer created_by;
	private Date last_update_time;
	private Integer last_updated_by;
	private Integer display_order;
	/** pc描述 */
	private String pc_desc;
	private Integer stock;
	private Integer remain_num;
	/** 二维码 */
	private String qr_code;

	@ColumnIgnore
	private String brandName;
	@ColumnIgnore
	private String categoryName;
	@ColumnIgnore
	private String pic_url;

	@ColumnIgnore
	private String love;

	@ColumnIgnore
	private String favor;

	@ColumnIgnore
	private int loveCount;

	@ColumnIgnore
	private List<TpProductPic> picList;
	@ColumnIgnore
	private String[] colorArray;
	@ColumnIgnore
	private int salesVolume;
	@ColumnIgnore
	private int topicCount;
	@ColumnIgnore
	private TpCategory category;
	public Integer getProd_id() {
		return prod_id;
	}
	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
	public Integer getCategory_id() {
		return category_id;
	}
	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}
	public Integer getSite_id() {
		return site_id;
	}
	public void setSite_id(Integer site_id) {
		this.site_id = site_id;
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
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getRetail_price() {
		return retail_price;
	}
	public void setRetail_price(Integer retail_price) {
		this.retail_price = retail_price;
	}
	public Integer getSale_price() {
		return sale_price;
	}
	public void setSale_price(Integer sale_price) {
		this.sale_price = sale_price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLong_description() {
		return long_description;
	}
	public void setLong_description(String long_description) {
		this.long_description = long_description;
	}
	public Date getActive_start_date() {
		return active_start_date;
	}
	public void setActive_start_date(Date active_start_date) {
		this.active_start_date = active_start_date;
	}
	public Date getActive_end_date() {
		return active_end_date;
	}
	public void setActive_end_date(Date active_end_date) {
		this.active_end_date = active_end_date;
	}
	public String getDisplay_template() {
		return display_template;
	}
	public void setDisplay_template(String display_template) {
		this.display_template = display_template;
	}
	public String getFree_shipping() {
		return free_shipping;
	}
	public void setFree_shipping(String free_shipping) {
		this.free_shipping = free_shipping;
	}
	public Integer getFreigh_price() {
		return freigh_price;
	}
	public void setFreigh_price(Integer freigh_price) {
		this.freigh_price = freigh_price;
	}
	public Integer getBrand_id() {
		return brand_id;
	}
	public void setBrand_id(Integer brand_id) {
		this.brand_id = brand_id;
	}
	public String getHave_accessory() {
		return have_accessory;
	}
	public void setHave_accessory(String have_accessory) {
		this.have_accessory = have_accessory;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Integer getCreated_by() {
		return created_by;
	}
	public void setCreated_by(Integer created_by) {
		this.created_by = created_by;
	}
	public Date getLast_update_time() {
		return last_update_time;
	}
	public void setLast_update_time(Date last_update_time) {
		this.last_update_time = last_update_time;
	}
	public Integer getLast_updated_by() {
		return last_updated_by;
	}
	public void setLast_updated_by(Integer last_updated_by) {
		this.last_updated_by = last_updated_by;
	}
	public Integer getDisplay_order() {
		return display_order;
	}
	public void setDisplay_order(Integer display_order) {
		this.display_order = display_order;
	}
	public String getPc_desc() {
		return pc_desc;
	}
	public void setPc_desc(String pc_desc) {
		this.pc_desc = pc_desc;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public Integer getRemain_num() {
		return remain_num;
	}
	public void setRemain_num(Integer remain_num) {
		this.remain_num = remain_num;
	}
	public String getQr_code() {
		return qr_code;
	}
	public void setQr_code(String qr_code) {
		this.qr_code = qr_code;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getPic_url() {
		return pic_url;
	}
	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
	}
	public String getLove() {
		return love;
	}
	public void setLove(String love) {
		this.love = love;
	}
	public String getFavor() {
		return favor;
	}
	public void setFavor(String favor) {
		this.favor = favor;
	}
	public int getLoveCount() {
		return loveCount;
	}
	public void setLoveCount(int loveCount) {
		this.loveCount = loveCount;
	}
	public List<TpProductPic> getPicList() {
		return picList;
	}
	public void setPicList(List<TpProductPic> picList) {
		this.picList = picList;
	}
	public String[] getColorArray() {
		return colorArray;
	}
	public void setColorArray(String[] colorArray) {
		this.colorArray = colorArray;
	}
	public int getSalesVolume() {
		return salesVolume;
	}
	public void setSalesVolume(int salesVolume) {
		this.salesVolume = salesVolume;
	}
	public int getTopicCount() {
		return topicCount;
	}
	public void setTopicCount(int topicCount) {
		this.topicCount = topicCount;
	}
	public TpCategory getCategory() {
		return category;
	}
	public void setCategory(TpCategory category) {
		this.category = category;
	}


}