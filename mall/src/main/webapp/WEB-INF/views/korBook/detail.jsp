<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>책 상세 정보</title>
    <link href="../css/detail.css" rel="stylesheet"/>
</head>
<%@ include file="../header/Header.jsp" %>
<body>
<form action="/korBook/buyment" method="get">
    <table>
        <tr>
            <td>
                <div class="product-container">
                   <img src="../img/prodmain/${book.img}" class="mainIMG">
                    <div class="product-details">
                        <input type="hidden" name="seqno" id="seqno" value="${book.seq}">
                        <p class="description">${book.name}</p>
                        <p class="price">가격: ${book.price} 원</p>
                        <p class="author">작가: ${book.author}</p>
                        <p class="genre">장르: ${book.genre}</p>
                        <p class="stock">재고: ${book.stock}개</p>
                        <p class="manufacturer">출판사: 책 파는 사람들 Company</p>
						<c:choose>
						    <c:when test="${book.stock > 0}">
						        <c:if test="${userid != ''}">
						            <div><input type="submit" id="btnbuy" style="background: #5055b1;width:110px;height:38px;" value="구매하기"></div>
						        </c:if>
						        <c:if test="${userid == ''}">
						            <div>구매를 하시려면 로그인이 필요합니다.</div>
						        </c:if>
						    </c:when>
						    <c:otherwise>
						        <div>죄송합니다. 해당 상품은 품절되었습니다.</div>
						    </c:otherwise>
						</c:choose>
                        <a href="/korBook/korbook" class="list">목록으로</a>
                        <c:if test="${admin eq 1 }">
                        <br>
                        <a href="/modifyproduct?seqno=${book.seq}">수정</a>
                        </c:if>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <ul class="tabs">
                    <li class="tab-link current" data-tab="tab-1">상품정보</li>
                    <li class="tab-link" data-tab="tab-2">에디터평</li>
                    <li class="tab-link" data-tab="tab-3">리뷰</li>
                </ul>
                <div id="tab-1" class="tab-content current">
                    <div class="product-info-label">
                        <div class="content"><c:out value="${book.info}" /></div>
                        <h2>  </h2>
                        <div class="center-image">
                            <img src="../img/prodinfo/${book.prodinfo}">
                        </div>
                    </div>
                </div>
                <div id="tab-2" class="tab-content"><%-- <c:out value='${book.editorreview}' /> --%>준비 중입니다.</div>   
            </td>
        </tr>
    </table>
</form>
<div id="tab-3" class="tab-content">
<div class="customer-reviews">
    <h2>고객 리뷰 및 평점</h2>
    <div class="review-section">
        <!-- 리뷰를 보여주는 부분 -->
        <c:forEach items="${review}" var="alist">
            <div class="review">
                <c:forEach begin="1" end="${alist.score}">
                    <img src="../img/starrate.png" class="star">
                </c:forEach>
                <h3 id="id">아이디:${alist.userid}</h3>
                <p>${alist.comment}</p>
				<c:choose>
				    <c:when test="${userid.equals(alist.userid) || sessionScope.admin eq 1}">
				       <a href="#" class="edit-review-button" data-editno="${alist.seq}">수정</a>
				        <a href="/korBook/deletereview?deleteno=${alist.seq}&seqno=${alist.prodid}">삭제</a>
				    </c:when>
				    <c:otherwise>
				    </c:otherwise>
				</c:choose>
            </div>
    		<div class="edit-review-form" id="edit-review-form-${alist.seq}" style="display: none;">
		        <input type="hidden" name="editno" id="editno" value="${alist.seq}">
		        <input type="hidden" name="seqno" id="seqno" value="${book.seq}">
		        <label for="edit-comment">댓글 수정:</label>
		        <textarea id="edit-comment-${alist.seq}" name="edit-comment" rows="10" class="review_textarea" required></textarea>
		        <input type="button" class="subeditreview" data-editno="${alist.seq}" value="수정 완료">
        	<div class="rating2">
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->

            </div>
        	</div>
        </c:forEach>
        <!-- 추가 리뷰들을 여기에 추가할 수 있습니다. -->
    </div>
    <form id="comment-form" action="/korBook/addreview" method="post">
        <!-- 리뷰 작성 폼 -->
        <div class="form-group">
            <input type="hidden" name="seqno" id="seqno" value="${book.seq}">
            <label for="name">아이디:</label>
            <input type="text" id="name" name="name" value="${userid}" readonly>
        </div>
        <input type="hidden" name="rate" id="rate" value="0"/>
        <p class="title_star">별점과 리뷰를 남겨주세요.</p>
        <div class="review_rating">
            <div class="warning_msg">별점을 선택해 주세요.</div>
            <div class="rating">
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점" checked>
                <label for="rating1"></label>
                <input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점" checked>
                <label for="rating2"></label>
                <input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점" checked>
                <label for="rating3"></label>
                <input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점" checked>
                <label for="rating4"></label>
                <input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점" checked>
                <label for="rating5"></label>
                <input type="hidden" name="score" id="score">
            </div>
        </div>
        <div class="form-group">
            <label for="comment">댓글:</label>
            <textarea id="comment" name="comment" rows="10" class="review_textarea"  required></textarea>
        </div>
        <div class="form-group">
            <input type="submit" id="subreview" value="댓글 달기">
        </div>
    </form>
</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){
    $('#score').val(5)
    $('ul.tabs li').click(function(){
        let tab_id = $(this).attr('data-tab');
        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $(this).addClass('current');
        $("#"+tab_id).addClass('current');
    })

    $('.edit-review-button').click(function (e) {
        e.preventDefault();
        let editNo = $(this).data('editno');
        $('#edit-review-form-' + editNo).show();
    });

    $('.subeditreview').click(function (e) {
        e.preventDefault();
        let editNo = $(this).data('editno');
        let editedComment = $('#edit-comment-' + editNo).val();
        let editedRating = $('#edit-review-form-' + editNo + ' .rating2 input[type="checkbox"]:checked').length;
        let prodNo = $('#seqno').val();
        
        console.log(editNo)
        console.log(editedComment)
        console.log(prodNo)
        $.ajax({
	        type: "POST", // 또는 "PUT" 등 HTTP 요청 메서드를 선택합니다.
	        url: "/korBook/updatereview", // 서버 엔드포인트 URL을 지정합니다.
	        data: {
	            editNo: editNo,
	            editedComment: editedComment,
	            prodNo: prodNo
	        },
	        success: function (response) {
	            // 서버에서의 응답을 처리합니다. 성공적으로 처리된 경우 여기서 적절한 동작을 수행합니다.
	            $('#edit-comment-' + editNo).val(editedComment);
	            alert("리뷰수정이 완료되었습니다.")
	            

				location.reload();
	            // 페이지를 새로 고침하거나 다른 작업을 수행할 수 있습니다.
	        }

	    });                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
        // 서버로 수정된 리뷰 내용과 번호를 전송하는 코드를 작성합니다.
        // AJAX 또는 폼 서브밋을 사용하여 서버로 데이터를 보낼 수 있습니다.
        // 서버에서는 해당 리뷰를 업데이트하고 페이지를 새로 고침할 수 있습니다.
    });

    $('input[type="checkbox"]').click(function () {
        if ($(this).is(':checked')) {
            let checkboxValue = $(this).val();
            console.log('선택된 체크박스의 값: ' + checkboxValue);
            $('#score').val(checkboxValue)
            $('#score2').val(checkboxValue)
            console.log('히든 값:' + $('#score').val())
        }
    });

    $('#subreview').click(function () {
        if ($('#name').val() == "") {
            alert("로그인이 필요합니다.")
            return false;
        }
    });

    $('#subeditreview').click(function () {
        console.log("submit")
    });
});
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
        }else{
            item.checked = false;
        }
    });
}
let rating = new Rating();//별점 인스턴스 생성
document.addEventListener('DOMContentLoaded', function(){
    //별점선택 이벤트 리스너
    document.querySelector('.rating').addEventListener('click',function(e){
        let elem = e.target;
        if(elem.classList.contains('rate_radio')){
            rating.setRate(parseInt(elem.value));
        }
    })
});
</script>
</html>
