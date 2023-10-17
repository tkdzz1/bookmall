package com.himedia.springboot;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface P_mypageDAO {
	P_mypageDTO getmyInfo(String userid);
	int updatemyinfo(String userid, String mobile, String email, String address, String address_detail);
	int updatepw(String userid,String newpw);
	P_pwDTO oldpw(String userid);
}
