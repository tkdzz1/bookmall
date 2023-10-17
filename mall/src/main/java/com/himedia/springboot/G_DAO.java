package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface G_DAO {
	ArrayList<g_boardDTO> g_getBoard(int start, int psize);
	int g_getTotal();
	void boardInsert(String title,String userid,String content,String imgName);
	g_boardDTO findBoard(int boardNum);
	void g_delete(int boardNum);
	void boardUpdate(int boardNum,String title,String content, String imgName);
	void g_hitup(int boardNum);
	ArrayList<g_commentDTO> findComment(int boardNum, int start, int psize);
	void insertComment(String userid, int boardNum, String commentBox);
	void g_commentDelete(int c_num);
	ArrayList<g_faqDTO> g_getFAQ();
	void g_updateFAQ(int num, String title, String content);
	void g_insertFAQ(String title, String content);
	void g_deleteFAQ(int num);
	ArrayList<g_questionDTO> g_getQuestion(int start,int psize);
	ArrayList<g_questionDTO> g_getQuestionClient(String userid, int start, int psize);
	g_questionDTO g_reply(int num);
	void g_insertAnswer(int num, String answer);
	void g_insertQuestion(String userid, String title, String content, int visibility);
	int g_getCommentTotal(int boardNum);
	int g_getQnaTotal();
	int g_getQnaTotalClient(String userid);
	int insertrecomment(String userid, int b_id, String recomment, int r_id);
	ArrayList<g_commentDTO> recomment(int r_id);
}