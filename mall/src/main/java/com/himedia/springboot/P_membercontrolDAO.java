package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface P_membercontrolDAO {
	ArrayList<P_membercontrolDTO> getmemberlist();
	void memberdelete(String userid);
}