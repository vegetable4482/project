<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <jsp:include page="../header.jsp" />
    <style>
    .col{padding:7px 7px};	
    </style>
    <script>
    window.addEventListener("load",init,false);
    function init(){
    	let modifyBtn = document.getElementsByClassName("modifyBtn");
    	let deleteBtn = document.getElementsByClassName("deleteBtn");
    	
    	Array.from(modifyBtn).forEach(function(item){
    		item.addEventListener("click",modifyBtnf,false);
    	});
    	Array.from(deleteBtn).forEach(function(item){
    		item.addEventListener("click",deleteBtnf,false);
    	});
    	
    	function modifyBtnf(){
    		document.location.href ="${pageContext.request.contextPath}" +this.getAttribute("data-url");
    	}
    	
    	function deleteBtnf(){
    		if(confirm("탈퇴하시겠습니까?")){
    		document.location.href ="${pageContext.request.contextPath}" +this.getAttribute("data-url");
    		}
    		
    	}
    }
    </script>
<div class="container">
	<div class="row justify-content-center">
	<div class="col col-sm-12 h2 text-center">회원 정보 리스트</div>
	</div>
	<div class="row border">
		<div class="col col-md-2">아이디</div>
		<div class="col col-md-2">전화번호</div>
		<div class="col col-md-1">별칭</div>
		<div class="col col-md-1">성별</div>
		<div class="col ">지역</div>
		<div class="col ">생년월일</div>
		<div class="col ">가입일</div>
		<div class="col ">수정일</div>
		<div class="col ">수정</div>
		<div class="col ">삭제</div>
	</div>
	<c:forEach items="${memberList}" var="memberDTO">
	<div class="row border">
		<div class="col col-md-2">${memberDTO.id }</div>
		<div class="col col-md-2">${memberDTO.tel }</div>
		<div class="col col-md-1">${memberDTO.nickname }</div>
		<div class="col col-md-1">${memberDTO.gender }</div>
		<div class="col">${memberDTO.region }</div>
		<div class="col">${memberDTO.birth }</div>
		<div class="col">${memberDTO.cdate }</div>
		<div class="col">${memberDTO.udate }</div>
		<div class="col"><button class="btn btn-warning btn-sm modifyBtn " data-url="/member/memberModifyForm/${memberDTO.id }">수정</button></div>
		<div class="col"><button class="btn btn-danger btn-sm deleteBtn" data-url="/member/memberDelete/${memberDTO.id }">삭제</button></div>
	</div>
	</c:forEach>
</div>
<jsp:include page="../footer.jsp" />
