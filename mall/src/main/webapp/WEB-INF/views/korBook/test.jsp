<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</style>

<body>
<%@ include file ="../header/Header.jsp" %>
<div class="wrapper" id="mainDiv">
<main class="container_wrapper">
    <!-- breadcrumb_wrap -->
    <section class="breadcrumb_wrap">
        <div class="breadcrumb_inner">
            <ol class="breadcrumb_list">
                <li class="breadcrumb_item"><a href="/" class="home_link">HOME</a></li>
<!--                         <li class="breadcrumb_item">
                            <a href="https://product.kyobobook.co.kr/bestseller/online" class="btn_sub_depth">
                                <span id="depthTitle">온라인 베스트</span>
                            </a>
                        </li> -->
<!--                         <li class="breadcrumb_item">
                            <a class="btn_sub_depth">
                                <span id="tabTitle">전체</span>
                            </a>
                        </li> -->
                <!-- 외국도서 하위 탭 활성화 -->
            </ol>
        </div>
    </section>
    <!-- //breadcrumb_wrap -->

    <!-- contents_wrap -->
   <section class="contents_wrap aside">
       <div class="contents_inner">
           <!-- LNB -->
           <aside class="aside_wrap">      
               <div class="aside_header">
                   <div class="title_wrap title_size_xxl">
                       <span class="title_heading">도서 판매</span>
                   </div>
               </div>

               <div class="aside_body">
                   <div class="snb_wrap">
                       <ul class="snb_list category">
                           <li class="snb_item">
                               <a href="/bestseller/total?period=002" class="snb_link depth_title">종합 베스트</a>
<!--                                <ul class="snb_list">
                                   <li class="snb_item">
                                       <a href="/bestseller/total?period=002" class="snb_link">주간</a>
                                   </li>
                                   <li class="snb_item">
                                       <a href="/bestseller/total?period=003" class="snb_link">월간</a>
                                   </li>
                                   <li class="snb_item">
                                       <a href="/bestseller/total?period=004" class="snb_link">연간</a>
                                   </li>
                               </ul> -->
                           </li>
                           <li class="snb_item">
                               <a href="/bestseller/online?period=001" class="snb_link depth_title">온라인 베스트</a>
<!--                                <ul class="snb_list">
                                   <li class="snb_item active">
                                       <a href="/bestseller/online?period=001" class="snb_link">일간</a>
                                   </li>
                                   <li class="snb_item">
                                       <a href="/bestseller/online?period=002" class="snb_link">주간</a>
                                   </li>
                                   <li class="snb_item">
                                       <a href="/bestseller/online?period=003" class="snb_link">월간</a>
                                   </li>
                               </ul> -->
                           </li>
                           <li class="snb_item">
                               <a href="/bestseller/realtime" class="snb_link depth_title"></a>
                           </li>
                           <li class="snb_item">
                               <a href="/bestseller/store?period=002" class="snb_link depth_title"></a>
                           </li>
                           <li class="snb_item">
                               <a href="/bestseller/person?period=001" class="snb_link depth_title"></a>
<!--                                <ul class="snb_list">
                                   <li class="snb_item">
                                       <a href="/bestseller/person?period=001" class="snb_link">일간</a>
                                   </li>
                                   <li class="snb_item">
                                       <a href="/bestseller/person?period=002" class="snb_link">주간</a>
                                   </li>
                                   <li class="snb_item">
                                       <a href="/bestseller/person?period=003" class="snb_link">월간</a>
                                   </li>
                               </ul> -->
                           </li>
                           <li class="snb_item">
                               <a href="/bestseller/steady" class="snb_link depth_title">스테디셀러</a>
                           </li>
                       </ul>
                   </div>
               </div>
           </aside>

           <!-- contents -->
    <section id="contents" class="section_wrap">
                <!-- aside 구분에 따른 Title 문구 변경 -->
                <div class="title_wrap title_size_lg has_sub_title">
                    <h1 class="title_heading"><span class="hidden">교보문고 </span>    
                    <!-- // 추가 220509 sub_title_wrap 구조 추가, 집계기준 버튼 추가 -->
                    전체 <span>판매</span> 리스트
                    <span class="hidden">셀러</span></h1>
                    <div class="sub_title_wrap">
                        <p class="info_text"></p>
                            최고의 도서 판매 사이트 책읽는 사람들  
        <div class="right_area">
            <div class="form_sel type_sm" data-class="type_sm">
                <select title="목록 보기 유형 선택" id="selListPer" style="display: none;">
                    <option value="20">20개씩 보기</option>
                    <option value="50">50개씩 보기</option>
                </select>
                <span tabindex="0" id="selListPer-button" role="combobox" aria-expanded="false" aria-autocomplete="list" aria-owns="selListPer-menu" aria-haspopup="true" title="목록 보기 유형 선택" class="ui-selectmenu-button ui-button ui-widget ui-selectmenu-button-closed ui-corner-all" aria-activedescendant="ui-id-27" aria-labelledby="ui-id-27" aria-disabled="false" style="position: relative;">
                    <span class="ui-selectmenu-icon ui-icon ui-icon-triangle-1-s"></span>
                    <span class="ui-selectmenu-text">20개씩 보기</span>
                    <div dir="ltr" class="resize-sensor" style="position: absolute; inset: -10px 0px 0px -10px; overflow: hidden; z-index: -1; visibility: hidden;">
                        <div class="resize-sensor-expand" style="position: absolute; left: -10px; top: -10px; right: 0; bottom: 0; overflow: hidden; z-index: -1; visibility: hidden;">
                            <div style="position: absolute; left: 0px; top: 0px; transition: all 0s ease 0s; width: 100000px; height: 100000px;"></div>
                        </div>
                        <div class="resize-sensor-shrink" style="position: absolute; left: -10px; top: -10px; right: 0; bottom: 0; overflow: hidden; z-index: -1; visibility: hidden;">
                            <div style="position: absolute; left: 0; top: 0; transition: 0s; width: 200%; height: 200%"></div>
                        </div>
                    </div>
                </span>
            </div>
            <div class="switch_list_btn_wrap" data-target="#tabRoot .switch_prod_wrap">
                <button type="button" class="btn_sm btn_line_gray ico_list active" data-type="list"><span class="hidden">리스트형으로 보기</span></button>
                <button type="button" class="btn_sm btn_line_gray ico_img" data-type="img"><span class="hidden">이미지형으로 보기</span></button>
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
                    
                    <button type="button" class="btn_wish size_sm" data-kbbfn="wish-item-list" data-kbbfn-myrcode="001" data-kbbfn-nbopcode="001" data-kbbfn-list="#tabRoot .prod_list">
                        <span class="ico_wish"></span>
                        <span class="hidden">찜하기</span>
                    </button>
                    <button type="button" class="btn_sm btn_line_gray" data-kbbfn="cart-item" data-kbbfn-cartlist="#tabRoot .prod_list" data-kbbfn-cartallcheck="#tabRoot #chkAllBestsellerChk">
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
            <ol class="prod_list" style="">
                <li class="prod_item" data-id="S000208719388">
                    <div class="prod_chk_group">
                        <span class="form_chk no_label">
                            <input id="chkBest11" type="checkbox">
                            <label for="chkBest11">
                                <span class="hidden">상품선택</span>
                            </label>
                        </span>
                        <div class="rank_status  ">
                            <span class="hidden">변동 없음</span>
                        </div>
                    </div>
                    <div class="prod_area horizontal">
                        <div class="prod_thumb_box size_lg">
                            <a class="prod_link" href="https://product.kyobobook.co.kr/detail/S000208719388">
                                <span class="img_box">
                                    <img loading="lazy" alt="상품 준비중" src="../img/prodmain/${alist.img}">
                                </span>
                            </a>
                        </div>
                        <div class="prod_info_box">
                            <div class="prod_rank">
                                <div class="badge_flag badge_green best">
                                    <!-- <span class="text"> Best <span class="fw_bold">1</span></span> -->
                                </div>
                            </div>
                            <div class="prod_badge">
                                <span class="badge_md badge_line_primary rep"><span class="text">MD의 선택</span></span>
                                <span class="badge_md badge_line_gray rep"><span class="text">최고매출</span></span>
                                <span class="badge_md badge_line_gray rep"><span class="text">인기</span></span>
                                <span class="badge_md badge_line_gray rep"><span class="text">최다판매량</span></span>
                                <span class="badge_md badge_line_gray rep"><span class="text">베스트셀러</span></span>
                            </div>
                            <a href="" class="prod_info">
                                <span class="prod_name">${alist.name}</span>
                            </a>
                            <span class="prod_author">${alist.author} <span class="date"> · 2023.09.06</span></span>
                            <div class="prod_price">
                                <!-- <span class="percent">10%</span> -->
                                <span class="price"><span class="val">${alist.price }</span><span class="unit">원</span></span>
                                <!-- <span class="price_normal"><span class="text">정가</span><s class="val">19,500원</s></span> -->
                                <span class="gap">|</span>
                                <span class="point">970p</span>
                            </div>
                            <p class="prod_introduction">무라카미 하루키의 신작 장편소설 『도시와 그 불확실한 벽』은 집필과 출간에 얽힌 이야기가 특별</p>
                            <div class="prod_bottom">
                                <div class="review_summary_wrap type_sm">
                                    <span class="review_klover_box">
                                        <span class="review_klover_text font_size_xxs">8.09</span>
                                        <span class="review_desc">(31개의 리뷰)</span>
                                    </span>
                                    <span class="gap">/</span>
                                    <span class="review_quotes_text font_size_xxs">최고예요</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="prod_order_state">
                        <span class="badge_sm badge_pill badge_primary">
                            <span class="text">예약판매</span>
                        </span>
                        <p class="order_state_desc">
                            <span class="fw_bold">9월 6일 </span>
                            <br>출고예정
                        </p>
                    </div>
                    <div class="prod_btn_wrap">
                        <button data-kbbfn="wish-item" data-kbbfn-myrcode="001" data-kbbfn-nbopcode="001" data-kbbfn-id="S000208719388" type="button" class="btn_wish_icon">
                            <span class="ico_wish"></span>
                            <span class="hidden">관심 등록</span>
                        </button>
                        <div class="btn_wrap full">
                            <a data-kbbfn="cart-item" data-kbbfn-dvsncode="KOR" data-kbbfn-grpcode="SGK" data-kbbfn-pid="S000208719388" data-kbbfn-adult="0" class="btn_sm btn_light_gray">
                                <span class="text">장바구니</span>
                            </a>
                            <a data-kbbfn="cart-item" data-kbbfn-grpcode="SGK" data-kbbfn-pid="S000208719388" data-kbbfn-spbcode="001" data-kbbfn-adult="0" class="btn_sm btn_primary">
                                <span class="text">바로구매</span>
                            </a>
                        </div>
                    </div>
                </li>
            </ol>
            </c:forEach>
				     <div class="pagination-container">
				        <div>${pagestr}</div>
				    </div>
        		</div>
        	</div>
        </section>
        </div>
        </section>
     
</main>
        <!-- 윙배너 -->
        <section class="fly_menu_wrapper sps sps--abv sps-abv" id="fly_wing_banner" data-sps-offset="121">
            <div class="fly_menu_inner">
                <a href="javascript:void(0)" class="fly_menu_banner" >
                    <img src="https://image.kyobobook.co.kr/newimages/adcenter/IMAC/creatives/2023/08/31/69547/22.jpg" alt="도둑맞은 집중력">
                </a>
            </div>
        </section>
        <!-- // 윙배너 -->
        <div class="floating_wrapper">
            <!-- 탑버튼 -->
            <a href="#top" class="btn_go_top" title="최상위 화면으로">
                <span>TOP</span>
            </a>
            <!-- // 탑버튼 -->
                </div>
            </div>
</body>
</html>
</html>