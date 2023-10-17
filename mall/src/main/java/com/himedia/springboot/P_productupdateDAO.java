package com.himedia.springboot;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface P_productupdateDAO {
	void productupdateMimg(int seqno,String savedMainName);
	void productupdateSimg(int seqno,String savedSubName);
	void productupdate(int seqno, String name, String genre, String author, int price, String info, int stock,String editorreview);
	
}
