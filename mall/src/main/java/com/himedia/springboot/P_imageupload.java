package com.himedia.springboot;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class P_imageupload {
	@Value("${mainimage.directory}")
    private String mainuploadDirectory;
	@Value("${subimage.directory}")
    private String subuploadDirectory;
	@Autowired
	private P_addbookDAO adddao;
    @PostMapping("/upload")
    public String uploadFile(HttpServletRequest req,@RequestParam("mainimg") MultipartFile main,
    		@RequestParam("prodinfo") MultipartFile sub, Model model) {
        if (!main.isEmpty()) {
            try {
            	//이미지추가
            	String name = req.getParameter("name");
            	int price = Integer.parseInt(req.getParameter("price"));
            	String genre = req.getParameter("genre");
            	String mainimg = main.getOriginalFilename();
            	String author = req.getParameter("author");
            	String prodinfo = sub.getOriginalFilename();
            	int stock = Integer.parseInt(req.getParameter("stock"));
            	String editorreview = req.getParameter("editorreview");
            	String info = req.getParameter("info");
            	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
    			Date date = new Date(); // 날짜 및 시간을 나타내는 Date 객체 생성 (현재 시간)
    			String formattedDate = sdf.format(date);
    			String fileExtension = StringUtils.getFilenameExtension(mainimg);
    			String fileExtensionsub = StringUtils.getFilenameExtension(prodinfo);
            	// uuid 생성 
            	UUID mainid = UUID.randomUUID();
            	UUID subid = UUID.randomUUID();
            	//savedName 변수에 uuid + 원래 이름 추가
            	
            	String savedMainName = mainid.toString()+formattedDate+"."+fileExtension;
            	String savedSubName = subid.toString()+formattedDate+"."+fileExtensionsub;
                // 파일 저장 경로로 파일 이동
                File mainFile = new File(mainuploadDirectory + File.separator + savedMainName);
                File subFile = new File(subuploadDirectory + File.separator + savedSubName);
                
                main.transferTo(mainFile);
                sub.transferTo(subFile);
				adddao.addbook(name, price, savedMainName, genre, author, savedSubName,info, stock,editorreview );
                model.addAttribute("fileName", mainFile);
                return "redirect:/korBook/korbook";
            } catch (IOException e) {
                e.printStackTrace();
                model.addAttribute("errorMessage", "파일 업로드 실패");
            }
        } else {
            model.addAttribute("errorMessage", "업로드할 파일을 선택하세요.");
        }

        return "redirect:/korBook/korbook";
    }
    
}