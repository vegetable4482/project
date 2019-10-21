<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
</head>
<style>
.errMsg {
		color : #f00;
		font-size: 0.8rem;
	}
	.custom-f{
		font-size: 0.8rem;
		font-weight: bold;
	}

@media screen and (min-width:768px) {
.form-signin{
	margin:0px 35%;
}
#logo{
 text-align:left;
}
}
</style>
<script>
	window.addEventListener("load",init,false);
	function init(){
		let deleteBtn = document.getElementById("deleteBtn");
		deleteBtn.addEventListener("click",memberDelete,false);
		
	}
	
	function memberDelete(){
		if(confirm("탈퇴하시겠습니까?")){
			 document.getElementById('frm').submit();
	}
	}
</script>
<body>
	<jsp:include page="../header.jsp" />

	<body class="text-center">
	<form class="form-signin" id="frm" action="${pageContext.request.contextPath}/member/memberDelete" method="post">



  <input type="email" id="id" name="id"   class="form-control"
			placeholder="ID"  value="${sessionScope.user.id }" readOnly required autofocus>


	<b class="errMsg"></b>
	
	<br>
  <label for="inputPassword" class="sr-only">Password</label>
  <input type="password" id="pw" name="pw" class="form-control"
			placeholder="Password" required>
	<b class="errMsg"></b>
 
  <input class="btn btn-lg btn-primary btn-block" type="button" id="deleteBtn" value="탈퇴하기">
  <p class="mt-5 mb-3 text-muted">&copy; 2017-2019</p>
</form><jsp:include page="../footer.jsp" />
</body>


</html>