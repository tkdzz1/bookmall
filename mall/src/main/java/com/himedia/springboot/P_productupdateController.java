package com.himedia.springboot;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class P_productupdateController {
	//어드민 상품수정
	@Value("${mainimage.directory}")
    private String mainuploadDirectory;
	@Value("${subimage.directory}")
    private String subuploadDirectory;
	@Autowired
	private mallDAO mdao;
	@Autowired
	private P_productupdateDAO pudao;
	
	@GetMapping("/modifyproduct")
	public String productupdate(HttpServletRequest req,Model model) {
		Integer seqno=Integer.parseInt(req.getParameter("seqno"));
		mallDTO book = mdao.bselect(seqno);
		model.addAttribute("book",book);	
		return "/korBook/P_productupdate";
	}
	

	@PostMapping("/doupdateproduct")
	public String doupdateproduct(HttpServletRequest req,
	@RequestParam("chgMimg")MultipartFile main,
	@RequestParam("chgSimg") MultipartFile sub) {
		try {
			int seqno=Integer.parseInt(req.getParameter("seqno"));
			String oriMimg =  req.getParameter("oriMimg");
			String Mimgstat = req.getParameter("Mimgstat");
			String chgMimg =  main.getOriginalFilename();
			String name=  req.getParameter("name");
			String genre=  req.getParameter("genre");
			String author =  req.getParameter("author");
			String editorreview = req.getParameter("editorreview");
			String info = req.getParameter("info");
			int price=Integer.parseInt(req.getParameter("price"));
			int stock=Integer.parseInt(req.getParameter("stock"));
			String oriSimg =  req.getParameter("oriSimg");
			String Simgstat = req.getParameter("Simgstat");
			String chgSimg =  sub.getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
			Date date = new Date(); // 날짜 및 시간을 나타내는 Date 객체 생성 (현재 시간)
			String formattedDate = sdf.format(date);
			System.out.println(seqno+name+genre+author+price+info+stock+ editorreview);
			pudao.productupdate(seqno,name,genre,author,price,info,stock, editorreview);
			
			
			
			if(!chgMimg.equals("")&&chgMimg != null) {	
				
				String fileExtension = StringUtils.getFilenameExtension(chgMimg);
				UUID mainid = UUID.randomUUID();
				
            	String savedMainName = mainid.toString()+formattedDate+"."+fileExtension;
            	
            	File mainFile = new File(mainuploadDirectory + File.separator + savedMainName);
            	main.transferTo(mainFile);
            	pudao.productupdateMimg(seqno,savedMainName);
            	File deleteMOriFile = new File(mainuploadDirectory + File.separator + oriMimg);
				if(deleteMOriFile.exists()) {
					deleteMOriFile.delete();
			    } 
			}
			if(!chgSimg.equals("")&&chgSimg != null) {	
				String fileExtension = StringUtils.getFilenameExtension(chgSimg);
				UUID subid = UUID.randomUUID();
				String savedSubName = subid.toString()+formattedDate+"."+fileExtension;
				File subFile = new File(subuploadDirectory + File.separator + savedSubName);
				sub.transferTo(subFile);	
				pudao.productupdateSimg(seqno,savedSubName);
				File deleteSOriFile = new File(subuploadDirectory + File.separator + oriSimg);
				if(deleteSOriFile.exists()) {
					deleteSOriFile.delete();	
		        }
				return "redirect:/";
			}
			//오리지널 이미지메인 상태 빈값
			if(Mimgstat.equals("")||Mimgstat == null) {
				if(chgMimg.equals("")||chgMimg == null) {	
					File deleteMOriFile = new File(mainuploadDirectory + File.separator + oriMimg);
			        // 오리지널 이미지메인 파일을 삭제합니다.
					if(deleteMOriFile.exists()) {
						deleteMOriFile.delete();
						pudao.productupdateMimg(seqno,Mimgstat);
			        }
				}
			}
			//오리지널 이미지서브 상태 빈값
			if (Simgstat.equals("") || Simgstat == null) {
				if(chgSimg.equals("")||chgSimg == null) {
					File deleteSOriFile = new File(subuploadDirectory + File.separator + oriSimg);
					// 오리지널 이미지서브 파일을 삭제합니다.
					if(deleteSOriFile.exists()) {
						deleteSOriFile.delete();
						pudao.productupdateSimg(seqno,Simgstat);
					}	
				}	
			}
			return "redirect:/";
		}catch(Exception e) {
			return "redirect:/";
		}
	}
	
}
