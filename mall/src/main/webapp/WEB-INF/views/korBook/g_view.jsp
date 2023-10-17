<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${findingBoard.title}</title>
<link rel="stylesheet" href="css/g_view.css">
</head>
<%@ include file ="../header/Header.jsp" %>
<body>
	<!-- 메인 -->
<section class="content">
    <main id="view">
        <article id="post-content">
        	<input type="hidden" id="b_num" value="${findingBoard.num}">
            <h2>제목:${findingBoard.title}</h2>
            <p>작성자: ${findingBoard.userid}</p>
            <p>조회수: ${findingBoard.hit}</p>
            <p>작성일: ${findingBoard.created}</p>
            <p>최종수정일: ${findingBoard.updated}</p>
            <label style="border-top: 1px solid #ccc;">내용:</label>
            <img src='../img/boardimg/${findingBoard.g_img}' style='width:190px; height:200px;' onerror="this.style.display='none'">
			<textarea id="content" name="content" required readonly>${findingBoard.content}</textarea>	
			<label>댓글:</label>
			<div id="writeComment" style='text-align:right; font-size: small; cursor:pointer;' data-bnum="${findingBoard.num}" data-userid="${userid}">댓글달기</div>
			<form method="post" action="/insertComment">
			<input type="hidden" name="boardNum" id="boardNum" value="${findingBoard.num}">
			<input type="hidden" id="userid" name="userid" value="${userid}">
			<input id="commentBox" name="commentBox" type=text style="display:none" required>
			<input id="sendComment" type=submit value="확인" ><br><br>
			</form>
			<table id="tblcomment">
			<c:forEach items="${findingComment}" var="findingComment">
			<tr><td colspan="5"><div style="border-top: 1px solid #ccc;"></div></td></tr>
			<tr>
			<td style="width:140px">${findingComment.userid}</td>
			<td style="width:420px">${findingComment.comment}</td>
			<td style="width:100px">${findingComment.updated}</td>
			<td><c:if test="${findingComment.userid==userid}">
			<a href="/g_commentDelete?b_num=${findingBoard.num}&c_num=${findingComment.c_num}">X</a></c:if></td>													
			
			<tr>
			<!--url 수정-->
			</tr>
			</c:forEach>
			</table>
	    <table class="pageTable">
		<tr>
		<td style='font-size:15px;'>${pagestr}페이지</td>
		</tr>
		</table>         
        </article>
        <div style="width: 800px;">
        <span><a href="/korBook/g_board" class="back-button">게시판 목록으로 돌아가기</a></span>      
        <span style='margin-left:320px;'>
        <c:if test="${userid==''}">
		글을 작성하려면 로그인하세요.
		</c:if>
		<c:if test="${userid != ''}">
		<a href='/g_write'>글쓰기</a>&nbsp;&nbsp;
		</c:if>
		<c:if test="${findingBoard.userid==userid}">
		<button id=btnUpdate>수정</button>&nbsp;&nbsp;
		<button id=btnDelete>삭제</button>
		</c:if>
		</span>
		</div>
    </main>
</section>
<section class="content" style="text-align: center;">
        <h1>책 파는 사람들 자유게시판</h1>
        <div class="options">
            <a href="/g_FAQ" class="option">자주묻는질문(FAQ)</a>
            <a href="/g_question" class="option">문의하기</a>
        </div>
</section>    
</body>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#btnDelete',function(){
 	if(!confirm('정말로 지울까요?')) return false;
	
	document.location='/g_delete?boardNum='+$('#boardNum').val();
	return false;
})
.on('click','#btnUpdate',function(){
	document.location='/g_update?boardNum='+$('#boardNum').val();
	return false;
})
.on('click','#writeComment',function(){
	if(${userid==''}){
	alert("댓글을 쓰려면 로그인하세요");
	return false;
	}
    if ($('#commentBox').css('display') == 'block') {
        $('#commentBox').css('display', 'none');
        $('#sendComment').css('display', 'none');
    } else {
        $('#commentBox').css('display', 'block');
        $('#sendComment').css('display', 'block');
    }
})
.on('click', '.recomment-button', function () {
    var commentId = $(this).data('comment-id');
    var recommentBox = $('#recommentbox-' + commentId);
    var sendreComment = $('#sendreComment-' + commentId);
    // 대댓글 입력창 토글
    if (recommentBox.css('display') == 'block') {
        recommentBox.css('display', 'none');
        sendreComment.css('display', 'none');
    } else {
        recommentBox.css('display', 'block');
        sendreComment.css('display', 'block');
    }
})
$('.sendreComment').on('click', function () {
    let recommentId = $(this).data('btn-recomment');
    let recommentbox = $('#recommentbox-' + recommentId).val();
    let b_num = $('#b_num').val();

    // 데이터가 비어 있는지 확인
    if (!recommentId || !recommentbox || !b_num) {
        console.log('데이터를 모두 입력하세요.');
        return;
    }

    $.ajax({
        url: '/addrecomment',
        method: 'POST',
        data: {
            comment: recommentbox,
            recommentId: recommentId,
            b_num: b_num
        },
        dataType: 'json',
        success: function (data) {
            // 서버에서의 성공 응답 처리
            console.log('성공:', data);
            // 대댓글 추가 코드
            $('#tblcomment').append(data)
            let recommentDiv = $('<div></div>'); // 대댓글을 감싸는 div 요소 생성
        },
        error: function (jqXHR, textStatus, errorThrown) {
            // 서버에서의 오류 응답 처리
            console.error('오류:', textStatus, errorThrown);
        }
    });
});



</script>
</html>