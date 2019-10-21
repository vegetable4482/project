<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 제이쿼리 -->
 <script src="${pageContext.request.contextPath }/webjars/jquery/3.4.1/dist/jquery.js" ></script>
 <!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath }/webjars/bootstrap/4.3.1/css/bootstrap.css" rel="stylesheet">
 <!-- form css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/modify.css"/>
<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumBarunGothic@1.0/nanumbarungothicsubset.css">

<style>
#error_1{
 color:red;
 font-size:0.8rem;
}

</style>
<script>
$(function(){
		//확인버튼 클릭시
	$("#modifirstBtn").on("click",function(e){
		//해당요소의 기본 이벤트 막기
		e.preventDefault();
		if($("#firstpw").val().length == 0) {
			$("#error_1").text('비밀번호를 입력하세요.');
			$("#firstpw").focus();
			return false;
		}
		if($("#firstpw").val() != $("#pw").val() ) {
			$("#error_1").text('비밀번호가 일치하지 않습니다.');
			$("#firstpw").focus();
			return false;				
		}			
			$("#PWchkForm").submit();			
	}); 
		
		//취소버튼 클릭시
		$("#cancelBtn").on("click",function(e){
		//해당요소의 기본 이벤트 막기
		e.preventDefault();
		$("#PWchkForm").each(function(){
			this.reset();
		})
		});
		
});
</script>

<body>
<jsp:include page="../header.jsp"/>
<hr>
 <form id="PWchkForm" action="${pageContext.request.contextPath }/member/PWchk" method="post">
  	<input type="hidden" id="id" name="id" value="${sessionScope.user.id }">
  	<input type="hidden" id="pw" name="pw" value="${sessionScope.user.pw }">
      <div id="joinHeader"> <span id="h1">내정보관리</span></div>
    <div id="tipbox"><p id="tipboxH">회원 정보 수정</p>
    <ul>
      <li>성명,주소,휴대 전화 번호를 수정할 수 있습니다.</li>
    </ul></div>
      <table id="joinTable">
        <tr>
            <th class="article">현재비밀번호 <span class="ast">*</span></th>
            <td>
             <div class="form-row">
          		<div class="col-sm-12 ">
         
            <input type="password" class="form-control form-control-sm" placeholder="현재 비밀번호를 입력하세요"  id="firstpw" name="firstpw"  required />
              <span id="error_1" class="errMsg"></span>
                <form:errors path="firstpw" class="errMsg"></form:errors>
         
           </div>
          </div>
            </td>
            
          </tr>
    </table>

    <br>
    
    <div id="chkBtn">
      <input type="button" class="btn btn-outline-secondary" value="취소" id="cancelBtn"/>&nbsp;&nbsp;&nbsp;
      <button type="submit" style="background-color: #ff8800; color:white;" class="btn btn-warning" id="modifirstBtn">확인</button>
    </div>
  </form>
</body>
</html>