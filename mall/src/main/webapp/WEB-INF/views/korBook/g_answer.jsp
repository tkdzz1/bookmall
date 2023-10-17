<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 달기</title>
<link rel="stylesheet" href="css/g_answer.css">
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
    <div class="container">
        <h2>답변 작성</h2>
        <form id="answer-form" action="/insertAnswer" method="post">
            <div class="form-group">
                <label for="question-number">문의 번호:</label>
                <input type="text" id="question-number" name="question-number" value="${getQuestion.num}" readonly>
            </div>
            <div class="form-group">
                <label for="user-id">아이디:</label>
                <input type="text" id="user-id" name="user-id" value="${getQuestion.userid}" readonly>
            </div>
            <div class="form-group">
                <label for="question-title">제목:</label>
                <input type="text" id="question-title" name="question-title" value="${getQuestion.title}" readonly>
            </div>
            <div class="form-group">
                <label for="question-content">문의 내용:</label>
                <textarea id="question-content" name="question-content" readonly>${getQuestion.content}</textarea>
            </div>
            <div class="form-group">
                <label for="answer-text">답변:</label>
                <textarea id="answer-text" name="answer-text" required></textarea>
            </div>
            <div class="form-buttons">
                <button type="submit" class="action-button">답변 작성</button>
                <button type="button" class="action-button close" id="btnCancel">취소</button>
            </div>
        </form>
    </div>
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#btnCancel',function(){
	document.location="/g_question";
})
</script>
</html>