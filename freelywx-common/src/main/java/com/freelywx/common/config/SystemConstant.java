package com.freelywx.common.config;

public class SystemConstant {
	/** 默认回复类型 **/
	public static class AnswerType {
		/** 默认关注回复 **/
		public static final String ANSWER_ATTENTION = "1";
		/** 未找到关键字默认回复 **/
		public static final String ANSWER_NOKEY = "2";
	}

	/** 是否为关键字 **/
	public static class AttentionIsKey {
		/** 否 **/
		public static final String NO = "1";
		/** 是 **/
		public static final String YES = "2";
	}

	/** 属性类型 **/
	public static class AttrType {
		/** 普通属性 **/
		public static final String COMMON = "1";
		/** SKU属性 **/
		public static final String SKU = "2";
	}

	/** 广告栏目类型 **/
	public static class ColoumType {
		/** 图片广告 **/
		public static final String PIC = "1";
		/** 视频 **/
		public static final String VIDEO = "2";
	}

	/** 字典类型 **/
	public static class DictType {
		/** 系统级 **/
		public static final String SYSTEM = "1";
		/** 业务级 **/
		public static final String BUSINESS = "2";
	}

	/** 启用状态 **/
	public static class EnableState {
		/** 启用 **/
		public static final String ENABLE = "1";
		/** 禁用 **/
		public static final String DISABLE = "2";
	}

	/** 图文分类模板的行业分类 **/
	public static class Industry {
		/** 建筑 **/
		public static final String ARCHITECTURE = "1";
		/** 医院 **/
		public static final String HOSPITAL = "2";
	}

	/** 是否默认 **/
	public static class IsDefault {
		/** 是 **/
		public static final String DEFAULT_YSE = "1";
		/** 否 **/
		public static final String DEFAULT_NO = "2";
	}

	/** 图文模板的标签 **/
	public static class Label {
		/** 标签1 **/
		public static final String LABEL1 = "1";
		/** 标签2 **/
		public static final String LABEL2 = "2";
	}

	/** 关键字匹配类型 **/
	public static class MatchType {
		/** 模糊匹配 **/
		public static final String FUZZY = "1";
		/** 完全匹配 **/
		public static final String COMPLETE = "2";
	}

	/** 会员日志认证类型 **/
	public static class MemberLogType {
		/** 资料同步 **/
		public static final String DATA_SYNC = "1";
		/** 关注公众号 **/
		public static final String ATTENTION_ON = "2";
		/** 取消关注 **/
		public static final String ATTENTION_CANCLE = "3";
	}

	/** 菜单类型 **/
	public static class MenuType {
		/** 点击推事件 **/
		public static final String CLICK = "1";
		/** 外链 **/
		public static final String VIEW = "2";
		/** 扫码推事件 **/
		public static final String SCANCODE_PUSH = "3";
		/** 扫码推事件且弹出“消息接收中”提示框 **/
		public static final String SCANCODE_WAITMSG = "4";
		/** 弹出系统拍照发图 **/
		public static final String PIC_SYSPHOTO = "5";
		/** 弹出系统拍照发图 **/
		public static final String PIC_PHOTO_OR_ALBUM = "6";
		/** 弹出微信相册发图器 **/
		public static final String PIC_WEIXIN = "7";
		/** 弹出地理位置选择器 **/
		public static final String LOCATION_SELECT = "8";
	}

	/** 订单状态 **/
	public static class OrderStatus {
		/** 待支付 **/
		public static final String INIT = "1";
		/** 已支付 **/
		public static final String PAYMENT = "2";
		/** 已发货 **/
		public static final String DELIVER = "3";
		/** 已收货 **/
		public static final String RECEIVED = "4";
		/** 已过期 **/
		public static final String EXPIRED = "5";
		/** 已删除 **/
		public static final String DELETE = "6";
	}

	/** 属性类型 **/
	public static class ProdAttrType {
		/** 静态属性 **/
		public static final String INSTATIC = "1";
		/** 动态属性 **/
		public static final String DYNAMIC = "2";
	}

	/** 商品状态 **/
	public static class ProdShelf {
		/** 未上架 **/
		public static final String DISABLE = "1";
		/** 已上架 **/
		public static final String ENABLE = "2";
	}

	/** 微信号类型 **/
	public static class PublicType {
		/** 订阅号 **/
		public static final String PUBLIC_ORDER = "1";
		/** 服务号 **/
		public static final String PUBLIC_SERVICE = "2";
	}

	/** 返回类型 **/
	public static class ReplyType {
		/** 文本类型 **/
		public static final String REPLY_TEXT = "1";
		/** 图文类型 **/
		public static final String REPLY_GRAPHIC = "2";
		/** 多图文回复 **/
		public static final String REPLY_GRAPHIC_MULTI = "3";
		/** 音乐 **/
		public static final String REPLY_MUSIC = "4";
		/** 录音 **/
		public static final String REPLY_VOICE = "5";
	}

	/** 性别 **/
	public static class Sex {
		/** 男 **/
		public static final String MAN = "1";
		/** 女 **/
		public static final String WOMEN = "2";
	}

	/** 有效无效 **/
	public static class State {
		/** 有效 **/
		public static final String STATE_ENABLE = "1";
		/** 无效 **/
		public static final String STATE_DISABLE = "2";
	}

	/** 用户状态 **/
	public static class UserStatus {
		/** 正常 **/
		public static final String NORMAL = "1";
		/** 冻结 **/
		public static final String FROZEN = "2";
		/** 删除 **/
		public static final String DELETE = "3";
	}

	/** 用户类型 **/
	public static class UserType {
		/** 系统用户 **/
		public static final String SYSTEM_USER = "1";
		/** 微信商户 **/
		public static final String MERCHANT_USER = "2";
	}

	/** 是否 **/
	public static class Yesorno {
		/** 是 **/
		public static final String YES = "1";
		/** 否 **/
		public static final String NO = "2";
	}
}