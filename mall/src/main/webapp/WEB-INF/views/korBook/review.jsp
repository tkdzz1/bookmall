<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta userid="viewport" content="width=device-width, initial-scale=1.0">
<title>리뷰게시판</title>
<link rel="stylesheet" href="../css/g_board.css">
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
    <header class=hboard>
        <h1>리뷰게시판</h1>
    </header>
    <main>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th style="width:500px">제목</th>
                    <th>작성자</th>
                    <th>작성일자</th>
                    <th>최종수정일</th>
                    <th>조회수</th>
                </tr>
            </thead>
             <tbody id=board>
            <c:forEach items="${alreview}" var="alist">
                <tr>
                    <td>${alist.seqno}</td>
                    <td><a href="/r_view?reviewNum=${alist.seqno}">${alist.title}</a></td>
                    <td>${alist.writer}</td>
                    <td>${alist.created}</td>
                    <td>${alist.updated}</td>
                    <td>${alist.hit}</td>
                </tr>
            </c:forEach>
                <tr>
            </tbody>
        </table>
    </main>
    <table class="pageTable">
	<tr>
	<%-- <td style='text-align:left'>${prev}&nbsp;${next}</td> --%>
	<td style='font-size:24px;'>${pagestr}</td>
	</tr>
	<tr>
	<td><input type="button" id=btnSend value=글쓰기></td>
	</tr>
	</table>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#boardUl > li',function(){
	alert($(this).attr("id"));
})
.on('click','#btnSend',function(){
	document.location="/korBook/r_write"
})
</script>
</html>