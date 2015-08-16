package com.freelywx.common.model.product;

import java.util.Date;
import java.util.List;

import com.rps.util.dao.annotation.ColumnIgnore;
import com.rps.util.dao.annotation.Id;
import com.rps.util.dao.annotation.Table;

@Table("t_p_product")
public class TpProduct {
	/** 产品ID */
	@Id
	private Integer prod_id;

	private Integer site_id;

	/** 分类ID。 */
	private Integer category_id;

	/** 产品编号 */
	private String prod_code;

	/** 产品名称 */
	private String prod_name;

	/** 产地 */
	private String origin;

	/** 商品参考价格 */
	private Integer retail_price;

	/** 销售价格 */
	private Integer sale_price;

	/** 商品描述 */
	private String remark;

	/** 详细描述 */
	private String long_remark;

	private Date active_start_date;

	private Date active_end_date;

	/** 显示模板 */
	private String display_template;

	/** 是否免运费 */
	private String free_shipping;

	/** 运费价格 */
	private Integer freigh_price;

	/** 品牌ID */
	private Integer brand_id;

	/** 是否有配件信息 */
	private String have_accessory;

	private Date shelf_time;

	private Integer shelf_by;

	private Date create_time;

	private Integer create_by;

	/** 最后修改时间 */
	private Date update_time;

	/** 最后一次编辑人 */
	private Integer update_by;

	/** 商品状态。1、上架；0、下架 */
	private String status;

	private Integer sort;

	private String is_return;

	private Integer integral_num;

	/** 积分周期 */
	private String cycle_id;

	private Integer cycle_num;

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

	public Integer getSite_id() {
		return site_id;
	}

	public void setSite_id(Integer site_id) {
		this.site_id = site_id;
	}

	public Integer getCategory_id() {
		return category_id;
	}

	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
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


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getLong_remark() {
		return long_remark;
	}

	public void setLong_remark(String long_remark) {
		this.long_remark = long_remark;
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

	public Date getShelf_time() {
		return shelf_time;
	}

	public void setShelf_time(Date shelf_time) {
		this.shelf_time = shelf_time;
	}

	public Integer getShelf_by() {
		return shelf_by;
	}

	public void setShelf_by(Integer shelf_by) {
		this.shelf_by = shelf_by;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getCreate_by() {
		return create_by;
	}

	public void setCreate_by(Integer create_by) {
		this.create_by = create_by;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public Integer getUpdate_by() {
		return update_by;
	}

	public void setUpdate_by(Integer update_by) {
		this.update_by = update_by;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
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