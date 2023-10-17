<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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

        form {
            width: 80%;
            max-width: 400px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        button[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
	<form method="post" action="/dofindId">
        <label for="email">이메일 주소:</label>
        <input type="text" id="email" name="email" required>
        <label for="email">이름:</label>
        <input type="text" id="name" name="name" required>
        <label for="birthday">생년월일:</label>
        <input type="date" id="birthday" name="birthday" required>
        <br>
        <button type="submit">아이디 찾기</button>
    </form>
    <form method="post" action="/dofindpw">
        <label for="email">이메일 주소:</label>
        <input type="text" id="email" name="email" required>
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required>
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required>
        <label for="birthday">생년월일:</label>
        <input type="date" id="birthday" name="birthday" required>
        <br>
        <button type="submit">비밀번호 찾기</button>
    </form>
    ${fail}
</body>
</html>