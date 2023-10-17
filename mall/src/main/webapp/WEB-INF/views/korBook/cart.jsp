<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="../css/cart.css">
  <title>장바구니</title>
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
<c:if test="${cartEmptyMessage ==''}">
<form action="cartpayment" method="post" id="frmcart">
 <div class="cart-container">
   <h1>장바구니</h1>
   <div class="cart-items">
	 <c:forEach items="${book}" var="alist" varStatus="loop">
      <input type="hidden" name="hidprodid${loop.index}" id="hidprodid${loop.index}" value="${alist.prodid}">
      <input type="hidden" name="hidprodname${loop.index}" id="hidprodname${loop.index}" value="${alist.name}">
      <input type="hidden" id="hidprodprice${loop.index}" value="${alist.price}">
      
     <div class="cart-item" id="div">
       <img src="../img/prodmain/${alist.img}" alt="책 이미지">
       <div class="item-details">
         <h2><label id="name">책 제목:${alist.name}</label></h2>
         <p><label id="author">작가:${alist.author}</label></p>
         <p>가격:<label id="price">${alist.price}</label></p>
         <input type="button" id="btndelete${loop.index}" class="remove-button" name="deleted" value="삭제">
         <p>수량:</p><input type="number" name="qtynum${loop.index}" id="qtynum${loop.index}" value="1" min="1">
         <p>총액:</p><input type="number" name="qtysum${loop.index}" id="qtysum${loop.index}" min="0" value="${alist.price}" readonly >
       </div>
     </div>
     </c:forEach>
        		<a href="/korBook/korbook">이전</a>
   </div>
   <div class="cart-summary">
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
     <p>총 가격:&nbsp;<label id="totalsum"></label></p>
     <input type="submit" id="btncash" class="checkout-button" value="결제하기">
   </div>
</div>
</form>
</c:if>
<c:if test="${cartEmptyMessage != ''}">
 <div class="cart-container">
   <h1>장바구니</h1>
   <div class="cart-items">
	     <div class="cart-item" id="div">
			<p>${cartEmptyMessage}</p>
	     </div>
   </div>
</div> 
</c:if>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function() { 
	$('#sum').val($('#totalsum').text());
	updateTotalSum();
	console.log($('#qtysum').val())
	$('#labelqty').text(${count});
})
  // 수량 조정 시 이벤트 핸들러
.on('input', 'input[id^="qtynum"]', function() {
    let index = $(this).attr('id').replace('qtynum', '');
    let qty = parseInt($(this).val());
    let price = parseInt($('#hidprodprice' + index).val());
    let totalPrice = qty * price;
    $('#qtysum' + index).val(totalPrice);
    updateTotalSum()
    console.log($('#qtynum0').val());
})
.on('click', '#btndelete', function(){
    $(this).closest('#div').remove();
})
.on('click', '.remove-button', function() {
    let index = $(this).attr('id').replace('btndelete', ''); // 버튼의 인덱스 추출
    let prodid = $('#hidprodid' + index).val(); // 해당 인덱스에 대응하는 prodid 값 가져오기
    console.log('prodid:', prodid);
    document.location="/korBook/deletecart?prodid=" + prodid;
    // 이후의 동작
    // ...
}); 
function updateTotalSum() {
	  let totalSum = 0;
	  $('input[id^="qtysum"]').each(function() {
	    totalSum += parseInt($(this).val());
	  });
	  $('#totalsum').text(totalSum);
	  $('#sum').val(totalSum);
	  // 마일리지 적립
	}

</script>
</html>