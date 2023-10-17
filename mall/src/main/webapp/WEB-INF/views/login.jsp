<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
  body {
    background-color: #f0f0f0;
    font-family: Arial, sans-serif;
  }
  
  .container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }
  
  .login-box {
    background-color: white;
    border: 1px solid #ccc;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    max-width: 400px;
    width: 100%;
  }
  
  .login-title {
    text-align: center;
    font-size: 24px;
    margin-bottom: 20px;
  }
  
  .form-group {
    margin-bottom: 15px;
  }
  
  .form-label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
  }
  
  .form-input {
    width: 95%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 3px;
  }
  
  .form-button {
    width: 100%;
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px;
    border-radius: 3px;
    cursor: pointer;
  }
  
  .form-button:hover {
    background-color: #0056b3;
  }
  
  .form-link {
    text-align: right;
    margin-top: 10px;
    color: #333;
    font-weight: bold;
    font-size: 16px;
    margin: 0 15px;
    transition: color 0.3s ease;
    text-decoration-line: none;
    text-decoration: none; color: black;
    text-decoration: none;
    text-decoration: none;
    text-decoration: none;
  }
   a { text-decoration: none; color: black; }
    a:visited { text-decoration: none; }
    
    a:focus { text-decoration: none; }
    a:hover, a:active { text-decoration: none; }
</style>
</head>
<body>
<div class="container">
  <div class="login-box">
    <h2 class="login-title">로그인</h2>
      <div class="form-group">
        <label class="form-label" for="userid">아이디:</label>
        <input class="form-input" type="text" name="userid" id="userid" placeholder="테스트용 아이디: admin,비밀번호: admin">
      </div>
      <div class="form-group">
        <label class="form-label" for="passcode">비밀번호:</label>
        <input class="form-input" type="password" name="passcode" id="passcode">
      </div>
      <div class="form-group">
      	<label class="form-label" for="chkAuto">아이디,비밀번호 저장</label>
      	<input type=checkbox id=chkAuto name=chkAuto>
      </div>
      <div class="form-group">
        <input class="form-button" id=btnSubmit name= btnSubmit type="button" value="로그인">
      </div>
	  <div class="form-link"><a href="/findid">아이디,비밀번호 찾기</a></div>
	  <div class="form-link"><a href="/signup">회원이 아니신가요?</a></div>
      <div class="form-link">
      <input type="hidden" value='${success}' id=success name=success>
        <a href="/">홈으로</a>
      </div>
  </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
<script>
$(document)
.ready(function(){
	$('#userid').val($.cookie('aId'));
	$('#passcode').val($.cookie('aPw'));
})
$(document)
.on('click','#btnSubmit',function(){
	let id= $('#userid').val();
	let pw= $('#passcode').val()
	$.ajax({
		url:'/dologin',
		data:{id:id,pw,pw},
		method:'post',
		dataType:'text',
		beforeSend:function(){
			if ($('#userid').val() === "" || $('#passcode').val() === "") {
			    alert("로그인 정보를 입력해 주십시오.");
			    return false;
			  }
		},
		success:function(data){
			if(data=='0'){
				if ($('#chkAuto').prop('checked') == true) {
				    $.cookie('aId', $('#userid').val(),{ expires: 7});
				    $.cookie('aPw', $('#passcode').val(),{ expires: 7});
				    $.cookie('chk', true,{ expires: 7});
				} else {
				    $.removeCookie('aId'); // 쿠키 삭제
				    $.removeCookie('aPw'); // 쿠키 삭제
				}
			  	document.location='/';
			}else if(data=='-1'){
				alert('아이디 혹은 비밀번호가 다릅니다');
			}			
		}
	})	
});
</script>
</html>