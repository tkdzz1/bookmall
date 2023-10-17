<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호변경</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
  }
  form {
    background-color: #fff;
    border: 1px solid #ccc;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    width: 300px;
  }
  table {
    width: 100%;
    border-collapse: collapse;
  }
  table td {
    padding: 8px;
  }
  input[type="password"], input[type="text"] {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 3px;
  }
  input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 3px;
    cursor: pointer;
  }
  
</style>

</head>
<body>
<form id=pwchange method="post" action="dochangepw">
<table>
<tbody>
	<tr><td><p>현재비밀번호: <input type=password id=originalPassword name=originalPassword>
	<input type=hidden id=hiddenpw name=hiddenpw value='${originalpw}'></p></td></tr>
    <tr><td><p>새비밀번호: <input type=password id=newPassword name=newPassword></p></td></tr>
    <tr><td><p>새비밀번호확인: <input type=password id=newPasswordChk name=newPasswordChk></p></td></tr>
    <tr><td><input type=submit id=btnPasswordUpdate name=btnPasswordUpdate value='비밀번호변경'></td></tr>
    <tr><td>${fail}</td></tr>
    
</tbody>
</table>
</form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on('click','#btnPasswordUpdate',function(){
	let oldpw = $('#hiddenpw').val();
	let newpw=$('#newPassword').val();
	
	if($('#originalPassword').val()==null||$('#originalPassword').val()==""){
		 alert("현재 비밀번호를 입력해주세요");
		 return false;
	}
	if($('#originalPassword').val()!=oldpw){
		 alert("현재 비밀번호가 틀립니다.");
		 return false;
	}
	if(newpw==null||$('#newPassword').val()==""){
		 alert("새비밀번호를 입력하세요.");
		 return false;
	}
	if($('#newPasswordChk').val()==null||$('#newPasswordChk').val()==""){
		 alert("새비밀번호확인을 입력하세요.");
		 return false;
	}
	if($('#newPasswordChk').val()!=newpw){
		alert("새비밀번호와 새비밀번호 확인이 다릅니다");
		 return false;
	}
	if(!confirm('정말로 비밀번호를 변경 할까요?')){
		return false;
	}
});
</script>
</html>