<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
<body>
<h1>회원 관리</h1>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }

    h1 {
        text-align: center;
        margin: 20px 0;
    }

    #tblBoard {
        width: 100%;
        border-collapse: collapse;
        margin: auto;
        background-color: white;
    }

    #tblBoard th, #tblBoard td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: center;
    }

    #tblBoard th {
        background-color: #333;
        color: white;
    }

    #memberlist tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    #memberlist tr:hover {
        background-color: #ddd;
    }
    #memberdelete {
        display: block;
        margin: 20px auto;
        padding: 10px 20px;
        background-color: #f44336;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    #memberdelete:hover {
        background-color: #d32f2f;
    }

    #homeLink {
        display: block;
        margin: 20px auto;
        text-align: center;
        text-decoration: none;
        color: #333;
        border: 1px solid #333;
        padding: 5px 10px;
        border-radius: 4px;
    }

    #homeLink:hover {
        background-color: #ddd;
    }
</style>
<table id=tblBoard >
<thead>
	<tr><th></th><th>아이디</th><th>이름</th><th>성별</th><th>생일</th><th>전화번호</th><th>가입일자</th></tr>
</thead>
<tbody id=memberlist>

<c:forEach items="${memberlist}" var="memberlist" varStatus="loop">
<tr>
	<td><input type=checkbox class="checkbox" name=checkbox></td>
	<td><div></div>${memberlist.userid}</td>
	<td>${memberlist.name}</td>
	<td>${memberlist.gender}</td>
	<td>${memberlist.birthday}</td>
	<td>${memberlist.mobile}</td>
	<td>${memberlist.created}</td>
</tr>
</c:forEach>
</tbody>
</table>
<a href="/">홈으로</a>
<input type=button id=memberdelete value=삭제>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function() {
    $('.checkbox').click(function() {
        $('.checkbox').not(this).prop('checked', false);
    });
})
.on('click', '#memberdelete', function() {
    let checkbox = $("input[name=checkbox]:checked");
    if (checkbox.length === 0) {
        alert('체크하세요');
    } else {
        let tr = checkbox.parent().parent();
        tr.each(function() {
            let td = $(this).children();
            let userid = td.eq(1).text();
            console.log(userid);
            document.location='/memberdelete?id='+userid;
        });
        return false;
    }
});

</script>
</html>