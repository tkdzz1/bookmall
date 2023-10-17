<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
<link rel="stylesheet" href="css/g_write.css">
</head>
<%@ include file ="../header/Header.jsp" %>
<body>

<section class="content">
<main>
<h1>게시글 수정</h1>
<form id="post" method="post" action="/boardUpdate" enctype="multipart/form-data"> <!--업로드파일 수정을위해 추가-->
		<input type="hidden" id="boardNum" name="boardNum" value="${findingBoard.num}">
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="${findingBoard.title}" required>
        <label for="author">작성자:</label>
        <input type="text" id="author" name="author" value="${userid}" readonly required>
        <label for="content">내용:</label>
        <!--원본 이미지 보여주는 태그 추가-->
        <img id="ogIMG" src='../img/board_img/${findingBoard.g_img}' style='width:190px; height:200px;' onerror="this.style.display='none'">
        <input type="button" id="btnImgDelete" value="이미지 제거"> 
        <textarea id="content" name="content" required>${findingBoard.content}</textarea>
        <!--첨부파일 수정을 위한 내용 추가 -->
        <label>첨부파일 변경</label>
        <input type="text" id="ogFileName" name="ogFileName" value="${findingBoard.g_img}" style="border:0px">
        <input type="hidden" id="ofnHidden" name="ofnHidden" value="${findingBoard.g_img}">
        <input type="file" name="image1" id="image1" accept="image/*" ><br><br>
        <input type="submit" id="btnSend" value="수정">
</form>
</main>
</section>
<section class="content" style="text-align: center;">
        <h1>책 파는 사람들 자유게시판</h1>
        <div class="options">
            <a href="/g_FAQ" class="option">자주묻는질문(FAQ)</a>
            <a href="/g_question" class="option">문의하기</a>
        </div>
</section>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('submit','#btnSend',function(){
	if($('#title').val()==''){
		alert('제목을 입력하시오'); return false;
	}
	if($('#content').val()==''){
		alert('게시물 내용을 입력하시오'); return false;
	}
	return true;
})
// 원래 업로드 됐던 이미지 제거를 위해 추가
.on('click','#btnImgDelete',function(){
	$("#ogIMG").remove();
	$("#btnImgDelete").remove();
	$('#ogFileName').val("");
})
;
</script>
</html>