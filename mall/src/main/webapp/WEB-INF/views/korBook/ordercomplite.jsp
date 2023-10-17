<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>결제 완료</title>
</head>
<style>
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: #F8F8F8;
}

.payment-success {
  text-align: center;
  background-color: white;
  border-radius: 8px;
  padding: 30px;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.payment-success h1 {
  font-size: 24px;
  margin-bottom: 10px;
}

.payment-success p {
  font-size: 16px;
  color: #666;
  margin-bottom: 20px;
}

.back-to-home {
  display: inline-block;
  background-color: #007ACC;
  color: white;
  padding: 10px 20px;
  border-radius: 4px;
  text-decoration: none;
  transition: background-color 0.2s;
}

.back-to-home:hover {
  background-color: #005E91;
}
</style>
<body>
  <div class="payment-success">
    <h1>결제가 완료되었습니다!</h1>
    <p>주문해주셔서 감사합니다. 결제가 성공적으로 완료되었습니다.</p>
    <a href="/korBook/korbook" class="back-to-home">홈으로 돌아가기</a>
  </div>
</body>
</html>