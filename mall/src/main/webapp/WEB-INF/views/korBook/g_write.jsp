<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link rel="stylesheet" href="css/g_write.css">
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
<section class="content">
<main>
<h1>게시글 작성</h1>
<form id="frmwrite" method="post" action="/boardInsert" enctype="multipart/form-data">
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" required>
        <label for="author">작성자:</label>
        <input type="text" id="author" name="author" value="${userid}" readonly required>
        <label for="content">내용:</label>
        <textarea id="content" name="content" required></textarea>
        <label>첨부파일</label>
        <input type="file" name="image1" accept="image/*"><br><br>
        <input type="submit" id="btnSend" value="작성">&nbsp;
        <input type="button" id="btncancel" value="취소">
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
.on('click','#btncancel',function(){
	document.location="/korBook/g_board";
})
;
</script>
</html>