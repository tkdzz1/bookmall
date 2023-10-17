package com.himedia.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class P_mypagecontroller {
	@Autowired
	private P_mypageDAO mydao;
	@GetMapping("/mypage")
    public String myInfo(HttpServletRequest req,Model model) {
	  	HttpSession session= req.getSession();
	  	String userid=(String)session.getAttribute("userid");
	  	P_mypageDTO myinfo = mydao.getmyInfo(userid);
	  	model.addAttribute("user",myinfo);
    	return "/korBook/P_mypage"; // 내 정보 페이지의 JSP 파일명
    }
	@GetMapping("/updetemyinfo")
    public String updetemyinfo(HttpServletRequest req,Model model) {
		HttpSession session= req.getSession();
	  	String userid=(String)session.getAttribute("userid");
		String mobile = req.getParameter("mobile");
		String email = req.getParameter("email");
		String address = req.getParameter("address");
		//1.0
		String address_detail = req.getParameter("address_detail");
		mydao.updatemyinfo(userid,mobile,email,address,address_detail);
		return "redirect:/mypage";
    }
	@GetMapping("/changepw")
    public String changepw(HttpServletRequest req,Model model) {
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
		P_pwDTO oldPasswordDTO = mydao.oldpw(userid);
		String oldPassword = oldPasswordDTO.getPassword();
	  	System.out.println("password"+oldPassword);
	  	model.addAttribute("originalpw",oldPassword);
    	return "/korBook/P_passwordchange";
    }
	@PostMapping("/dochangepw")
    public String dochangepw(HttpServletRequest req,Model model) {
		HttpSession session= req.getSession();
		String userid=(String)session.getAttribute("userid");
	  	String newpw=req.getParameter("newPassword");
	  	int success = mydao.updatepw(userid,newpw);
	  	if (success == 1) {
	  	    return "redirect:/mypage";
	  	} else {
	  	    model.addAttribute("fail", "<script type=\"text/javascript\"> alert(\"비밀번호변경실패.\");</script>");
	  	    return "forward:/changepw";
	  	}
	}
}
