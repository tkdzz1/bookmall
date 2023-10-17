package com.himedia.springboot;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class G_Controller {
	@Autowired
	private G_DAO g_dao;
	@Autowired
	private mallDAO mdao;
	
	@GetMapping("/korBook/g_board")
	public String g_board(HttpServletRequest req, Model model) {
		ArrayList<mallDTO> random = mdao.selectid();
		model.addAttribute("random",random);
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		
		int start,psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";
		}
		int pno = Integer.parseInt(page);
		start = (pno-1)*10;
		psize=10;
		ArrayList<g_boardDTO> g_alboard = g_dao.g_getBoard(start,psize);
		
		int cnt=g_dao.g_getTotal();
		int pagecount = (int) Math.ceil(cnt/10.0);
		
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr += i+"&nbsp;";
			}else {
				pagestr+="<a href='/korBook/g_board?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		JSONArray ja = new JSONArray();
		for(int i=0; i<g_alboard.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("num",g_alboard.get(i).num);
			jo.put("userid",g_alboard.get(i).userid);
			jo.put("seq",g_alboard.get(i).seq);
			jo.put("title",g_alboard.get(i).title);
			jo.put("content",g_alboard.get(i).content);
			jo.put("hit",g_alboard.get(i).hit);
			jo.put("created",g_alboard.get(i).created);
			jo.put("updated",g_alboard.get(i).updated);
			ja.add(jo);
		}
		ja.toJSONString();
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		model.addAttribute("getBoard",ja);
		return "korBook/g_board";
	}
	@GetMapping("/g_write")
	public String g_write(HttpServletRequest req, Model model) {
		ArrayList<mallDTO> random = mdao.selectid();
		model.addAttribute("random",random);
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "korBook/g_write";
	}
	@Value("${upload.directory}")
    private String uploadDirectory;
	@PostMapping("/boardInsert")
	public String boardInsert(HttpServletRequest req, @RequestParam("image1") MultipartFile image1) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
		Date date = new Date();
		String formattedDate = sdf.format(date);
		String imgName = image1.getOriginalFilename();
		String fileExtension = StringUtils.getFilenameExtension(imgName); //오리지널(imgName) 파일명에서 확장자 추출 
        if (!image1.isEmpty()) {
        	try { 
        		UUID uuid = UUID.randomUUID();
        		imgName = uuid.toString()+formattedDate+"."+fileExtension;
        		System.out.println(imgName);
        		File targetFile = new File(uploadDirectory + File.separator + imgName);
        		image1.transferTo(targetFile);
        	}catch(IOException e) {

        		e.printStackTrace();
        	}
        }
		String title = req.getParameter("title");
	  	String userid = req.getParameter("author");
	  	String content = req.getParameter("content"); 
	  	g_dao.boardInsert(title,userid,content,imgName);
	  	return "redirect:korBook/g_board"; 
	}
	  
	 
	  @GetMapping("/g_view")
	  public String g_view(HttpServletRequest req, Model model) {
		ArrayList<mallDTO> random = mdao.selectid();
		model.addAttribute("random",random);
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		
		// 9/4일 댓글 페이지버튼 추가
		int start,psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";
		}
		int pno = Integer.parseInt(page);
		start = (pno-1)*10;
		psize=10;
		
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		
		int cnt=g_dao.g_getCommentTotal(boardNum);
		int pagecount = (int) Math.ceil(cnt/10.0);
		
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr += i+"&nbsp;";
			}else {
				pagestr+="<a href='/g_view?boardNum="+boardNum+"&pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		
		g_boardDTO gdto = g_dao.findBoard(boardNum);
		g_dao.g_hitup(boardNum);
		model.addAttribute("findingBoard",gdto);
		ArrayList<g_commentDTO> commentdto = g_dao.findComment(boardNum,start,psize);
		JSONArray ja = new JSONArray();
		for(int i=0; i<commentdto.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("userid",commentdto.get(i).userid);
			jo.put("b_num",commentdto.get(i).b_num);
			jo.put("c_num",commentdto.get(i).c_num);
			jo.put("comment",commentdto.get(i).comment);
			jo.put("updated",commentdto.get(i).updated);
			ja.add(jo);
		}
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		ja.toJSONString();
		model.addAttribute("findingComment",ja);
		return "korBook/g_view";
	}
	@GetMapping("/g_delete")
	public String delete(HttpServletRequest req) {
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		g_dao.g_delete(boardNum);
		return "redirect:/korBook/g_board";
	}
	@GetMapping("/g_update")
	public String update(HttpServletRequest req, Model model) {
		ArrayList<mallDTO> random = mdao.selectid();
		model.addAttribute("random",random);
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		g_boardDTO gdto = g_dao.findBoard(boardNum);
		model.addAttribute("findingBoard",gdto);
		
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "/korBook/g_update";
	}
	@PostMapping("/boardUpdate")
	public String boardUpdate(HttpServletRequest req, @RequestParam("image1") MultipartFile image1) {
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String ogFileName = req.getParameter("ogFileName"); // 원래 업로드됐던 이미지 파일 이름
		String imgName = image1.getOriginalFilename();		// 새로 업로드한 이미지 파일 이름
		String ofnHidden = req.getParameter("ofnHidden");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
		Date date = new Date();
		String formattedDate = sdf.format(date);
		String fileExtension = StringUtils.getFilenameExtension(imgName); //오리지널(imgName) 파일명에서 확장자 추출 
		
		String boardDirectory = uploadDirectory;
		UUID uuid = UUID.randomUUID();							//수정할 이미지이름에 랜덤값을 추가하기위해 생성
		File ogImageFile = new File(boardDirectory + File.separator + ofnHidden); //원래 업로드됐던 이미지 삭제를 위해 생성
		System.out.println("ogImageFile out:"+ogImageFile);
		if(!imgName.equals("")) {
			// 여기서 업로드 됐던 이미지 삭제 후 새로운 이미지 업로드
			ogImageFile.delete();
			imgName = uuid.toString()+formattedDate+"."+fileExtension;
			File newImageFile = new File(boardDirectory,imgName); //이미지를 새로 업로드하기 위해 생성
			try {
			image1.transferTo(newImageFile);
			g_dao.boardUpdate(boardNum,title,content,imgName);
			System.out.println("image update O");
			}catch(IOException e) {
        		e.printStackTrace();
        		System.out.println("image update X");
        	}
		}else if(ogFileName.equals("")) {
			// 여기서 업로드 됐던 이미지 삭제해야함
			System.out.println("ogImageFile in:"+ogImageFile);
			ogImageFile.delete();
			g_dao.boardUpdate(boardNum,title,content,"");
			System.out.println("image Delete");
		}else if(imgName==null || imgName.equals("")) {
			// 제목, 내용만 수정
			g_dao.boardUpdate(boardNum,title,content,ogFileName);
			System.out.println("board update without img");
		}
		return "redirect:/korBook/g_board";
	}
	// 변경
	@PostMapping("/insertComment")
	public String insertComment(HttpServletRequest req) {
		String userid = req.getParameter("userid");
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String commentBox = req.getParameter("commentBox");
		g_dao.insertComment(userid,boardNum,commentBox);
		return "redirect:/g_view?boardNum="+boardNum;
	}
	// 변경
	@GetMapping("/g_commentDelete")
	public String g_commentDelete(HttpServletRequest req) {
		int c_num = Integer.parseInt(req.getParameter("c_num"));
		int boardNum = Integer.parseInt(req.getParameter("b_num"));
		g_dao.g_commentDelete(c_num);
		return "redirect:/g_view?boardNum="+boardNum;
	}
	// FAQ 
	@GetMapping("/g_FAQ")
	public String g_FAQ(HttpServletRequest req, Model model) {
		ArrayList<mallDTO> random = mdao.selectid();
		model.addAttribute("random",random);
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		ArrayList<g_faqDTO> g_faq = g_dao.g_getFAQ();
		JSONArray ja = new JSONArray();
		for(int i=0; i<g_faq.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("num",g_faq.get(i).num);
			jo.put("title",g_faq.get(i).title);
			jo.put("content",g_faq.get(i).content);
			ja.add(jo);
		}
		ja.toJSONString();
		model.addAttribute("getFAQ",ja);
		return "/korBook/g_FAQ";
	}
	@PostMapping("/updateFAQ")
	public String updateFAQ(HttpServletRequest req) {
		int num = Integer.parseInt(req.getParameter("updateFAQ_NUM"));
		String title = req.getParameter("updateFAQ_title");
		String content = req.getParameter("updateFAQ_content");
		g_dao.g_updateFAQ(num,title,content);
		return "redirect:/g_FAQ";
	}
	@PostMapping("/insertFAQ")
	public String insertFAQ(HttpServletRequest req) {
		String title = req.getParameter("insertFAQ_title");
		String content = req.getParameter("insertFAQ_content");
		g_dao.g_insertFAQ(title,content);
		return "redirect:/g_FAQ";		
	}
	@GetMapping("/deleteFAQ")
	public String deleteFAQ(HttpServletRequest req) {
		int num = Integer.parseInt(req.getParameter("num"));
		g_dao.g_deleteFAQ(num);
		return "redirect:/g_FAQ";
	}
	@GetMapping("/g_question")
	public String g_question(HttpServletRequest req, Model model) {
		ArrayList<mallDTO> random = mdao.selectid();
		model.addAttribute("random",random);
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		
		int start,psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";
		}
		int pno = Integer.parseInt(page);
		start = (pno-1)*10;
		psize=10;
		
		if(admin==null) {
			admin=0;
		}
		if(admin==1) {
			int cnt=g_dao.g_getQnaTotal();
			int pagecount = (int) Math.ceil(cnt/10.0);
			String pagestr="";
			for(int i=1; i<=pagecount; i++) {
				if(pno==i) {
					pagestr += i+"&nbsp;";
				}else {
					pagestr+="<a href='/g_question?pageno="+i+"'>"+i+"</a>&nbsp;";
				}
			}
			model.addAttribute("pagestr",pagestr);
			ArrayList<g_questionDTO> g_getQuestion = g_dao.g_getQuestion(start,psize);
			JSONArray ja = new JSONArray();
			for(int i=0; i<g_getQuestion.size(); i++) {
				JSONObject jo = new JSONObject();
				jo.put("num",g_getQuestion.get(i).num);
				jo.put("userid",g_getQuestion.get(i).userid);
				jo.put("title",g_getQuestion.get(i).title);
				jo.put("content",g_getQuestion.get(i).content);
				jo.put("progress",g_getQuestion.get(i).progress);
				jo.put("created",g_getQuestion.get(i).created);
				jo.put("answer",g_getQuestion.get(i).answer);
				jo.put("privateCheck",g_getQuestion.get(i).privateCheck);
				ja.add(jo);
			}
			ja.toJSONString();
			model.addAttribute("getQuestion",ja);
		}else{
			int cnt=g_dao.g_getQnaTotalClient(userid);
			int pagecount = (int) Math.ceil(cnt/10.0);
			String pagestr="";
			for(int i=1; i<=pagecount; i++) {
				if(pno==i) {
					pagestr += i+"&nbsp;";
				}else {
					pagestr+="<a href='/g_question?pageno="+i+"'>"+i+"</a>&nbsp;";
				}
			}
			model.addAttribute("pagestr",pagestr);
			ArrayList<g_questionDTO> g_getQuestionClient = g_dao.g_getQuestionClient(userid,start,psize);
			JSONArray ja = new JSONArray();
			for(int i=0; i<g_getQuestionClient.size(); i++) {
				JSONObject jo = new JSONObject();
				jo.put("num",g_getQuestionClient.get(i).num);
				jo.put("userid",g_getQuestionClient.get(i).userid);
				jo.put("title",g_getQuestionClient.get(i).title);
				jo.put("content",g_getQuestionClient.get(i).content);
				jo.put("progress",g_getQuestionClient.get(i).progress);
				jo.put("created",g_getQuestionClient.get(i).created);
				jo.put("answer",g_getQuestionClient.get(i).answer);
				jo.put("privateCheck",g_getQuestionClient.get(i).privateCheck);
				ja.add(jo);
			}
			ja.toJSONString();
			model.addAttribute("getQuestion",ja);
		}
		return "/korBook/g_question";
	}
	@GetMapping("/g_answer")
	public String g_answer(HttpServletRequest req, Model model) {
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		if(admin!=1) {
			return "redirect:/korBook/g_board";
		}
		int num = Integer.parseInt(req.getParameter("num"));
		g_questionDTO g_answer = g_dao.g_reply(num);
		model.addAttribute("getQuestion",g_answer);
		return "/korBook/g_answer";
	}
	@PostMapping("/insertAnswer")
	public String insertAnswer(HttpServletRequest req) {
		int num = Integer.parseInt(req.getParameter("question-number"));
		String answer = req.getParameter("answer-text");
		g_dao.g_insertAnswer(num,answer);
		return "redirect:/g_question";
	}
	@GetMapping("/g_newQuestion")
	public String g_newQuestion(HttpServletRequest req, Model model) {
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		return "/korBook/g_newQuestion";
	}
	@PostMapping("/g_insertQuestion")
	public String g_insertQuestion(HttpServletRequest req) {
		String userid = req.getParameter("user-id");
		String title = req.getParameter("question-title");
		String content = req.getParameter("question-content");
		int visibility = Integer.parseInt(req.getParameter("visibility"));
		g_dao.g_insertQuestion(userid,title,content,visibility);
		return "redirect:/g_question";
	}
	@PostMapping("/addrecomment")
	@ResponseBody
	public String recomment(HttpServletRequest req, Model model) {
	    HttpSession session = req.getSession();
	    String userid = (String) session.getAttribute("userid");
	    Integer admin = (Integer) session.getAttribute("admin");

	    if (userid == null || userid.equals("")) {
	        model.addAttribute("userid", "");
	    } else {
	        model.addAttribute("userid", userid);
	        model.addAttribute("admin", admin);
	    }

	    int b_id = Integer.parseInt(req.getParameter("b_num"));
	    int r_id = Integer.parseInt(req.getParameter("recommentId"));
	    String recomment = req.getParameter("comment");
	    g_dao.insertrecomment(userid, b_id, recomment, r_id);
	    ArrayList<g_commentDTO> alcomment = g_dao.recomment(r_id);
		JSONArray ja = new JSONArray();
		for(int i=0; i<alcomment.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("num",alcomment.get(i).userid);
			jo.put("userid",alcomment.get(i).b_num);
			jo.put("title",alcomment.get(i).c_num);
			jo.put("content",alcomment.get(i).comment);
			jo.put("progress",alcomment.get(i).recommentid);
			ja.add(jo);
		}
	    return ja.toJSONString();
	}
	@GetMapping("/home")
	public String home(HttpServletRequest req, Model model) {
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		Integer admin=(Integer)session.getAttribute("admin");
		//변경사항
		if(userid==null || userid.equals("")) {
			model.addAttribute("userid", "");
		} else {
			model.addAttribute("userid", userid);
			model.addAttribute("admin", admin);
		}
		ArrayList<mallDTO> random = mdao.selectid();
		model.addAttribute("random",random);
		ArrayList<mallDTO> alBook = mdao.getBookHit();
		JSONArray ja1 = new JSONArray();
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		for(int i=0; i<alBook.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("seq",alBook.get(i).seq);
			jo.put("name",alBook.get(i).name);
			jo.put("genre",alBook.get(i).genre);
			jo.put("img",alBook.get(i).img);
			jo.put("author",alBook.get(i).author);
			ja1.add(jo);
		}
		ja1.toJSONString();
		model.addAttribute("hit",ja1);
		ArrayList<mallDTO> alBookBestSeller = mdao.getBookBestSeller();
		JSONArray ja2 = new JSONArray();
		for(int i=0; i<alBookBestSeller.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("seq",alBookBestSeller.get(i).seq);
			jo.put("name",alBookBestSeller.get(i).name);
			jo.put("genre",alBookBestSeller.get(i).genre);
			jo.put("img",alBookBestSeller.get(i).img);
			jo.put("author",alBookBestSeller.get(i).author);
			ja2.add(jo);
		}
		ja2.toJSONString();
		model.addAttribute("bestSeller",ja2);
		ArrayList<mallDTO> alBookNew = mdao.getBookNew();
		JSONArray ja3 = new JSONArray();
		for(int i=0; i<alBookNew.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("seq",alBookNew.get(i).seq);
			jo.put("name",alBookNew.get(i).name);
			jo.put("genre",alBookNew.get(i).genre);
			jo.put("img",alBookNew.get(i).img);
			jo.put("author",alBookNew.get(i).author);
			ja3.add(jo);
		}
		ja3.toJSONString();
		model.addAttribute("newBook",ja3);
		return "home";
	}
}