<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    margin: 0;
    padding: 0;
  }

  h1 {
    text-align: center;
    margin-top: 30px;
  }

  form {
    width: 80%;
    max-width: 600px;
    margin: 0 auto;
    background-color: #ffffff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  }

  table {
    width: 100%;
    margin-top: 20px;
    border-collapse: collapse;
  }

  td {
    padding: 10px 0;
    border-bottom: 1px solid #ddd;
  }

  input[type="text"] {
    width: 95%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
  }

  input[type="submit"] {
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  input[type="submit"]:hover {
    background-color: #0056b3;
  }
  
</style>
</head>
<body>

    <h1>내 정보</h1>
    <form id=myinfoUpdate method="get" action="updetemyinfo">
    <a href="/">홈으로</a>
    <table>
    <tbody>
    <tr><td><p>사용자 아이디 : ${user.userid}</p></td></tr>
    <tr><td><p>이름 : ${user.name}</p></td></tr>
    <tr><td><p>성별 : ${user.gender}</p></td></tr>
    <tr><td><p>생년월일 : ${user.birthday}</p></td></tr>
    <tr><td><p>전화번호 : <input type=text name=mobile value='${user.mobile}'></p></td></tr>
    <tr><td><p>이메일 : <input type=text name=email value='${user.email}'></p></td></tr>
    <tr><td><p>주소<input class="form-input" type="text" id="address_kakao" name="address" readonly value='${user.address}' /></p></td></tr>
    <tr><td><p>상세 주소<input class="form-input" type="text" name="address_detail" value='${user.address_detail}' /></p></td></tr>
    <tr><td><p>가입일자 : ${user.created}</p></td></tr>
    <tr><td><input type=submit id=btnUpdate name=btnUpdate value='정보수정'>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='/changepw'>비밀번호 변경</a></td></tr>
    </tbody>
    </table>
    </form>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
<script src='https://code.jquery.com/jquery-Latest.js'></script>
<script>
$(document)
.on('click','#btnUpdate',function(){
	 if (!confirm("정말 정보를 변경할까요?.")) {
	        return false;
	    } else {
	     	return true;
	    }
})
</script>
</html>