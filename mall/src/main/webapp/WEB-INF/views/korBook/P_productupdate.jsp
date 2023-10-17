<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/detail.css" rel="stylesheet"/>
<title>상품수정</title>
</head>
<style>
/* detail.css */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f2f2f2;
}

header {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 10px 0;
}

.container {
    max-width: 800px;
    margin: 0 auto;
    background-color: #fff;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
    padding: 20px;
    border-radius: 5px;
}

.container a {
    text-decoration: none;
    color: #333;
    font-size: 16px;
}

.book-details {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
}

.book-details div {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
}

.book-title, .book-genre, .book-author, .book-price {
    font-size: 18px;
}

input[type="text"], input[type="file"] {
    padding: 10px;
    width: 100%;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    padding: 10px 20px;
    background-color: #e74c3c;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #c

</style>
<body>
    <header>
        <h1>책 정보 수정</h1>
    </header>
    <form action="/doupdateproduct" method="post" enctype="multipart/form-data">
	    <div class="container">
		    	<div><a href="/">홈으로</a></div>
		    	<div class="book-details">
		        <div><img src="../img/prodmain/${book.img}" id="img1" alt="책 이미지"></div>
		        <div><input type=text id=img1-1 name=Mimgstat value='${book.img}' readonly size=50 style="border:none" ></div>
		        <div><input type=button id=delMImg value="메인 이미지 삭제" class="img1"></div>
		        <div><input type='hidden' id='oriMimg' name='oriMimg' value='${book.img}' ></div>
		        <div><p>메인이미지 변경:</p><input type="file" id="chgMimg" name="chgMimg"></div>
	        	<!-- 어드민 상품수정 -->
	            <div><input type='hidden' id='seqno' name='seqno' value='${book.seq}' ></div>
	            
	            <div class="book-title">책 제목:<input type='text'name='name' value='${book.name}' required></div>
	            <div class="book-genre">장르:<input type='text'name='genre' value='${book.genre}' required></div>
	            <div class="book-author">작가:<input type='text'name='author' value='${book.author}' required></div>
	            <div class="book-price">가격:<input type='text'name='price' value='${book.price}' required>원</div>
	            <div class="form-group">수량:<input type='text'name='stock' value='${book.stock}' required>개</div>
			    <br>
			    <div class="form-group">
        		<label for="image" >상품정보</label><br>
       			<textarea cols="50" rows="10" id=info name=info >${book.info}</textarea>
      			</div>
			    <div class="form-group">
        		<label for="image" >에디터의 평가</label><br>
       			<textarea cols="50" rows="10" id=editorreview name=editorreview >${book.editorreview}</textarea>
      			</div>
		        <div><img src="../img/prodinfo/${book.prodinfo}" id="img2"></div>
		        <div><input type=text id=img2-1 name=Simgstat value='${book.prodinfo}' readonly size=50 style="border:none"></div>
		        <div><input type=button id=delSImg value="내용 이미지 삭제" class="img2"></div>
		        <div><input type='hidden' id='oriSimg' name='oriSimg' value='${book.prodinfo}'></div>
	       		<div><p>내용이미지 변경:</p><input type="file" id="chgSimg" name="chgSimg"></div>
				<div><input type="submit" id="updPrdt" value="수정"></div>
	        	</div>
	    </div>
    </form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
	console.log($('#seqno').val())

	
})
.on('click','#delMImg',function(){
	console.log($('#oriMimg').val())
	$("#img1").remove();
	$("#img1-1").val("");
})
.on('click','#delSImg',function(){
	console.log($('#oriSimg').val())
	$("#img2").remove();
	$("#img2-1").val("");
})
</script>
</html>