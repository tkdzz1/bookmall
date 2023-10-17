<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 내역</title>
    <link href="../css/orderhistory.css" rel="stylesheet"/>
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
    <header>
        <h1>주문 내역</h1>
    </header>
    <main>
        <table class="order-table" id="tblorder">
            <thead>
                <tr>
                    <th>주문 번호</th>
                    <th>상품 번호</th>
                    <th>상품명</th>
                    <th>구매자</th>
                    <th>모바일</th>
                    <th>수량</th>
                    <th>주문 일자</th>
                    <th>가격</th>
                </tr>
            </thead>
            <tbody id="body">
            <c:forEach items="${orderlist}" var="alist">
                <tr data-orderid="${alist.seq}"  onclick="openOrderDetail('${alist.seq}')">
                    <td>${alist.seq }</td>
                    <td>${alist.prodid }</td>
                    <td>${alist.prodname}</td>
                    <td>${alist.userid }</td>
                    <td>${alist.mobile }</td>
                    <td>${alist.qty }</td>
                    <td>${alist.created }</td>
                    <td>${alist.sum }</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </main>
    <footer>
        <p>&copy; 2023 주문 내역 앱</p>
    </footer>

<div id="orderDetailModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>주문 상세 정보</h2>
    <table class="order-table" id="ordertable">
    </table>
  </div>
</div>
<script>
//팝업 열기
function openOrderDetail(orderId) {
  var modal = document.getElementById('orderDetailModal');
  modal.style.display = 'block';
  var orderTable = document.getElementById('ordertable');
  orderTable.innerHTML = '';
  // TODO: orderId를 사용하여 해당 주문의 상세 정보를 가져와서 테이블에 추가
  // 예시: Ajax 요청을 사용하여 서버에서 데이터를 가져와서 표에 추가
  $.ajax({
	  url:'/orderdetail',
	  data:{orderId:orderId},
	  type:'POST',
	  dataType:'json',
	  success: function(data){
		  console.log(data.seq);
		  $("#ordertable").append(
        		  "<tr><td>주문번호</td><td>"+ data.seq + "</td></tr>"+
        		  "<tr><td>아이디:</td><td>" + data.userid + "</td></tr>"+
        		  "<tr><td>상품번호:</td><td>" + data.prodid + "</td></tr>"+
        		  "<tr><td>상품명:</td><td>" + data.prodname + "</td></tr>"+
        		 "<tr><td>모바일:</td><td>" + data.mobile + "</td></tr>"+
        		"<tr><td>구매수량:</td><td>" + data.qty + "</td></tr>"+
        		 "<tr><td>구매금액:</td><td>" + data.sum + "</td></tr>"+
        		  "<tr><td>구매일자:</td><td>" + data.created + "</td></tr>"+
        		 "<tr><td>고객명:</td><td>" + data.name + "</td></tr>"+
        		  "<tr><td>성별:</td><td>" + data.gender + "</td></tr>"+
        		  "<tr><td>생년월일:</td><td>" + data.birthder + "</td></tr>"+
        		 "<tr><td>이메일:</td><td>" + data.email + "</td></tr>"+
        		 "<tr><td>주소:</td><td>" + data.address + "</td></tr>"+
        		 "<tr><td>상세주소:</td><td>" + data.address_detail + "</td></tr>" 
        		  )
	  },
	  error: function(jqXHR, textStatus, errorThrown) {
          console.log('Error:', textStatus, errorThrown);
	  }
  });
}
// 팝업 닫기
function closeOrderDetail() {
  var modal = document.getElementById('orderDetailModal');
  modal.style.display = 'none';
}
// 팝업 닫기 버튼 클릭 시 닫기
var closeBtn = document.querySelector('.close');
if (closeBtn) {
  closeBtn.addEventListener('click', closeOrderDetail);
}

// 모달 바깥 영역 클릭 시 닫기
window.addEventListener('click', function(event) {
  var modal = document.getElementById('orderDetailModal');
  if (event.target == modal) {
    closeOrderDetail();
  }
});
</script>

</html>