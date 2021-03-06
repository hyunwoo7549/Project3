<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FACEGRAM - 비밀번호찾기</title>
		
		<!-- 웹폰트 -->
		<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet" type="text/css">
		
		<!-- login 스타일시트 -->
		<link rel="stylesheet" type="text/css" href="/resources/css/css_login.css?var=<%=System.currentTimeMillis()%>">
		
		<!--  AJAX 파일  -->
		<script src="/js/httpRequest.js"></script>
		
		<script>
		// 비밀번호찾기 AJAX
		function find_pw ( f ) {
			var  id		    = f.member_id.value; 	// id
			var phonenumber = f.member_phone.value; // 연락처
			
			if ( id == '' || phonenumber == '') {
				alert("아이디와 비밀번호를 정확히 입력해주세요");
				return;
			}
			
			var url	   = "/member/findpwresult";
			var param  = "id=" + id + "&phonenumber=" + phonenumber;
			
			sendRequest( url, param, find_result, "POST" );
		}
		
		// 콜백
		function find_result() {
			console.log( xhr.readyState + " / " + xhr.status );
			
			if ( xhr.readyState == 4 && xhr.status == 200 ) {
				var data = xhr.responseText;
				var json = JSON.parse( data );
				
				// 비밀번호가 있으면
				if ( json.resStr == "yes" ) {
					alert("회원님의 비밀번호는 [" + json.pw + "] 입니다.");
					history.back();
					return;
				}
				
				// 비밀번호가 없으면
				alert("회원정보가 없거나 일치하지 않습니다");

			}
		}
		</script>
		
	</head>
	<body>
		<div id="main">
			<a class="facegram" href="/main">FACEGRAM</a>
		</div>

		<div id="login">
			<form method="POST"> 
				<h3>FACEGRAM 비밀번호찾기</h3>
				<h5>아이디와 연락처를 입력해주세요.</h5>
				<dl>
					<dd>아이디</dd>
					<dd>
						<input type="text" id="member_id" name="member_id">
					</dd>
					
					<dd>연락처</dd>
					<dd>
						<input type="text" id="member_phone" name="member_phone">
					</dd>
					<br>
					<dd>
						<input type="button" value="조회" onclick="find_pw(this.form)">
						<input type="button" value="이전" onclick="history.back()">
					</dd>
				</dl>
			</form>
		</div>	
	</body>
</html>