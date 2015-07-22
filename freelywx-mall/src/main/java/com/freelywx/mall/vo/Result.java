package com.freelywx.mall.vo;

public class Result<T> {
	private String ret_code;
	public T datas;

	public String getRet_code() {
		return ret_code;
	}

	public void setRet_code(String ret_code) {
		this.ret_code = ret_code;
	}

	public T getDatas() {
		return datas;
	}

	public void setDatas(T datas) {
		this.datas = datas;
	}

	public Result() {
		super();
		this.ret_code = "1";
	}
	
	

}
