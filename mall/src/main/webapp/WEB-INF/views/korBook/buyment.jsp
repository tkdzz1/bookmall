<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script>
        $(document).ready(function() {
            $("#qty").on("input", function() {
                var quantity = parseInt($(this).val());
                var unitPrice = parseInt("${book.price}");
                var totalPrice = quantity * unitPrice;
                $("#sum").val(totalPrice);
            });
        });
    </script>
    <link href="../css/buyment.css" rel="stylesheet"/>
    <meta charset="UTF-8">
    <title>책 결제</title>
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
    <header class="header">
        <h1>책 결제</h1>
    </header>
    <div class="container">
        <div class="book-details">
            <img class="custom-image" src="../img/prodmain/${book.img}" alt="책 이미지">
            <div class="book-info">
                <div class="book-title">상품명: ${book.name}</div>
                <div class="book-author">저자: ${book.author}</div>
                <div class="book-price">가격: ${book.price} 원</div>
            </div>
        </div>
    </div>
    <form action="/korBook/Payment" method="post" id="frmpay">
                <table class="custom-table customer-info">
                <tr>
                    <th>항목</th>
                    <th>내용</th>
                </tr>
                <tr>
                    <td>아이디:</td>
                    <td>${customer.userid}</td>
                </tr>
                <tr>
                    <td>이름:</td>
                    <td>${customer.name}</td>
                </tr>
                <tr>
                    <td>성별:</td>
                    <td>${customer.gender}</td>
                </tr>
                <tr>
                    <td>생년월일:</td>
                    <td>${customer.birthday}</td>
                </tr>
                <tr>
                    <td>모바일:</td>
        			<td><input class="mobilestyle" type="text" id="mobile" name="mobile" size="16" value='${customer.mobile}'></td>
                </tr>
                <tr>
                    <td>이메일:</td>
                    <td><input class="form-input" type="text" id="email" name="email" size="16" value="${customer.email}"></td>
                </tr>
                <tr>
                    <td>배송지:</td>
                    <td><input class="form-input" type="text" id="address_kakao" name="address" value="${customer.address}" readonly /></td>
                </tr>
                <tr>
                    <td>상세주소:</td>
                    <td><input class="form-input" type="text" name="address_detail" value=" ${customer.address_detail}"/></td>
                </tr>
            </table>
    <div class="container2">
        
            <div class="form-group">
                <label>구매 수량:</label>
                <input class="custom-input" type="number" id="qty" name="qty" min="1" required>
            </div>
            <div class="form-group">
                <label>총 구매금액:</label>
                <input class="custom-input" type="text" id="sum" name="sum" readonly>
            </div>
            <input type="hidden" name="prodid" id="prodid" value="${book.seq}">
            <input type="hidden" name="prodname" value="${book.name}">
            <br><br>
			
            <input type="submit" class="btn-pay" value="결제">
            <br><br>
            <input type="button" id="cancle" class="btn-pay" value="취소">
    	</div>
    </form>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on('click', '#cancle', function(){
    document.location = "/korBook/detail?seqno=" + $('#prodid').val();
});
</script>
</html>
