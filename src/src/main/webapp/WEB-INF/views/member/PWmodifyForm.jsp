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

</head>
<style>
#error_1{
 color:red;
 font-size:0.8rem;
}

</style>
<script>

$(function(){
		//확인버튼 클릭시
	$("#okBtn").on("click",function(e){
		//해당요소의 기본 이벤트 막기
		e.preventDefault();
		if($("#fromPW").val().length == 0) {
			$("#error_1").text('현재 비밀번호를 입력하세요!');
			$("#fromPW").focus();
			return false;
		};
		
		if($("#toPW").val().length == 0) {
			$("#error_2").text('새 비밀번호를 입력하세요!');
			$("#toPW").focus();
			return false;
		};
		
		if($("#toPWChk").val().length == 0) {
			$("#error_3").text('새 비밀번호 확인을 입력하세요!');
			$("#toPWChk").focus();
			return false;
		};
		
		if($("#toPW").val() != $("#toPWChk").val() ) {
			$("#error_3").text('새비밀번호와 비밀번호 확인이 일치하지 않습니다.');
			$("#toPWChk").focus();
			return false;				
		}
		
		if($("#fromPW").val() == $("#toPW").val() ) {
			$("#error_3").text('현재비밀번호와 새비밀번호가 동일합니다.');
			$("#toPW").focus();
			return false;				
		}			
		$("#passwdDTO").submit();			
	}); 
		//취소버튼 클릭시
		$("#cancelBtn").on("click",function(e){
		//해당요소의 기본 이벤트 막기
		e.preventDefault();
		$("#passwdDTO").each(function(){
			this.reset();
		})
		});
		
});
</script>
<jsp:include page="../header.jsp"/>
<hr>
<body>
 <div class="row my-5"></div>
	<form:form modelAttribute="passwdDTO" 
							 action="${pageContext.request.contextPath }/member/changePw"
							 method="post">
		<form:hidden path="id" value="${sessionScope.user.id}"/>	
      <div id="joinHeader"> <span id="h1">내정보관리</span></div>
    <div id="tipbox"><p id="tipboxH">비밀번호 변경</p>
    <ul>
      <li>비밀번호는 영문과 특수문자, 숫자 3가지를 조합하여 ~자리로 입력해주세요.</li>
      <li>개인정보와 관련된 숫자 등 다른 사람이 알아낼 수 있는 비밀번호는 사용하지 않는 것이 안전합니다.</li>
      <li><span class="ast">*</span> 는 필수 입력사항입니다</li>
    </ul></div>
    
      <table id="joinTable">
        <tr>
            <th class="article">현재비밀번호 <span class="ast">*</span></th>
            <td>
            <div class="form-group my-0">
			<form:password class="form-control" path="fromPW" placeholder="현재 비밀번호를 입력하세요"></form:password>
		</div>
			<form:errors path="fromPW" class="errMsg"></form:errors>
			<span id="error_1" class="errMsg"></span> 
       </td>
          </tr>
          <tr>
              <th class="article">새 비밀번호 <span class="ast">*</span></th>
              <td>
              
              <div class="form-group my-0">
									<form:password class="form-control" path="toPW" placeholder="영문과 숫자의 조합[6~10자리]"></form:password>
								</div>
									<form:errors  path="toPW" class="errMsg"></form:errors>
									<span id="error_2" class="errMsg"></span>			
             		  <span id="pwMsg" class="subMsg">  </span>
              </td>
            </tr>
            <tr>
                <th class="article">비밀번호 확인 <span class="ast">*</span></th>
                <td>
               <div class="form-group my-0">
									<input class="form-control" type="password" id="toPWChk" placeholder="영문과 숫자의 조합[6~10자리]"/>
								</div>
									<span id="error_3" class="errMsg"></span>		
                </td>
         </tr>
    </table>

    <br>
    
    <div id="chkBtn">
      <input type="button" class="btn btn-outline-secondary" id="cancelBtn" value="취소" />&nbsp;&nbsp;&nbsp;
      <input type="button" style="background-color: #ff8800; color:white;" class="btn btn-warning" value="확인" id="okBtn"/>    
    </div>
     <div class="row my-5"></div>
    </form:form>
</body>
<jsp:include page="../footer.jsp"/>
</html>