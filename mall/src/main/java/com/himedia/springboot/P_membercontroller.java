package com.himedia.springboot;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class P_membercontroller {
	@Autowired
	private P_membercontrolDAO mcontDAO;
	@GetMapping("/adminPage")
	public String admin(HttpServletRequest req, Model model) {
		HttpSession session=req.getSession();
		Integer admin=(Integer)session.getAttribute("admin");
		if(admin!=1) {
			return "redirect:/";
		}
		ArrayList<P_membercontrolDTO>mlist=mcontDAO.getmemberlist();
		model.addAttribute("memberlist",mlist);
		return "/korBook/P_membercontrollerJSP";
	}
	
	@GetMapping("/memberdelete")
	public String deletemeber(HttpServletRequest req, Model model) {
		String userid = req.getParameter("id");
		mcontDAO.memberdelete(userid);
		return "redirect:/adminPage";
	}
}
