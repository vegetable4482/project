<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="ko">

<head>

	<title>관리자 로그인</title>

  <%-- Required meta tags --%>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">

  <%-- link reference --%>
  <%-- Bootstrap CSS --%>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

  <%-- link reference --%>
  <%-- Optional JavaScript --%>
  <%-- jQuery first, then Popper.js, then Bootstrap JS --%>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  
  <%-- initialize all elements padding 0, margin 0 --%>
  <style>
  	* {
  		padding: 0;
  		margin: 0;
  	}
  </style>
  
	<%-- Custom styles for this template --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/dashboard.css">
		
	<%-- Custom styles for this template --%>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumBarunGothic@1.0/nanumbarungothicsubset.css">
	
	<%-- Custom script and style for each jsp files --%>
	<script>
    window.addEventListener("load",init,false);

    function init(){
      let managerMenu1 = document.getElementById("managerMenu1");
      let managerMenu2 = document.getElementById("managerMenu2");
      let managerMenu3 = document.getElementById("managerMenu3");

      managerMenu1.addEventListener("click",function(){
      managerMenu1.style ="background-color : rgb(56, 56, 56) ; color:white;";
      managerMenu2.style.removeProperty("background-color");
      managerMenu2.style.removeProperty("color");
      managerMenu3.style.removeProperty("background-color");
      managerMenu3.style.removeProperty("color");

      },false);

      managerMenu2.addEventListener("click",function(){
      managerMenu2.style ="background-color : rgb(56, 56, 56) ; color:white;";
      managerMenu1.style.removeProperty("background-color");
      managerMenu1.style.removeProperty("color");
      managerMenu3.style.removeProperty("background-color");
      managerMenu3.style.removeProperty("color");
      },false);

      managerMenu3.addEventListener("click",function(){
      managerMenu3.style ="background-color : rgb(56, 56, 56) ; color:white;";
      managerMenu1.style.removeProperty("background-color");
      managerMenu1.style.removeProperty("color");
      managerMenu2.style.removeProperty("background-color");
      managerMenu2.style.removeProperty("color");
      },false);
    }
    
    window.addEventListener("load",loginBtn_initialize,false);
    function loginBtn_initialize() {
			let loginBtn = document.getElementById("loginBtn");
			loginBtn.addEventListener("click",loginBtnf,false);
    }
		function loginBtnf() {
			//유효성 체크
			//1) 아이디
			let idTag = document.getElementById("idInput");
			if(idTag.value.length == 0) {
				alert("ID값은 필수입니다.");
				return false;
			}
			
			//2) 비밀번호
			let pwTag = document.getElementById("pwInput");		
			if(pwTag.value.length == 0) {
				alert("PW값은 필수입니다.")
				return false;
			}
			
			//양식을 서버에 전송
			document.getElementById("adminLoginForm").submit();
			}
	</script>
	
	<style>
      body  {    font-family: 'NanumSquare', sans-serif;  font-weight: 700;}
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }
      .nav-link{
        font-size: 18px;
      }
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }
      .form-signin{
        width: 400px;
        margin:0 auto;
      }
      #inputEmail, #inputPassword{
       margin:20px 0px;
      }
      #managerH{
        margin-top: 200px;
        text-align: center;
	</style>
	
</head>

<body>
	<jsp:include page="../nav.jsp" />
	
		<div class="h-100 d-flex justify-content-center align-items-center">
			<div class="w-50 d-flex flex-column justify-content-center align-items-center">
		    <div class="mx-auto"><img src="${pageContext.request.contextPath }/resources/img/indexLogo.jpg" alt="이미지 로딩 실패" width="400px" height="200px"></div>
		    <h1 class="text-center h1 mb-3 font-weight-bold">집중 관리자 로그인</h1>
				<form class="w-50" id="adminLoginForm" action="${pageContext.request.contextPath }/administrator/loginAccess" method="post">
			    <input type="email" id="idInput" name="aId" class="form-control py-2" placeholder="ID" required autofocus>
			    <input type="password" id="pwInput" name="aPw" class="form-control py-2" placeholder="Password" required>
			    <button class="btn btn-lg btn-dark btn-block" id="loginBtn" type="submit">로그인</button>
		  	</form>
	    </div>
  	</div>
	
	<jsp:include page="../sidebar.jsp"></jsp:include>
</body>
</html>