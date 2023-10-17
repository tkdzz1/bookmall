<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
  
  .signup-box {
    background-color: white;
    border: 1px solid #ccc;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    max-width: 500px;
    width: 100%;
  }
  
  .signup-title {
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
    width: 96%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 3px;
  }
  
  .form-radio-label {
    display: inline-block;
    margin-right: 10px;
  }
  
  .form-button {
    width: 100%;
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px;
    border-radius: 3px;
    cursor: not-allowed;

  }
  
  .form-button:hover {
    background-color: #0056b3;
  }
  
  .form-link {
    text-align: right;
    margin-top: 10px;
  }
</style>
</head>
<body>
<div class="container">
  <div class="signup-box">
    <h2 class="signup-title">회원가입</h2>
    
    <form method="post" name="frmlogin" id="frmlogin" action="dosignup">
      <div class="form-group">
        <label class="form-label" for="userid">사용자 아이디:</label>
        <input class="form-input" type="text" id="userid" name="userid" size="12">
        <input type="button" id="idchk" name="idchk" value="아이디중복확인">
      </div>
      <div class="form-group">
        <label class="form-label" for="passcode">비밀번호:</label>
        <input class="form-input" type="password" id="passcode" name="passcode" size="12">
      </div>
      <div class="form-group">
        <label class="form-label" for="passcode1">비밀번호 확인:</label>
        <input class="form-input" type="password" id="passcode1" name="passcode1" size="12">
      </div>
      <div class="form-group">
        <label class="form-label" for="username">이름:</label>
        <input class="form-input" type="text" id="username" name="username">
      </div>
      <div class="form-group">
        <span class="form-radio-label">성별:</span>
        <input type="radio" id="male" name="gender" value="남자">
        <label class="form-radio-label" for="male">남</label>
        <input type="radio" id="female" name="gender" value="여자">
        <label class="form-radio-label" for="female">여</label>
      </div>
      <div class="form-group">
        <label class="form-label" for="birthday">생년월일:</label>
        <input class="form-input" type="date" id="birthday" name="birthday">
      </div>
      <div class="form-group">
        <label class="form-label" for="mobile">모바일:</label>
        <input class="form-input" type="text" id="mobile" name="mobile" size="16">
      </div>
      <div class="form-group">
        <label class="form-label" for="email">이메일:</label>
        <input class="form-input" type="text" id="email" name="email" size="16">
      </div>
      <div class="form-group">
			주소
			<input class="form-input" type="text" id="address_kakao" name="address" readonly />
			상세 주소
			<input class="form-input" type="text" name="address_detail" />
      </div>
      <input type="hidden" id="stat" name="stat" value="${stat}">
      <div class="form-group" style="text-align: right;">
        <input class="form-button" type="submit" id="signupButton" value="확인" disabled>
        <a href="/" class="form-link">홈으로</a>
        ${fail}
      </div>
    </form>
  </div>
</div>
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
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
//1.0
$(document).on('submit', '#frmlogin', function() {
	if ($('#userid').val() === "") {
		  alert("사용자 아이디를 입력해 주십시오.");
		  return false;
		}

		if ($('#passcode').val() === "") {
		  alert("비밀번호를 입력해 주십시오.");
		  return false;
		}

		if ($('#passcode1').val() === "") {
		  alert("비밀번호 확인을 입력해 주십시오.");
		  return false;
		}

		if ($('#passcode').val() !== $('#passcode1').val()) {
		  alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		  return false;
		}

		if ($('#username').val() === "") {
		  alert("이름을 입력해 주십시오.");
		  return false;
		}

		if (!$('input[name=gender]:checked').length) {
		  alert("성별을 선택해 주십시오.");
		  return false;
		}

		if ($('#birthday').val() === "") {
		  alert("생년월일을 입력해 주십시오.");
		  return false;
		}

		if ($('#mobile').val() === "") {
		  alert("전화번호를 입력해 주십시오.");
		  return false;
		}

		if ($('#email').val() === "") {
		  alert("이메일을 입력해 주십시오.");
		  return false;
		}

		if ($('#address').val() === "") {
		  alert("주소를 입력해 주십시오.");
		  return false;
		}
		if ($('#address_detail').val() === "") {
			  alert("상세 주소를 입력해 주십시오.");
			  return false;
		}
		alert("회원가입에 성공했습니다");
})
.on('click', '#idchk', function () {
    var id = $("#userid").val();
    if (!id) {
        alert("아이디를 입력하세요.");
        return;
    }
    $.ajax({
        url: '/idchk',
        data: { id: id },
        method: 'POST',
        dataType: 'text',
        success: function (data) {
        	if (data == "1") {
        	    alert("이미 사용 중인 아이디입니다.");	
        	    $("#signupButton").prop("disabled", true);
        	    $("#signupButton").css("background-color", "#007bff");
        	    $("#signupButton").css("cursor", "not-allowed");
        	} else if (data == "0") {
        	    alert("사용 가능한 아이디입니다.");
        	    $("#signupButton").prop("disabled", false);
        	    $("#signupButton").css("background-color", "#007bff");
        	    $("#signupButton").css("cursor", "pointer");
        	   
        	} else {
        	    alert("오류가 발생했습니다.");
        	}
        }
    });
});

</script>
</body>
</html>
