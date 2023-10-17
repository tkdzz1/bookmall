<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 작성</title>
<link rel="stylesheet" href="css/g_newQuestion.css">
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
    <div class="container">
        <h2>문의 작성</h2>
        <form id="answer-form" action="/g_insertQuestion" method="post">
            <div class="form-group">
                <label for="user-id">아이디:</label>
                <input type="text" id="user-id" name="user-id" value="${userid}" readonly>
            </div>
            <div class="form-group">
                <label for="question-title">제목:</label>
                <input type="text" id="question-title" name="question-title" required>
            </div>
            <div class="form-group">
                <label for="question-content">문의 내용:</label>
                <textarea id="question-content" name="question-content" required></textarea>
            </div>
			<div class="radio-container">
			    <label for="public-radio">공개</label>
			    <input type="radio" id="public-radio" name="visibility" value=0 checked>&nbsp;
			    <label for="private-radio">비공개</label>
			    <input type="radio" id="private-radio" name="visibility" value=1>
			</div>
            <div class="form-buttons">
                <button type="submit" class="action-button">문의 작성</button>
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