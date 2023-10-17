<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link href="../css/addBook.css" rel="stylesheet"/>
  <meta charset="UTF-8">
  <title>책 추가</title>
</head>
<body>
  <div class="container">
    <h1>책 추가</h1>
    <form action="/upload" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="name">책 이름:</label>
        <input type="text" id="name" name="name" required>
      </div>
      <div class="form-group">
        <label for="price">가격:</label>
        <input type="number" id="price" name="price" required>
      </div>
      <div class="form-group">
        <label for="genre">장르:</label>
        <input type="text" id="genre" name="genre" required>
      </div>
      <div class="form-group">
      <!-- 이미지추가 -->
        <label for="image">대표 이미지:</label>
        <input type="file" id="mainimg" name="mainimg" required>
      </div>
      
      <div class="form-group">
        <label for="author">작가 이름:</label>
        <input type="text" id="author" name="author" required>
      </div>
      
      <div class="form-group">
        <label for="image">상품정보 이미지:</label>
        <input type="file" id="prodinfo" name="prodinfo" required>
      </div>
      <div class="form-group">
        <label for="image" >상품설명:</label>
        <textarea cols="50" rows="10" id=info name=info></textarea>
      </div>
      <div class="form-group">
        <label for="stock">상품수량:</label>
        <input type="text" id="prodinfo" name="stock" required>
      </div>
      <div class="form-group">
        <label for="image" >에디터의 평가:</label>
        <textarea cols="50" rows="10" id=editorreview name=editorreview></textarea>
      </div>
      <div class="form-group">
        <input type="submit" value="추가">
       	&nbsp;&nbsp;&nbsp;
        <a href="/korBook/korbook">취소</a>
      </div>
    </form>
  </div>
  <jsp:include page="../header/footer.jsp" />
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script >
</script>
</html>