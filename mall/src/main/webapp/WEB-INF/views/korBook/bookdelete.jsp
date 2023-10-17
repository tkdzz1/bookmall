<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
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
    .fixed-image {
	width: 150px; /* 원하는 너비로 설정 */
	height: 200px; /* 원하는 높이로 설정 */
}
</style>
<body>
<h1>상품 삭제</h1>
<table id=tblBoard >
<thead>
	<tr><th></th><th>상품번호</th><th>상품명</th><th>장르</th><th>작가명</th><th>가격</th><th>이미지</th></tr>
</thead>
<tbody id=memberlist>

<c:forEach items="${booklist}" var="list" varStatus="loop">
<tr>
	<td><input type=checkbox class="checkbox" name=checkbox></td>
	<td><div></div>${list.seq}</td>
	<td>${list.name}</td>
	<td>${list.genre}</td>
	<td>${list.author}</td>
	<td>${list.price}</td>
	<td><img src="../img/prodmain/${list.img}" class=".fixed-image" alt="이미지"></td>
	<td><input type="hidden" id="prodinfo" value="${list.prodinfo}"></td>
</tr>
</c:forEach>
</tbody>
</table>
<a href="/">홈으로</a>
<input type=button id=bookdelete value=삭제>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function() {
    $('.checkbox').click(function() {
        $('.checkbox').not(this).prop('checked', false);
    });

    $('#bookdelete').click(function() {
        let checkedRows = $("input[name=checkbox]:checked").closest('tr');
        
        if (checkedRows.length === 0) {
            alert('체크하세요');
        } else {
            checkedRows.each(function() {
                let prodid = $(this).find('td:eq(1)').text();
                let prodimg = $(this).find('img').attr('src');  
                prodimg = prodimg.substring(prodimg.lastIndexOf('/') + 1);
                let prodinfo = $(this).find('#prodinfo').val();
                document.location='/deletelist?prodimg=' + prodimg +'&prodinfo=' + prodinfo + '&prodid=' + prodid
                console.log('상품 번호:', prodid);
                console.log('이미지 경로:', prodimg);
                console.log('상품 정보:', prodinfo);
				
        
                // 여기서 원하는 작업을 수행하면 됩니다.
                // 예를 들어, AJAX 요청을 통해 삭제 처리 등을 할 수 있습니다.
            });
        }
    });
});
</script>
</html>