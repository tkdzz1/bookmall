package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;



@Mapper
public interface mallDAO {
	void insert(String userid, String passcode, String username, String gender, String birthday, String mobile, String email, String address, String address_detail);
	int select(String userid, String passcode);
	ArrayList<mallDTO> getNovel(int start, int psize);
	ArrayList<mallDTO> getAll(int start, int psize);
	ArrayList<mallDTO> getHistory(int start, int psize);
	int getTotal();
	int getnovelTotal();
	int gethistoryTotal();
	mallDTO bselect(int seq);
	mallDTO orders(int seq);
	void paymentinsert(String userid, int prodid, String mobile, String mobile2, int qty, int sum, String email, String address, String address_detail);
	void addbookinsert(String name, String price, String genre, String img, String author, String prodinfo);
	void hitup(int seqno);
	ArrayList<mallDTO> selectCart(String userid);
	int addcart(String userid, int seq);
	int count(String userid);
	int totalsum();
	ArrayList<mallDTO> dosearch(String name, int start, int psize);
	int countcart(String userid);
	void deletecart(String userid, int prodid);
	Integer admin(String userid, String passcode);
	void cntcart(String userid);
	ArrayList<mallDTO> getConomy(int start, int psize);
	ArrayList<mallDTO> getPolitics(int start, int psize);
	ArrayList<mallDTO> getComic(int start, int psize);
	void deletetb(int seqno);
	ArrayList<mallDTO> getlist();
	ArrayList<mallDTO> popular(int start, int psize, String genre);
	ArrayList<mallDTO> sales(int start, int psize, String genre);
	ArrayList<mallDTO> newest(int start, int psize, String genre);
	ArrayList<mallDTO> highprice(int start, int psize, String genre);
	ArrayList<mallDTO> lowprice(int start, int psize, String genre);
	void stock(int prodid, int qty);
	ArrayList<mallDTO> getOrderList(String userid, int start, int psize);
	int ordercnt(String userid);
	void mileage(String userid, int mileage);
	Integer getMileage(String userid);
	void usemileage(String userid, int usemileage);
	void addReview(int seq, String comment, String comment2, int score);
	ArrayList<reviewDTO> getreview(int seqno);
	void deletereview(int seq);
	void reviewupdate(String comment, int editNO, int prodid);
	int getpoliticsTotal();
	int geteconomyTotal();
	int getcomicTotal();
	ArrayList<mallDTO> getBestSeller(int start, int psize);
	int getBestSellerTotal();
	int getsearchTotal();
	void deleteallcart(String userid, Integer value);
	int idchk(String id);
	P_findidDTO findid(String email, String name, String birthday);
	P_findidDTO findpw(String email, String id, String name,String birthday);
	memberDTO getmember(String userid);
	orderDTO findorder(int orderId);
	ArrayList<mallDTO> getBookHit();
	ArrayList<mallDTO> getBookBestSeller();
	ArrayList<mallDTO> getBookNew();
	ArrayList<mallDTO> selectid();
	ArrayList<mallDTO> popular2(int start, int psize);
	ArrayList<mallDTO> sales2(int start, int psize);
	ArrayList<mallDTO> newest2(int start, int psize);
	ArrayList<mallDTO> highprice2(int start, int psize);
	ArrayList<mallDTO> lowprice2(int start, int psize);
}
