<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="ko">

<head>

	<title>개인회원 관리</title>

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
      
      managerMenu2.style ="background-color : rgb(56, 56, 56) ; color:white;";
      managerMenu1.style.removeProperty("background-color");
      managerMenu1.style.removeProperty("color");
      managerMenu3.style.removeProperty("background-color");
      managerMenu3.style.removeProperty("color");
      
    
	  	let delBtn = document.getElementsByClassName("delBtn");
			Array.from(delBtn).forEach(function(item){
				item.addEventListener("click",deleteMember,false);
			});

	    function deleteMember() {
				if(confirm("해당 회원을 탈퇴시키겠습니까?")) {
					document.location.href = "${pageContext.request.contextPath }" + this.getAttribute("data-url");
				}
   		}
    
    }
	</script>
	
	<style>
	  body {
	  	font-family: 'NanumSquare', sans-serif;
	  	font-weight: 700;
	  }
	  .bd-placeholder-img {
	    font-size: 1.125rem;
	    text-anchor: middle;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	  }
	  .nav-link {
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
	  .form-signin {
	    width: 400px;
	    margin:0 auto;
	  }
	  #inputEmail, #inputPassword {
	   margin:20px 0px;
	  }
	  #Emanagerlist {
	    margin-top: 80px;
	    
	  }
	  table {
	    /* border-collapse: collapse; */
	    table-layout: auto;
	  }
	  th, td {
	  	 padding: 3px 5px 3px 5px;
	     border: 1px solid rgb(223, 223, 223);
	     text-align: center;
	     font-size: 17px;
	     font-family: 'NanumBarunGothic', sans-serif;
	     font-weight: 500;
	  }
    tr:hover {
      background-color: rgb(247, 247, 247);
    }
	</style>
	
</head>

<body>
	<jsp:include page="../nav.jsp" />
	
<div class="h-100 d-flex justify-content-center align-items-center">
	<table style="margin-left: 18%;">
		<tr style="background-color:rgb(238, 238, 238); ">
			<th>NO</th>
			<th>아이디</th>
			<th>성명</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>가입일</th>
			<th>탈퇴처리</th>
		</tr>
		<c:choose>
			<c:when test="${empty sessionScope.administrator }">
				<tr>
					<td colspan="7" style="padding: 100px 400px;">잘못된 접근입니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${memberList}" var="memberDTO">
					<tr>
						<td style="text-align: center;">${memberDTO.membernum }</td>
						<td style="text-align: center;">${memberDTO.id }</td>
						<td style="text-align: center;">${memberDTO.name }</td>
						<td style="text-align: center;">${memberDTO.basicaddress } ${memberDTO.restaddress }</td>
						<td style="text-align: center;">${memberDTO.phonenum }</td>
						<td style="text-align: center;">${memberDTO.membercdate }</td>
						<th style="text-align: center;"><button type="button" style="background-color: red; color:white;" class="btn delBtn" data-url="/member/memberDelete/${memberDTO.id }">삭제</button></th>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
</div>

	<jsp:include page="../sidebar.jsp"></jsp:include>
</body>
</html>