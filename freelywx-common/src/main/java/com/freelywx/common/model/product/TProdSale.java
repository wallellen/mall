//package com.freelywx.common.model.product;
//
//import com.rps.util.dao.annotation.ColumnIgnore;
//import com.rps.util.dao.annotation.GenerateByDb;
//import com.rps.util.dao.annotation.Id;
//import com.rps.util.dao.annotation.Table;
//
//@Table("T_PROD_SALE")
//public class TProdSale {
//	/** 商品编号 */
//	@Id
//	@GenerateByDb
//	private Integer prod_id;
//
//	/** 商品名称 */
//	private String prod_name;
//
//	private String prod_addr;
//
//	private Integer prod_order;
//
//	private String prod_status;
//
//	private Integer commend_cnt;
//
//	/** 商品描述 */
//	private String prod_desc;
//
//	/** 市场价：分 */
//	private Integer mark_price;
//
//	@ColumnIgnore
//	/**评论数*/
//	private Integer comment_cnt;
//
//	@ColumnIgnore
//	/**原始商品ID(所属关联表T_P_PRODUCT)*/
//	private Integer origin_id;
//
//	@ColumnIgnore
//	/**该商品当前用户是否喜欢(0、喜欢 1、不喜欢)*/
//	private String love;
//
//	@ColumnIgnore
//	/**该商品当前用户是否收藏(0、收藏 1、未收藏)*/
//	private String favor;
//
//	@ColumnIgnore
//	/**该商品被喜欢的总数*/
//	private int loveCount;
//
//	@ColumnIgnore
//	private TpProduct tpProduct;
//
//	@ColumnIgnore
//	private int salesVolume; // 销量
//
//	public int getSalesVolume() {
//		return salesVolume;
//	}
//
//	public void setSalesVolume(int salesVolume) {
//		this.salesVolume = salesVolume;
//	}
//
//	public String getFavor() {
//		return favor;
//	}
//
//	public void setFavor(String favor) {
//		this.favor = favor;
//	}
//
//	public TpProduct getTpProduct() {
//		return tpProduct;
//	}
//
//	public void setTpProduct(TpProduct tpProduct) {
//		this.tpProduct = tpProduct;
//	}
//
//	public Integer getOrigin_id() {
//		return origin_id;
//	}
//
//	public void setOrigin_id(Integer origin_id) {
//		this.origin_id = origin_id;
//	}
//
//	public String getLove() {
//		return love;
//	}
//
//	public void setLove(String love) {
//		this.love = love;
//	}
//
//	public int getLoveCount() {
//		return loveCount;
//	}
//
//	public void setLoveCount(int loveCount) {
//		this.loveCount = loveCount;
//	}
//
//	public Integer getProd_id() {
//		return prod_id;
//	}
//
//	public void setProd_id(Integer prod_id) {
//		this.prod_id = prod_id;
//	}
//
//	public String getProd_name() {
//		return prod_name;
//	}
//
//	public void setProd_name(String prod_name) {
//		this.prod_name = prod_name;
//	}
//
//	public String getProd_desc() {
//		return prod_desc;
//	}
//
//	public void setProd_desc(String prod_desc) {
//		this.prod_desc = prod_desc;
//	}
//
//	public Integer getMark_price() {
//		return mark_price;
//	}
//
//	public void setMark_price(Integer mark_price) {
//		this.mark_price = mark_price;
//	}
//
//	public String getProd_addr() {
//		return prod_addr;
//	}
//
//	public void setProd_addr(String prod_addr) {
//		this.prod_addr = prod_addr;
//	}
//
//	public String getProd_status() {
//		return prod_status;
//	}
//
//	public void setProd_status(String prod_status) {
//		this.prod_status = prod_status;
//	}
//
//	public Integer getProd_order() {
//		return prod_order;
//	}
//
//	public void setProd_order(Integer prod_order) {
//		this.prod_order = prod_order;
//	}
//
//	public Integer getCommend_cnt() {
//		return commend_cnt;
//	}
//
//	public void setCommend_cnt(Integer commend_cnt) {
//		this.commend_cnt = commend_cnt;
//	}
//
//	public Integer getComment_cnt() {
//		return comment_cnt;
//	}
//
//	public void setComment_cnt(Integer comment_cnt) {
//		this.comment_cnt = comment_cnt;
//	}
//
//}
