<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.myapp.intbbs.dto.IntDTO"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../header.jsp"/>
<style>
	.errmsg {
		color : #f00;
		font-weight: bold;
		font-size : 0.8em;
	}
	.col{
	border: 1px solid none;
	}
	textarea.autosize { 
	min-height: 50px; 
	}
	
	#intbcontent{
	 background-color: white;
	 border: none;
	}
</style>
<script>
<% IntDTO mdto = (IntDTO)request.getAttribute("mdto"); %>
	$(function() {
		
		let errmsg = $(".errmsg").text();
		if(errmsg.length > 0){
			changeRmode(false);
		}else{
			changeRmode(true);
		}
		
		//답글 등록
		$("#replyBtn").on("click", function(e){
			e.preventDefault();
			console.log("답글");
			document.location.href="${pageContext.request.contextPath }/bbs/intreply/${page}/${intDTO.intbnum}";
		});
		//게시글 수정모드 전환
		$("#modifyBtn").on("click", function(e){
			e.preventDefault();
			console.log("수정모드전환");
			changeRmode(false);
		});
		//게시글 삭제
		$("#deleteBtn").on("click", function(e){
			e.preventDefault();
			console.log("삭제");
			if(confirm("삭제하시겠습니까?")) {
				document.location.href="${pageContext.request.contextPath }/intbbs/intdelete/${page}/${intDTO.intbnum}";
			}
		});
		//목록으로 이동
		$("#listBtn, #listBtn2").on("click", function(e){
			e.preventDefault();
			console.log("목록");
			location.href="${pageContext.request.contextPath }/intbbs/intlist/${page}";
		});		
		//게시글 읽기모드 전환
		$("#cancelBtn").on("click", function(e){
			e.preventDefault();
			console.log("읽기모드");
			changeRmode(true);
		});
		//게시글 수정
		$("#saveBtn").on("click", function(e){
			e.preventDefault();
			console.log("수정");
			if(valChk()) {
				$("form").submit();
			}
		});
		
		function changeRmode(flag){
			//읽기모드
			if(flag){
				//1) 제목변경 => 게시글 보기
				$("#title").text("");
				//2) 제목,내용 필드를 readOnly="true"
				$("#intbtitle").attr("readOnly","true");
				$("#intbcontent").attr("readOnly","true");
				//3) 읽기모드 버튼그룹만 display:true 
				$("#rmode").css({"display":""});
				$("#umode").css({"display":"none"});
				
			}else{
			//수정모드	
				//1) 제목변경 => 게시글 수정
				$("#title").text("게시글 수정");
				//2) 제목,내용 필드를 readOnly="false"
				$("#intbtitle").removeAttr("readOnly");
				$("#intbcontent").removeAttr("readOnly");
				//3) 수정모드 버튼그룹만 display:true 		
				$("#rmode").css({"display":"none"});
				$("#umode").css({"display":""});				
			}						
		} 
		
		function valChk() {
			//제목 입력값이 없을경우
			if($("#intbtitle").val().length == 0) {
				$("#err_1").text("제목을 입력하세요!");
				$("#intbtitle").focus();
				return false;
			}
			
			//내용 입력값이 없을경우
			if($("#intbcontent").val().length == 0) {
				$("#err_2").text("내용을 입력하세요!");
				$("#intbcontent").focus();
				return false;
			}	
			
			return true;
		}
		
		function resize(obj) {
			  obj.style.height = "1px";
			  obj.style.height = (12+obj.scrollHeight)+"px";
			}

	});
	
</script>
<hr>
<div class="row justify-content-center my-5 py-3 " style="background:rgb(244,244,244); font-family: 'NanumSquare', sans-serif; font-weight:bold;">
				<p class="h4 py-3" >종합 인테리어</p>
			</div>
<div class="container">
<div class="row justify-content-center">
	<div class="col col-sm-12 col-md-8">
	<form:form modelAttribute="intDTO" 
						 action="${pageContext.request.contextPath }/intbbs/intmodify/${page }"
						 method="post">
		<form:hidden path="intbnum" value="${intDTO.intbnum }"/>
		<form:hidden path="intbname" value="${intDTO.intbname }"/>
		<form:hidden path="intbid" value="${intDTO.intbid }"/>

		<div class="form-group row justify-content-center my-3">
			<p class="h4" id="title"></p>
		</div>	
		<div class="form-group row bo">
			<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="intbtitle">제 목</form:label>
			<form:input class="form-control col-md-10" path="intbtitle"  placeholder="제목을 입력하세요" style="background-color : white"
				value="${intDTO.intbtitle }" readOnly="true"/>
			<div class="col-md-2"></div>
			<span id="err_1" class="errmsg"></span>
			<form:errors class="errmsg" path="intbtitle" ></form:errors>		
		</div>
		<div class="form-group row">
			<label class="col-form-label col-sm-12 col-md-2 px-0" >작성자</label>
			<label class="form-control col-md-10 form-control-plaintext">
			${intDTO.intbname }(${intDTO.intbid })</label>
		</div>
		
 		<div class="row my-3">	
 			<span class="mx-3 text-warning">공간</span>
			<span class="">${intDTO.intbtype} <span class="mx-3">|</span></span>
			<span class="mx-3 text-warning">스타일</span>
			<span class="">${intDTO.intbstyle} <span class="mx-3">|</span></span>
			<span class="mx-3 text-warning">평수</span>
			<span class="">${intDTO.intblandmeter} <span class="mx-3">|</span></span>
			<span class="mx-3 text-warning">지역</span>
			<span class="">${intDTO.intbarea}</span>
		</div> 
        
		<div class="form-group row border">
			<img class="mx-1 my-1" src="${pageContext.request.contextPath }/resources/img/upload/${intDTO.randomFn}" width="100%" height="500px">
			<form:textarea class="form-control col-md-15 mx-1 my-1 autosize" path="intbcontent" rows="10"  name="cma_test1"
										 value="${intDTO.intbcontent }" readOnly="true" placeholder="내용을 입력하세요"
										 onkeydown="resize(this)" onkeyup="resize(this)" />
			<div class="col-md-2"></div>
			<span id="err_2" class="errmsg"></span>
			<form:errors class="errmsg" path="intbcontent" ></form:errors>	
		</div>
		<!-- 게시글 보기 버튼 -->
		<div id="rmode">
			<div class="form-group row justify-content-end">
				<div class="col-sm-1 px-0 m-1">
				
				</div>
				
				<!-- 작성자만 수정, 삭제 가능 시작 -->
				<c:if test="${intDTO.intbid eq sessionScope.user2.cid }">
				<div class="col-sm-1 px-0 m-1">
				<button class="btn btn-sm btn-outline-secondary btn-block" id="modifyBtn">수정</button>
				</div>
				<!-- <div class="col-sm-1 px-0 m-1">
				<button class="btn btn-sm btn-outline-secondary btn-block" id="deleteBtn">삭제</button>
				</div> -->
				</c:if>
				<!-- 작성자만 수정, 삭제 가능 끝 -->
				
				<div class="col-sm-1 px-0 m-1">
				<button class="btn btn-sm btn-outline-secondary btn-block" id="listBtn">목록</button>
				</div>
			</div>	
		</div>
		<!-- 게시글 수정 버튼 -->
		<div id="umode">
			<div class="form-group row justify-content-end">
				<div class="col-sm-1 px-0 m-1">
				<button class="btn btn-sm btn-outline-secondary btn-block" id="cancelBtn">취소</button>
				</div>
				<div class="col-sm-1 px-0 m-1">
				<button class="btn btn-sm btn-outline-secondary btn-block" id="saveBtn">저장</button>
				</div>
				<div class="col-sm-1 px-0 m-1">
				<button class="btn btn-sm btn-outline-secondary btn-block" id="listBtn2">목록</button>
				</div>
			</div>	
		</div>	
	
	
	</form:form>
	
	</div>
	</div>
	</div>
	
	
	
<%-- <jsp:include page="intrereply.jsp"/> --%>




