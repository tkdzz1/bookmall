<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        h1 {
            margin-top: 30px;
        }

        div {
            margin: 20px;
            font-size: 18px;
        }

        div.error {
            color: red;
        }

        a {
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
	<h1>고객님 정보 찾기가 완료되었습니다.</h1>
    <div style="width:50%;text-align: center;margin: 0 auto;background-color:  white; padding: 20px; border-radius: 5px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);">
    <p>조회 결과: ${foundId}</p>
	
    <a href="/login">로그인하러가기</a>
    </div>
</body>
</html>