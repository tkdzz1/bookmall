package com.himedia.springboot;

import java.io.File;
import java.lang.ref.ReferenceQueue;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class homeController {
	@Value("${mainimage.directory}")
    private String mainuploadDirectory;
	@Value("${subimage.directory}")
    private String subuploadDirectory;
	@Value("${mainclasspath.directory}")
    private String maindeleteDirectory;
	@Value("${subclasspath.directory}")
    private String subdeleteDirectory;
	@Autowired
	private mallDAO mdao;
	@Autowired
	private mallDAO sdao;

	
	@GetMapping ("/")
	public String L_home(HttpServletRequest req,Model model) {
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
		
		return "redirect:/home";
	}
	


	@GetMapping("/Header")
	public String header(HttpServletRequest req, Model model) {
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
		
		return "header/Header";
	}
	@GetMapping("/dosearch")
	public String desearch(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=mdao.getsearchTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/korBook/korbook?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		String name = req.getParameter("name");
		ArrayList<mallDTO> result = sdao.dosearch(name,start,psize);
		model.addAttribute("albook",result );
		return "/korBook/korbook";
	}
	
	@GetMapping ("/login")
	public String login() {
		return "login";
	}
	@GetMapping ("/signup")
	public String signup() {
		return "signup";
	}	
	@PostMapping("/dosignup")
	public String dosignup(Model model,HttpServletRequest req) {
		String userid=req.getParameter("userid");
		String passcode=req.getParameter("passcode");
		String username=req.getParameter("username");
		String gender=req.getParameter("gender");
		String birthday=req.getParameter("birthday");
		String mobile=req.getParameter("mobile");
		String email=req.getParameter("email");
		String address=req.getParameter("address");
		
		String address_detail=req.getParameter("address_detail");
		try {
			mdao.insert(userid, passcode, username, gender, birthday, mobile, email, address, address_detail);
			model.addAttribute("fail","<script type=\"text/javascript\">alert(\"회원가입 성공.\");</script>");
			return "redirect:/login";
		} catch(Exception e) {
			model.addAttribute("fail","<script type=\"text/javascript\">alert(\"회원가입 실패.\");</script>");
			return "/signup";
		}
	}
	@PostMapping("/idchk")
	@ResponseBody
	public int idchk(HttpServletRequest req,Model model) {
		String id=req.getParameter("id");
		int chk =  mdao.idchk(id);
		return chk;
	}
	@PostMapping("/dologin")
	@ResponseBody
	public String dologin(HttpServletRequest req, Model model) {
		String userid=req.getParameter("id");
		String passcode=req.getParameter("pw");
		int n = mdao.select(userid,passcode);
	
		Integer admin = mdao.admin(userid,passcode);
		if(n==1) {
			HttpSession session= req.getSession();
			session.setAttribute("userid", userid);
			session.setAttribute("password", passcode);
			session.setAttribute("admin", admin);
			return "0";
		} else {
			return "-1";
		}
	}
	@GetMapping("/logout")
	public String doLogout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.invalidate();
		return "redirect:/korBook/korbook";
	}	
	@GetMapping("/findid")
	public String findid() {
		return "/findID";
	}
	@PostMapping("/dofindId")
	public String dofindId(HttpServletRequest req,Model model) {
		String email = req.getParameter("email");
		String name = req.getParameter("name");
		String birthday = req.getParameter("birthday");
		P_findidDTO findid= mdao.findid(email,name,birthday);
		if (findid != null) {
	        String id = findid.getUserid();
	        model.addAttribute("foundId", id);
	        return "/findid_result";
	    } else {
	        model.addAttribute("fail", "<script type=\"text/javascript\">alert(\"존재하는 아이디가 없습니다.\");</script>");
	        return "/findID";
	    }
	}
	@PostMapping("/dofindpw")
	public String dofindpw(HttpServletRequest req,Model model) {
		String email = req.getParameter("email");
		String id = req.getParameter("id");
		String name = req.getParameter("name");
		String birthday = req.getParameter("birthday");
		P_findidDTO findpw= mdao.findpw(email,id,name, birthday);
		if (findpw!= null) {
	        String pw = findpw.getPassword();
	        System.out.println("pw:"+pw);
	        model.addAttribute("foundId", pw);
	        return "/findid_result";
	    } else {
	        model.addAttribute("fail", "<script type=\"text/javascript\">alert(\"비밀번호 회원정보가 틀립니다.\");</script>");
	        return "/findID";
	    }
	}
	@GetMapping("/korBook/korbook")
	public String bookall(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=mdao.getTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/korBook/korbook?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}	
		ArrayList<mallDTO> random = mdao.selectid();
		model.addAttribute("random",random);
		model.addAttribute("pagestr",pagestr);
		ArrayList<mallDTO> albook = mdao.getAll(start,psize);
		String genre = "전체";
		model.addAttribute("genre",genre);
		model.addAttribute("albook",albook);
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "/korBook/korbook";
	}
	
	@GetMapping("/korBook/bestSeller")
	public String bestSeller(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=mdao.getBestSellerTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/korBook/bestSeller?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		String genre = "베스트셀러";
		model.addAttribute("genre",genre);
		ArrayList<mallDTO> alBestSeller = mdao.getBestSeller(start,psize);
		model.addAttribute("albook",alBestSeller);
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "/korBook/korbook";
	}
	@GetMapping("/korBook/kornovel")
	public String novel(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=mdao.getnovelTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/korBook/kornovel?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<mallDTO> alnovel = mdao.getNovel(start,psize);
		String novel = alnovel.get(0).genre;
		model.addAttribute("genre",novel);
		model.addAttribute("albook",alnovel);
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "/korBook/korbook";
	}
	@GetMapping("/korBook/korhistory")
	public String history(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=mdao.gethistoryTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/korBook/korhistory?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<mallDTO> alhistory = mdao.getHistory(start,psize);
		String history = alhistory.get(0).genre;
		model.addAttribute("genre",history);
		model.addAttribute("albook",alhistory);
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "/korBook/korbook";
	}
	
	@GetMapping("/korBook/koreconomy")
	public String conomy(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=mdao.geteconomyTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/korBook/koreconomy?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<mallDTO> alconomy = mdao.getConomy(start,psize);
		String economy = alconomy.get(0).genre;
		model.addAttribute("genre",economy);
		model.addAttribute("albook",alconomy);
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "/korBook/korbook";
	}
	@GetMapping("/korBook/korpolitics")
	public String politics(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=mdao.getpoliticsTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/korBook/korpolitics?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<mallDTO> alpolitics = mdao.getPolitics(start,psize);
		String politics = alpolitics.get(0).genre;
		model.addAttribute("genre",politics);
		model.addAttribute("albook",alpolitics);
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "/korBook/korbook";
	}
	@GetMapping("/korBook/korcomic")
	public String Comic(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		int cnt=mdao.getcomicTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
			pagestr+="<a href='/korBook/korcomic?pageno="+i+"'>"+i+"</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr",pagestr);
		ArrayList<mallDTO> alComic = mdao.getComic(start,psize);
		String Comic = alComic.get(0).genre;
		model.addAttribute("genre",Comic);
		model.addAttribute("albook",alComic);
		int count = mdao.count(userid);
		model.addAttribute("count", count);
		return "/korBook/korbook";
	}
	
	@GetMapping("/korBook/detail")
	public String detail(HttpServletRequest req, Model model) {
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
		int seqno=Integer.parseInt(req.getParameter("seqno"));
		mallDTO book = mdao.bselect(seqno);
		ArrayList<reviewDTO> review = mdao.getreview(seqno);
		model.addAttribute("review",review);
		mdao.hitup(seqno);
		model.addAttribute("book",book);		
		return "korBook/detail";
	}
	@GetMapping("/korBook/buyment")
	public String buyment(HttpServletRequest req,Model model) {
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
		int seq = Integer.parseInt(req.getParameter("seqno"));
		memberDTO customer = mdao.getmember(userid);
		mallDTO orders = mdao.orders(seq);
		model.addAttribute("book",orders);
		model.addAttribute("customer",customer);
		return "korBook/buyment";
	}
	@PostMapping("/korBook/cartpayment")
	public String payment(HttpServletRequest req,Model model) {
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
		
		int count = mdao.countcart(userid);
		for (int i=0; i<count; i++) {
			int prodid = Integer.parseInt(req.getParameter("hidprodid" + i));
			String prodname = req.getParameter("hidprodname" + i);
			String mobile = req.getParameter("mobile");
			int qty = Integer.parseInt(req.getParameter("qtynum" + i));
			int sum = Integer.parseInt(req.getParameter("qtysum" + i));
	        String email = req.getParameter("email");
	        String address = req.getParameter("address");
	        String address_detail = req.getParameter("address_detail");
			mdao.stock(prodid, qty);
	        mdao.paymentinsert(userid, prodid, prodname, mobile, qty, sum, address, address_detail, email);
			mdao.deletecart(userid, prodid);
			model.addAttribute("sum",sum);
		}
		return "korBook/tosspayment";
	}
	
	@PostMapping("/korBook/Payment")
	public String Payment(HttpServletRequest req, Model model) {
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
	        int prodid = Integer.parseInt(req.getParameter("prodid"));
	        String prodname = req.getParameter("prodname");
	        String mobile = req.getParameter("mobile");
	        int qty = Integer.parseInt(req.getParameter("qty"));
	        int sum = Integer.parseInt(req.getParameter("sum"));
	        String email = req.getParameter("email");
	        String address = req.getParameter("address");
	        String address_detail = req.getParameter("address_detail");
	        // orders 테이블에 결제 정보 삽입
	        mdao.stock(prodid, qty);
	        mdao.paymentinsert(userid, prodid, prodname, mobile, qty, sum, address, address_detail, email);
	        model.addAttribute("sum",sum);
	    return "korBook/tosspayment";
	}
	@GetMapping("/korBook/addBook")
	public String addBook() {
		return "korBook/addBook";
	}
	
//	@PostMapping("/korBook/addBookdb")
//	public String addBookdb(HttpServletRequest req) {
//		String name=req.getParameter("name");
//		String price=req.getParameter("price");
//		String genre=req.getParameter("genre");
//		String img=req.getParameter("img");
//		String author=req.getParameter("author");
//		String prodinfo=req.getParameter("prodinfo");
//		mdao.addbookinsert(name,price,genre,img,author,prodinfo);
//		return "redirect:/korBook/addBook";
//		
//	}
	@GetMapping("/korBook/addcart")
	@ResponseBody
	public String cart(@RequestParam(value = "seqlist[]", required = false) List<Integer> seqlist,
	                   @RequestParam(value = "seqno", required = false) Integer seqno,
	                   HttpServletRequest req, Model model) {
	    HttpSession session = req.getSession();
	    String userid = (String) session.getAttribute("userid");
	    Integer admin = (Integer) session.getAttribute("admin");

	    // 변경사항
	    if (userid == null || userid.equals("")) {
	        model.addAttribute("userid", "");
	    } else {
	        model.addAttribute("userid", userid);
	        model.addAttribute("admin", admin);
	    }

	    if (seqlist != null && !seqlist.isEmpty()) {
	        int cnt = 0;
	        for (Integer value : seqlist) {
	            mdao.deletecart(userid, value);
	            System.out.println("Selected value: " + value);
	            cnt = mdao.addcart(userid, value);
	        }
	        return "" + cnt;
	    } else if (seqno != null) {
	        System.out.println(seqno);
	        mdao.addcart(userid, seqno);
	        int cnt = mdao.count(userid);
	        return "" + cnt;
	    }

	    return ""; // 처리할 경우가 없을 때 공백 문자열 반환
	}
	@GetMapping("/korBook/viewcart")
	public String view(HttpServletRequest req, Model model) {
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
	    ArrayList<mallDTO> cart = mdao.selectCart(userid);
	    int total = 0; // 초기값을 0으로 설정
	    if (cart == null || cart.isEmpty()) {
	        // 장바구니가 비어있을 경우
	        model.addAttribute("cartEmptyMessage", "장바구니가 비어있습니다.");
	    } else {
	        // 장바구니가 비어있지 않은 경우에만 합계 계산
	    	model.addAttribute("cartEmptyMessage", "");
	        total = mdao.totalsum();
	    }
		memberDTO customer = mdao.getmember(userid);
		model.addAttribute("customer",customer);
	    model.addAttribute("book", cart); // inner join 해서 가져온 상품정보 jsp로 넘기기
	    model.addAttribute("totalsum", total); // DB에서 카트에 담긴 상품 금액 합쳐서 가져오기
	    return "korBook/cart";
	}
	@GetMapping("/korBook/deletecart")
	public String delete(HttpServletRequest req, Model model) {
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
		int prodid=Integer.parseInt(req.getParameter("prodid"));
		mdao.deletecart(userid, prodid);
		return "redirect:/korBook/viewcart";
	}
	@RestController
	public class ImageController {

		@RequestMapping(value = "/deleteImage/{imageName}/{subFileName}/{seqno}", method = RequestMethod.DELETE)
	    public String deleteImage(@PathVariable String imageName, @PathVariable String subFileName, @PathVariable int seqno) {
	        String mainDirectory = maindeleteDirectory; // 이미지 파일이 저장된 디렉토리 경로
	        String subDirectory = subdeleteDirectory;

	        File mainimageFile = new File(mainDirectory, imageName);
	        File subimageFile = new File(subDirectory, subFileName);
	        if (mainimageFile.exists() && mainimageFile.isFile()) {
	            if (mainimageFile.delete()) {
	            	if(subimageFile.delete()) {
	            		mdao.deletetb(seqno);
	            		return "이미지 파일이 전부 삭제되었습니다.";
	            	}
	            	return "이미지 파일이 삭제되었습니다.";
	            } else {
	            	mdao.deletetb(seqno);
	                return "이미지 파일 삭제 실패: 삭제 권한이 없거나 파일이 사용 중일 수 있습니다.";
	            }
	        } else {
	        	mdao.deletetb(seqno);
	            return "이미지 파일이 존재하지 않습니다.";
	        }
	    }
	}
	@GetMapping("/korBook/bookdelete")
	public String bookdelete(HttpServletRequest req, Model model) {
		ArrayList<mallDTO> booklist = mdao.getlist();
		model.addAttribute("booklist", booklist);
		return "korBook/bookdelete";
	}
	@GetMapping("/deletelist")
	public String deletelist(HttpServletRequest req) {
		int prodid=Integer.parseInt(req.getParameter("prodid"));
		System.out.println("prodid:"+ prodid);
		String prodimg=req.getParameter("prodimg");
		String prodinfo=req.getParameter("prodinfo");
		String prodmainDirectory = mainuploadDirectory;	
		String prodsubDirectory = subuploadDirectory;
		
		File mainprodimgFile = new File(prodmainDirectory,prodimg);
		File subprodimgFile = new File(prodsubDirectory,prodinfo);
       
		if (mainprodimgFile.exists() && mainprodimgFile.isFile()) {
	        if (mainprodimgFile.delete()) {
	        	
	        	System.out.println("main");
	        	if(subprodimgFile.delete()) {
	        		mdao.deletetb(prodid);
	        		return "redirect:/korBook/bookdelete";  
	        	}
	        } else {
	        	mdao.deletetb(prodid);
	            return "redirect:/korBook/bookdelete";
	        }
	    }	
		mdao.deletetb(prodid);
	    return "redirect:/korBook/bookdelete";
	}
	@GetMapping("/korBook/bookoption")
	public String optselect(HttpServletRequest req, Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*5;
		psize=5;		
		String optvalue = req.getParameter("optSort");
		int cnt=mdao.getTotal();
		int pagecount = (int)Math.ceil(cnt/5.0);
		String pagestr="";

		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
				pagestr += "<a href='/korBook/bookoption?optSort=" + optvalue + "&pageno=" + i + "'>" + i + "</a>&nbsp;";
			}
		}
	    model.addAttribute("pagestr", pagestr);
	    
	    ArrayList<mallDTO> list = new ArrayList<>(); // 변수 선언 및 초기화
	    String genre = req.getParameter("genre");

	    if (genre == null || genre.isEmpty()) {
		    if (optvalue.equals("popular")) {
		        list = mdao.popular2(start, psize);
		    } else if (optvalue.equals("sales")) {
		        list = mdao.sales2(start, psize);
		    } else if (optvalue.equals("newest")) {
		    	list = mdao.newest2(start, psize);
		    } else if (optvalue.equals("highprice")) {
		    	list = mdao.highprice2(start, psize);
		    } else if (optvalue.equals("lowprice")) {
		    	list = mdao.lowprice2(start, psize);
		    }

	    } else {
		    if (optvalue.equals("popular")) {
		        list = mdao.popular(start, psize, genre);
		    } else if (optvalue.equals("sales")) {
		        list = mdao.sales(start, psize, genre);
		    } else if (optvalue.equals("newest")) {
		    	list = mdao.newest(start, psize, genre);
		    } else if (optvalue.equals("highprice")) {
		    	list = mdao.highprice(start, psize, genre);
		    } else if (optvalue.equals("lowprice")) {
		    	list = mdao.lowprice(start, psize, genre);
		    }
	    }
		int count = mdao.count(userid);
		model.addAttribute("count", count);
	    model.addAttribute("albook", list);

	    return "/korBook/korbook";
	}
	@GetMapping("/korBook/ordercomplite")
	public String tosspayment(HttpServletRequest req, Model model) {
		return "korBook/ordercomplite";
	}
	@GetMapping("/korBook/productmanagement")
	public String pmanagement(HttpServletRequest req,Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*8;
		psize=8;		
		int cnt=mdao.getTotal();
		int pagecount = (int)Math.ceil(cnt/8.0);
		String pagestr="";

		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
				pagestr += "<a href='/korBook/productmanagement?pageno=" + i + "'>" + i + "</a>&nbsp;";
			}
		}
	    model.addAttribute("pagestr", pagestr);
		ArrayList<mallDTO> prodlist = mdao.getAll(start,psize);
		model.addAttribute("prodlist",prodlist);
		return "korBook/productmanagement";
	}
	@GetMapping("/korBook/orderhistory")
	public String orderhistory(HttpServletRequest req, Model model) {
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
		int start, psize;
		String page = req.getParameter("pageno");
		if(page==null || page.equals("")) {
			page="1";	
		} 
		int pno = Integer.parseInt(page);
		start = (pno-1)*10;
		psize=10;		
		int cnt=mdao.ordercnt(userid);
		int pagecount = (int)Math.ceil(cnt/10.0);
		String pagestr="";
		for(int i=1; i<=pagecount; i++) {
			if(pno==i) {
				pagestr+=i+"&nbsp;";
			} else {
				pagestr += "<a href='/korBook/orderhistory?pageno=" + i + "'>" + i + "</a>&nbsp;";
			}
		}
		model.addAttribute("pagestr", pagestr);
		ArrayList<mallDTO> orderlist = mdao.getOrderList(userid,start,psize);
		model.addAttribute("orderlist",orderlist);
		return "korBook/orderhistory";
		
	}
	@PostMapping("/orderdetail")
	@ResponseBody
	public String order(HttpServletRequest req, Model model) throws JsonProcessingException {
		int orderId = Integer.parseInt(req.getParameter("orderId"));
		orderDTO orderlist = mdao.findorder(orderId);

        // ObjectMapper를 사용하여 MallDTO 객체를 JSON 문자열로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String orderJson = objectMapper.writeValueAsString(orderlist);
		return orderJson;
	}
	
	@PostMapping("/korBook/addreview")
	public String review(HttpServletRequest req, Model model) {
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
		
		String comment = req.getParameter("comment");
		int seq = Integer.parseInt(req.getParameter("seqno"));
		int score = Integer.parseInt(req.getParameter("score"));
		System.out.println(score);
		mdao.addReview(seq,userid,comment,score);
		return "redirect:/korBook/detail?seqno="+ seq;
	}
	@GetMapping("/korBook/deletereview")
	public String delreview(HttpServletRequest req, Model model) {
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
		int deleteno = Integer.parseInt(req.getParameter("deleteno"));
		int seq = Integer.parseInt(req.getParameter("seqno"));
		mdao.deletereview(deleteno);
		
		return "redirect:/korBook/detail?seqno="+ seq;
	}
	@PostMapping("/korBook/updatereview")
	@ResponseBody
	public String updatereview(HttpServletRequest req, Model model) {
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
		int prodid = Integer.parseInt(req.getParameter( "prodNo"));
		int editNo = Integer.parseInt(req.getParameter( "editNo"));
		String editedComment = req.getParameter("editedComment");
		
		mdao.reviewupdate(editedComment, editNo,prodid);
		return editedComment;
	}

}


