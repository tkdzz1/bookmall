<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/list.css"> 
    <link rel="stylesheet" href="//fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&family=Roboto:wght@400;500;700&display=swap"> 
    <link rel="stylesheet" href="https://contents.kyobobook.co.kr/resources/fo/vendors/jquery-ui-1.12.1/jquery-ui.min.css">
    <link rel="stylesheet" href="https://contents.kyobobook.co.kr/resources/fo/vendors/star-rating/css/star-rating.min.css"> 
    <link rel="stylesheet" href="https://contents.kyobobook.co.kr/resources/fo/css/loading.css">       
    <link rel="stylesheet" href="https://contents.kyobobook.co.kr/resources/fo/vendors/swiper/v4/swiper.min.css">
    <link rel="stylesheet" href="https://contents.kyobobook.co.kr/resources/fo/vendors/simplebar/5.3.3/simplebar.min.css">
    <link rel="stylesheet" href="https://contents.kyobobook.co.kr/resources/fo/css/style_ink.css" data-name="kbb-cm-style">
    <link rel="stylesheet" href="https://contents.kyobobook.co.kr/resources/dig-fo/dig/css/ebook_gnb_ink.css">
    <link rel="stylesheet" href="https://hottracks.kyobobook.co.kr/resources/css/ht_gnb.css"> 
</head>
<style>
div.pagination-container {
    text-align: center;
    margin-top: 20px;
}

/* 페이지 번호에 스타일 적용하기 (예: 여백과 색상) */
a.btn_page_num {
    margin: 0 5px; /* 좌우 여백 조정 */
    padding: 5px 10px; /* 위아래 여백 조정 */
    background-color: #007bff; /* 배경색 지정 */
    color: #fff; /* 글자색 지정 */
    border-radius: 5px; /* 모서리 둥글게 만들기 */
    text-decoration: none; /* 밑줄 제거 */
}

/* 활성 페이지 번호 스타일 (예: 다른 배경색 적용) */
a.btn_page_num.active {
    background-color: #ff5722; /* 활성 페이지 배경색 변경 */
}
.side {
    float: left; /* 왼쪽으로 부유시킵니다. */
    width: 15%; /* 원하는 너비로 조정하세요. */
}

/* "contents_inner" div의 스타일 */
.contents_inner {
    float: left; /* 왼쪽으로 부유시킵니다. */
    width: 70%; /* "side" div와 함께 100%가 되도록 너비 조정하세요. */
}
.section_wrap{
	margin-left:600px;
	
}
.title_wrap.title_size_lg.has_sub_title {
    width:1000px;
}

.top-button {
    display: none;
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 50px;
    height: 50px;
    background-color: #007BFF;
    color: #fff;
    border-radius: 50%;
    font-size: 24px;
    text-align: center;
    line-height: 50px;
    cursor: pointer;
    z-index: 9999;
}

.top-button:hover {
    background-color: #0056b3;
}
</style>

<body>
<%@ include file="../header/Header.jsp" %>
<div class="wrapper" id="mainDiv">
<main class="container_wrapper">
<!-- breadcrumb_wrap -->
<section class="breadcrumb_wrap">
    <div class="breadcrumb_inner">
        <ol class="breadcrumb_list">
            <li class="breadcrumb_item"><a href="/" class="home_link">HOME</a></li>
        </ol>
    </div>
</section>
<!-- //breadcrumb_wrap -->
	<div style=""></div> <!--  화면 옆 -->
<!-- contents_wrap -->
<section class="contents_wrap aside">
    <div class="side">
    </div>
    <div class="contents_inner">
        <!-- LNB -->


        <!-- contents -->
        <section id="contents" class="section_wrap">
            <!-- aside 구분에 따른 Title 문구 변경 -->
            <div class="title_wrap title_size_lg has_sub_title">
                <h1 class="title_heading"><span class="hidden">교보문고 </span>    
                <!-- // 추가 220509 sub_title_wrap 구조 추가, 집계기준 버튼 추가 -->
                ${genre}책<span>판매</span> 리스트
                <input type="hidden" value="${genre}" id="genreid">
                <span class="hidden">셀러</span></h1>
                <div class="sub_title_wrap">
                    <p class="info_text"></p>
                    최고의 도서 판매 사이트 책읽는 사람들  
                    <div class="right_area">
                        <div class="form_sel type_sm" data-class="type_sm">
						<select title="목록 보기 유형 선택" id="selListPer" onchange="updateLocation()">
						    <option value="popular">인기순</option>
						    <option value="sales">판매순</option>
						    <option value="newest">최신순</option>
						    <option value="highprice">높은가격순</option>
						    <option value="lowprice">낮은가격순</option>
						</select>
                        </div>     
                    </div>
                </div>
                
                <div class="list_result_wrap">
                    <!-- right_area(찜하기, 장바구니, Excel다운로드) -->
                    <div class="right_area">
                        <div class="item_group">
                            <span class="form_chk">
                                <input id="chkAllBestsellerChk" type="checkbox">
                                <label for="chkAllBestsellerChk">전체선택</label>
                            </span>
                            
                            <button type="button" id="btnwish" class="btn_wish size_sm" data-kbbfn="wish-item-list" data-kbbfn-myrcode="001" data-kbbfn-nbopcode="001" data-kbbfn-list="#tabRoot .prod_list">
                                <span class="ico_wish"></span>
                                <span class="hidden">찜하기</span>
                            </button>
                            <button type="button" class="btn_sm btn_line_gray" id="allAddcart">
                                <span class="ico_cart"></span>
                                <span class="text">장바구니</span>
                            </button>
                        </div>
                        <div class="item_group">        
                        </div>
                    </div>
                </div>
                <!-- list contents -->
                <div class="view_type_list switch_prod_wrap">
                    <!-- List -->
                    <c:forEach items="${albook}" var="alist">
                     <input type="hidden" value="${alist.genre}" id="genre">
                        <ol class="prod_list" style="">
                            <li class="prod_item" data-id="S000208719388">
                                <div class="prod_chk_group">
                                    <span class="form_chk no_label">
										<input id="chkBest-${alist.seq}" value="${alist.seq}" type="checkbox">
										<label for="chkBest-${alist.seq}">
										    <span class="hidden">상품선택</span>
										</label>
                                    </span>
                                </div>
                                <div class="prod_area horizontal">
                                    <div class="prod_thumb_box size_lg">
                                        <a class="prod_link" href="/korBook/detail?seqno=${alist.seq}">

                                            <span class="img_box">
                                                <img alt="상품 준비중" src="../img/prodmain/${alist.img}" id="productImage-${alist.seq}">
                                            </span>
                                        </a>
                                    </div>
                                    <div class="prod_info_box">
                                        <div class="prod_rank">
                                        </div>
                                        <a href="/korBook/detail?seqno=${alist.seq}" class="prod_info">
                                            <span class="prod_name">${alist.name}</span>
                                        </a>
                                        <span class="prod_author">${alist.author} <span class="date"> · ${alist.created}</span></span>
                                        <span class="prod_author">${alist.genre}</span>
                                        <div class="prod_price">
                                            <span class="price"><span class="val">${alist.price }</span><span class="unit">원</span></span>
                                            <span class="gap">|</span>
                                        </div>
                                        <p class="prod_introduction">
                                        <c:if test="${alist.info == null}">
                                        	준비중입니다...
                                        </c:if>
                                        <c:if test="${alist.info != null}">
                                        	${alist.info}
                                        </c:if>
                                        </p>
                                        <div class="prod_bottom">
                                            <div class="review_summary_wrap type_sm">
                                                <span class="review_klover_box">
                                                    <span class="review_klover_text font_size_xxs">${alist.averageRating}</span>
                                                    <span class="review_desc">(${alist.reviewCount}개의 리뷰)</span>
                                                </span>
                                                <span class="gap">/</span>
                                                <span class="review_quotes_text font_size_xxs" id="randomPhrase">최고예요</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="prod_btn_wrap">
                                    <button data-kbbfn="wish-item" data-kbbfn-myrcode="001" data-kbbfn-nbopcode="001" data-kbbfn-id="S000208719388" type="button" class="btn_wish_icon">
                                        <span class="ico_wish"></span>
                                        <span class="hidden">관심 등록</span>
                                    </button>
                                    <div class="btn_wrap full">
                                        <button type=button class="btn_sm btn_light_gray" id="btncart">
                                            <span class="text">장바구니</span>
                                        </button>
                                        <button type=button class="btn_sm btn_primary" id="btnbuy">
                                            <span class="text">바로구매</span>
                                        </button>
                                    </div>
                                </div>
                            </li>
                        </ol>
                    </c:forEach>
                    <div class="pagination-container">
                        <div class="pagestr">${pagestr}</div>
                    </div>
                </div>
                </div>   
            </section>
        </div>
    </section>
</main>
        <!-- // 윙배너 -->
<div class="top-button" id="topButton">&#9650;</div>
    </div>
    
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function() {
    $('#korBook tbody').on('click', 'img', function() {
        let seqno = $(this).closest('tr').find('td:eq(0)').text();
		let url = '/korBook/detail?seqno=' + seqno
        document.location = url;
        return false;
    });
    $("#chkAllBestsellerChk").click(function() {
        let isChecked = $(this).prop("checked");
        $(".prod_item input[type='checkbox']").prop("checked", isChecked);
    });
    $("#allAddcart").click(function() {
        // 선택된 체크박스의 값을 저장할 배열
        let seqlist = [];
        // 모든 체크박스를 순회하며 선택된 것만 가져옴
        $(".prod_item input[type='checkbox']:checked").each(function() {
            // 각 체크박스의 값을 가져와 배열에 추가
            let value = $(this).val();
            seqlist.push(value);
        });
        // 선택된 체크박스의 값을 확인 (개발자 도구의 콘솔에 출력)
        console.log(seqlist);
        $.ajax({
            url: '/korBook/addcart',
            type: 'GET',
            data: { 'seqlist[]': seqlist }, // 'seqlist[]'로 변경
            dataType: 'text',
            success: function(response) {
                $('#labelqty').text(response);
                alert("상품을 장바구니에 담았습니다!");
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert("이미 담은 상품입니다.");
            }
        });
    });
})
.on("click","#btnbuy",function(){
	if(${userid==""}) {
		alert("로그인이 필요합니다.")
		return false;
	}
    let seqno = $(this).closest('.prod_item').find('.prod_link').attr('href').split('=')[1];
    let url = '/korBook/buyment?seqno=' + seqno
    document.location = url;
    return false;
})
.on("click","#soldout",function(){
	if($('#soldout').val()=="매진"){
		alert("매진되었습니다.")
		return false;
	}
})
.on("click","#soldcart",function(){
	
		alert("매진되었습니다.")
		return false;
	
})
.on("click", "#btncart", function() {
    // 클릭한 버튼이 속한 상품의 seqno를 가져옴
    let seqno = $(this).closest('.prod_item').find('.prod_link').attr('href').split('=')[1];
    $.ajax({
        url: '/korBook/addcart',
        data: { seqno: seqno }, // 'seqno'로 변경
        type: 'get',
        dataType: 'text',
        success: function(data) {
            // 서버에서 받은 새로운 장바구니 수량을 업데이트
            $('#labelqty').text(data);
            // 장바구니에 상품을 추가한 후의 알림 메시지
            alert("상품을 장바구니에 담았습니다.")
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log('Error:', textStatus, errorThrown); // 에러 발생 시 출력
        	if(${userid==""}){
        		alert("로그인이 필요합니다.")
        		return false;
        	}
            alert("이미 담은 상품입니다.")
        }
    });
})
.on('click','#btnwish',function(){
	alert("준비중입니다.")
})
.on('click','.ico_wish',function(){
	alert("준비중입니다.")
})
/* .on('click', '.btndel', function() {
    let currentRow = $(this).closest('tr');
    let imgSrc = currentRow.find('.fixed-image').attr('src');
    let imgFileName = imgSrc.substring(imgSrc.lastIndexOf('/') + 1);
    let subFileName = currentRow.find('#prodinfo').val();
    let seqno = currentRow.find('td:eq(0)').text();

    $.ajax({
        url: '/deleteImage/' + imgFileName + '/' + subFileName + '/' + seqno,
        type: 'DELETE',
        success: function(response) {
            console.log(response);
            // AJAX 요청 성공 후 엘리먼트 제거
            currentRow.remove();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log('Error:', textStatus, errorThrown);
        }
    })
}) */
document.addEventListener("DOMContentLoaded", function () {
	  const selectedOption = localStorage.getItem("selectedOption");
	  if (selectedOption) {
	    const selListPer = document.getElementById("selListPer");
	    selListPer.value = selectedOption;
	  }
	});
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

	// 옵션 변경 시 localStorage에 선택한 옵션을 저장합니다.
	function updateLocation() {
	  const selListPer = document.getElementById("selListPer");
	  const selectedOption = selListPer.value;

	  localStorage.setItem("selectedOption", selectedOption);
	  if($('#genreid').val()!="전체"){
		  location.href = '/korBook/bookoption?optSort=' + selectedOption + '&genre=' + $('#genre').val();
	  } else {
		  location.href = '/korBook/bookoption?optSort=' + selectedOption
	  }

	}
    var randomPhrases = [
        "정말 좋아요!",
        "최고예요!",
        "완벽합니다!",
        "놀라운 경험!",
        "강력 추천합니다!"
    ];

    var productList = document.querySelectorAll(".review_quotes_text.font_size_xxs");
    productList.forEach(function (productElement) {
        var randomIndex = Math.floor(Math.random() * randomPhrases.length);
        var randomPhrase = randomPhrases[randomIndex];
        productElement.textContent = randomPhrase;
    });
</script>
</html>