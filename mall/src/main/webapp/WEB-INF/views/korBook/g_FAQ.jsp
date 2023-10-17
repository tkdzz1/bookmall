<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<link rel="stylesheet" href="css/g_FAQ.css">
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
    <section class="content">
        <h1>자주묻는질문 (FAQ)</h1>
            <div class="divRight">
			    <c:if test="${admin==1}">
			    <button id="addBtn" class="action-button">추가</button>
			    </c:if>
		    </div><br><br>
        <ul class="faq-list">
            <c:forEach items="${getFAQ}" var="getFAQ">
            <li>
                <h2 id="question" class="question">${getFAQ.title}</h2>
                <p id="answer" class="answer">${getFAQ.content}<p>
            </li>
            <c:if test="${admin==1}">
            <div class="divRight">
            	<input type="text" name="numFAQ" class="NUM" value="${getFAQ.num}" readonly>
                <button id="editBtn" class="action-button" value="${getFAQ.num}">수정</button>        			
    			<button id="deleteBtn" class="action-button" value="${getFAQ.num}">삭제</button>
            </div>
            </c:if>
			</c:forEach>
        </ul>
        <form method="post" action="/insertFAQ">
	        <ul class="faq-list">
			    <li id="insertFAQ" style="display:none">
			    	<h1>추가</h1>			    	
			        <h2 class="question"><input type="text" id="insertFAQ_title" name="insertFAQ_title" required></h2>
			        <p class="answer"><input type="text" id="insertFAQ_content" name="insertFAQ_content" required><p>
			        <div class="divRight">
			        <input type="submit" class="action-button" value="추가">
			        </div>			        
			    </li>
			</ul>
		</form>
        <form method="post" action="/updateFAQ">
	        <ul class="faq-list">
			    <li id="changeFAQ" style="display:none">
			    	<h1>수정</h1>
			    	<h2 >NUMBER<input type="text" id="updateFAQ_NUM" name="updateFAQ_NUM" class="NUM" style="width:20px; border:none" readonly></h2>
			        <h2 class="question"><input type="text" id="updateFAQ_title" name="updateFAQ_title" required></h2>
			        <p class="answer"><input type="text" id="updateFAQ_content" name="updateFAQ_content" required><p>
			        <div class="divRight">
			        <input type="submit" class="action-button" value="수정">
			        </div>
			    </li>
			</ul>
		</form>		
    </section>

  	<section class="content">
        <h1>책 파는 사람들 FAQ</h1>
        <div class="options">
            <a href="/korBook/g_board" class="option">자유게시판</a>
            <a href="/g_question" class="option">문의하기</a>
        </div>
    </section>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document)
.ready(function() {
    $('.question').click(function() {
        // 클릭한 질문에 대한 답변 토글
        $(this).next('.answer').slideToggle();
    });
})
.on('click','#editBtn',function(){
	if ($('#changeFAQ').css('display') == 'block') {
        $('#changeFAQ').css('display', 'none');
    } else {
        $('#changeFAQ').css('display', 'block');
    }
	if ($('#insertFAQ').css('display') == 'block'){
		$('#insertFAQ').css('display', 'none');
	}
	$("#updateFAQ_NUM").val($(this).val()); 
})
.on('click','#addBtn',function(){
	if ($('#insertFAQ').css('display') == 'block'){
		$('#insertFAQ').css('display', 'none');
	} else {
        $('#insertFAQ').css('display', 'block');
    }
	if ($('#changeFAQ').css('display') == 'block') {
        $('#changeFAQ').css('display', 'none');
    }
})
.on('click','#deleteBtn',function(){
	if(!confirm('정말로 지울까요?')) return false;	
	document.location='/deleteFAQ?num='+$(this).val();		
})
;
console.log(${admin})
</script>
</html>