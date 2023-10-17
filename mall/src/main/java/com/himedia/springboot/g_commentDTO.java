package com.himedia.springboot;

public class g_commentDTO {
	String userid;
	int b_num;
	int c_num;
	String comment;
	String updated;
	int recommentid;
	
	
	public int getRecommentid() {
		return recommentid;
	}
	public void setRecommentid(int recommentid) {
		this.recommentid = recommentid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getUpdated() {
		return updated;
	}
	public void setUpdated(String updated) {
		this.updated = updated;
	}
}
