<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 내역</title>
<link rel="stylesheet" href="css/g_question.css">
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
	    <section class="content">
        <h1>문의 내역</h1>
        <table class="inquiry-table">
            <thead>
                <tr>
                    <th>문의 번호</th>
                    <th>아이디</th>
                    <th>제목</th>
                    <th>상태</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${getQuestion}" var="getQuestion">
                <tr>
                    <td>${getQuestion.num}</td>
                    <td>${getQuestion.userid}</td>
                    <td>${getQuestion.title}</td>
                    <td>${getQuestion.progress}
                    <c:if test="${getQuestion.progress=='답변 대기' and admin==1}">
                    <button id="btnAnswer" class="action-button" value="${getQuestion.num}">답변달기</button>                    
                    </c:if>
                    </td>
                    <td>${getQuestion.created}<input type="hidden" id="questionContent" value="${getQuestion.content}">
                    <input type="hidden" id="questionAnswer" value="${getQuestion.answer}"></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:if test="${admin!=1 and userid!=''}">
        <button id="inquiry-button" class="action-button">문의하기</button>
        </c:if>
        <div id="modal" class="modal">
	        <div class="modal-content">
	            <span class="close">&times;</span>
	            <h2>문의 내용</h2>
	            <p id="question-content"></p>
	            <h2>답변 내용</h2>
	            <p id="answer-content"></p>
	        </div>
	    </div>
		<table class="pageTable">
		<tr>
		<td style='font-size:15px;'>${pagestr}페이지</td>
		</tr>
		</table>
    </section>
    <section class="content">
    	<h1>책 파는 사람들 문의게시판</h1>
        <div class="options">
            <a href="/korBook/g_board" class="option">자유게시판</a>
            <a href="/g_FAQ" class="option">자주묻는질문(FAQ)</a>
        </div>
    </section>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#btnAnswer',function(){
	document.location="/g_answer?num="+$(this).val();
})
.on('click','#inquiry-button',function(){
	document.location="/g_newQuestion"
})
// 문의 내역 클릭 시 답변을 모달 창으로 보여주는 함수
function showAnswer(questionContent,answerText) {
	$("#question-content").text(questionContent);
    $("#answer-content").text(answerText);
    $("#modal").css("display", "block");
}

// 모달 창 닫기
function closeModal() {
$("#modal").css("display", "none");
}

// 문의 내역 클릭 시 이벤트 리스너 추가
$(".inquiry-table tbody tr").click(function() {
	var questionContent = $(this).find("td:eq(4) input:eq(0)").val();
    var answerText = $(this).find("td:eq(4) input:eq(1)").val();
    showAnswer(questionContent,answerText);
});

// 모달 창 닫기 버튼 이벤트 리스너 추가
$(".close").click(closeModal);
console.log(${getQuestion[0].privateCheck});
</script>
</html>