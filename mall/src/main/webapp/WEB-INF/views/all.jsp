<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>국내 카테고리</title>
</head>
<style>
table#korBook {
	border-collapse: collapse;
	width: 1000px;
	margin-left: auto;
	margin-right: auto;
}
table th {
	border: 1px solid green;
}
table td {
	border: 1px solid black;
}
th:nth-child(4) { 
	text-align: right;
	width: 170px;
}
</style>
<body>

<table>
<tr><td>
	<a href="/">홈으로</a>
</td></tr>
</table>
<h1 style="text-align:center;"><a href="/korBook">국내 도서 리스트</a></h1>
<table style="margin-left:auto;">
<tr><td>
<c:if test="${userid == ''}">
	<a href="/login" style="text-align:center;">로그인</a>&nbsp;&nbsp;
	<a href="/signup" style="text-align:center;">회원가입</a>
</c:if>
<c:if test="${userid != ''}">
	${userid}<a href="/logout">로그아웃</a>
</c:if>
</td></tr>
</table>
<table id="categori">
<tr><td><a href="/korNovel">소설</a></td></tr>
<tr><td><a href="/korHistory">역사</a></td></tr>
<tr><td><a href="/korEconomy">경제</a></td></tr>
<tr><td><a href="/korPolitics">정치</a></td></tr>
<tr><td><a href="/korComic">만화</a></td></tr>
</table>
<table id="korBook">
<thead>
<tr>
	<th><a href="/korAll">전체보기</a></th>
	<th>베스트셀러</th>
	<th>신상품</th>
	<th class="tbl">
    <select id="optSort" name="optSort">
        <option value="popular">인기순</option>
        <option value="sales">판매순</option>
        <option value="newest">최신순</option>
        <option value="highprice">높은가격순</option>
        <option value="lowprice">낮은가격순</option>
    </select>
    <input type="submit" value="검색">
</th>
</tr>
</thead>
<tbody>
<tr>
	<c:forEach items="${alNovel}" var="blist">
		<td><img src="img/${blist.img}" alt="이미지"></td>
		<tr><td>${blist.name}-${blist.price}원</td></tr>
	</c:forEach>
</tr>
</tbody>
</table>
</body>
</html>