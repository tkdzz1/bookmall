<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta userid="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판</title>
<link rel="icon" type="image/x-icon" href="/logoimg/iconV2.jpg">
<link rel="stylesheet" href="/css/g_board.css">
<style>
.content {
    background-color: #fff;
    margin: 20px;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    text-align: center;
}
.options {
    margin-top: 20px;
}

.option {
    display: inline-block;
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    text-decoration: none;
    margin: 5px;
    border-radius: 5px;
}
</style>
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
<section class="content">
    <main>
    	<h1>자유게시판</h1>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th style="width:500px">제목</th>
                    <th>작성자</th>
                    <th>최종수정일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody id=board>
            <c:forEach items="${getBoard}" var="getBoard">
                <tr>
                    <td>${getBoard.num}</td>
                    <td><a href="/g_view?boardNum=${getBoard.num}">${getBoard.title}</a></td>
                    <td>${getBoard.userid}</td>
                    <td>${getBoard.updated}</td>
                    <td>${getBoard.hit}</td>
                </tr>
            </c:forEach>
                <tr>
            </tbody>
        </table>
        
	    <table class="pageTable">
		<tr>
		<td style='font-size:24px;'>${pagestr}</td>
		</tr>
		<td>
		<c:if test="${userid!=''}">
		<input type="button" id=btnSend value=글쓰기>
		</c:if>
		</table>
    </main>
</section>
<section class="content">
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
.on('click','#boardUl > li',function(){
	alert($(this).attr("id"));
})
.on('click','#btnSend',function(){
	document.location="/g_write"
})
</script>
</html>