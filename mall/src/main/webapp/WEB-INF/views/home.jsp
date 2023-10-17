<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="../css/main.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>홈페이지</title>
</head>
<%@ include file ="../views/header/Header.jsp" %>
<body>
<div class="main">
    <div class="slide">
    	<a href="/"><p class="title">놀란의 최고 걸작 <오펜하이머> 원작</p>
        <img class="slideImg" src="img/아메리칸 프로메테우스(특별판).png" alt="아메리칸 프로메테우스(특별판)"></a>
    </div>
    <div class="slide">
    	<a href="/"><p class="title">전자책 단말기<br>달달한 혜택</p>
        <img class="slideImg" src="img/배너_9월단말기.jpg" alt="전자책 단말기<br>달달한 혜택"></a>
    </div>
    <div class="slide">
    	<a href="/"><p class="title">가장 최신의 취향<br>Look & Book Vol. 2</p>
        <img class="slideImg" src="img/banner3.jpg" alt="Banner 3"></a>
    </div>
    <button id="prev" class="prev"><</button><button id="next" class="next">></button>
<div class="hot">
<h1>급상승!많이 보고 있는 상품</h1>
<a href="korBook/bookoption?optSort=popular">+ 더보기</a>
<c:forEach items="${hit}" var="hit">
<div class="prod_area">
	<a href="/korBook/detail?seqno=${hit.seq}">
	<img src="../img/prodmain/${hit.img}" style="width:300px; height:444px">
	<div>
	<div class="prod_category">${hit.genre}</div>
	<div class="prod_name">${hit.name}</div>
	<div class="prod_author">${hit.author}</div>
	</div>
	</a>
</div>
</c:forEach>
</div>
<div class="bestSeller">
<h1>베스트셀러</h1>
<a href="korBook/bestSeller">+ 더보기</a>
<c:forEach items="${bestSeller}" var="bestSeller">
<div class="prod_area">
	<a href="/korBook/detail?seqno=${bestSeller.seq}">
	<img src="../img/prodmain/${bestSeller.img}" style="width:300px; height:444px">
	<div>
	<div class="prod_category">${bestSeller.genre}</div>
	<div class="prod_name">${bestSeller.name}</div>
	<div class="prod_author">${bestSeller.author}</div>
	</div>
	</a>
</div>
</c:forEach>
</div>
<div class="new">
<h1>최근에 추가됐어요!!</h1>
<a href="korBook/bookoption?optSort=newest">+ 더보기</a>
<c:forEach items="${newBook}" var="newBook">
<div class="prod_area">
	<a href="/korBook/detail?seqno=${newBook.seq}">
	<img src="../img/prodmain/${newBook.img}" style="width:300px; height:444px">
	<div>
	<div class="prod_category">${newBook.genre}</div>
	<div class="prod_name">${newBook.name}</div>
	<div class="prod_author">${newBook.author}</div>
	</div>
	</a>
</div>
</c:forEach>
</div>
</div>
<div class="bigBanner">
<a href="https://hottracks.kyobobook.co.kr/ht/hot/hotdealMain" target="_blank">
<img src="logoimg/bigBanner.jpg" class="bigBannerImg"><br><br>
<span style="font-size:small; color:darkblue; font-weight:bold">[1+1]2024 벽걸이 캘린더</span><br><br>
<span style="font-weight:bold;">12,000원 -> 10,900원[무료배송]</span><br><br>
<span style="font-weight:bold; color:grey; font-size:small;">by ad</span>
</a>
</div>
<div style="margin-top:2800px;">
<%@ include file ="../views/header/footer.jsp" %>
</div>
<div class="top-button" id="topButton">&#9650;</div>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document).ready(function(){
    let slideIndex = 0;
    
    showSlides();
    
    function showSlides() {
        let i;
        let slides = $(".slide");
        
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";  
        }
        
        slideIndex++;
        
        if (slideIndex > slides.length) {slideIndex = 1}    
        
        slides[slideIndex-1].style.display = "block";  
        setTimeout(showSlides, 5000); // 5초마다 슬라이드 변경
    }
})
$(document).ready(function(){
    let slideIndex = 0;
    let slides = $(".slide");
    
    showSlides(slideIndex);
    
    function showSlides(index) {
        if (index >= slides.length) {slideIndex = 0}    
        if (index < 0) {slideIndex = slides.length - 1}
        
        slides.hide();
        slides.eq(slideIndex).show();
    }

    $(".prev").click(function() {
        slideIndex--;
        showSlides(slideIndex);
    });

    $(".next").click(function() {
        slideIndex++;
        showSlides(slideIndex);
    });
})
$(document).ready(function(){
    $(window).scroll(function(){
        if ($(this).scrollTop() > 100) {
            $('.top-button').fadeIn();
        } else {
            $('.top-button').fadeOut();
        }
    });

    $('.top-button').click(function(){
        $('html, body').animate({scrollTop : 0},800);
        return false;
    });
})
</script>
</html>