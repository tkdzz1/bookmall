package com.himedia.springboot;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface P_addbookDAO {
	// 이미지추가
	void addbook(String name, int price, String savedMainName, String genre, String author, String savedSubName,String info, int stock, String editorreview);
}
