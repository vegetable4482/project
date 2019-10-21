<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
<script>
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
			document.location.href="${pageContext.request.contextPath }/fbbs/reply/${page}/${FbbsDTO.freebnum}";
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
				document.location.href="${pageContext.request.contextPath }/fbbs/delete/${page}/${FbbsDTO.freebnum}";
			}
		});
		//목록으로 이동
		$("#listBtn, #listBtn2").on("click", function(e){
			e.preventDefault();
			console.log("목록");
			location.href="${pageContext.request.contextPath }/fbbs/list/${page}";
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
				$("#title").text("인테리어 토크");
				//2) 제목,내용 필드를 readOnly="true"
				$("#freebtitle").attr("readOnly","true");
				$("#freebcontent").attr("readOnly","true");
				//3) 읽기모드 버튼그룹만 display:true 
				$("#rmode").css({"display":""});
				$("#umode").css({"display":"none"});
				
			}else{
			//수정모드	
				//1) 제목변경 => 게시글 수정
				$("#title").text("게시글 수정");
				//2) 제목,내용 필드를 readOnly="false"
				$("#freebtitle").removeAttr("readOnly");
				$("#freebcontent").removeAttr("readOnly");
				//3) 수정모드 버튼그룹만 display:true 		
				$("#rmode").css({"display":"none"});
				$("#umode").css({"display":""});				
			}						
		} 
		
		function valChk() {
			//제목 입력값이 없을경우
			if($("#freebtitle").val().length == 0) {
				$("#err_1").text("제목을 입력하세요!");
				$("#freebtitle").focus();
				return false;
			}
			
			//내용 입력값이 없을경우
			if($("#freebcontent").val().length == 0) {
				$("#err_2").text("내용을 입력하세요!");
				$("#freebcontent").focus();
				return false;
			}	
			
			return true;
		}
	});
	
</script>
<hr>
<div class="container">
<div class="row justify-content-center">
	<div class="col col-sm-12 ">
	<form:form modelAttribute="fbbsDTO" 
						 action="${pageContext.request.contextPath }/fbbs/modify/${page }"
						 method="post">
		<form:hidden path="freebnum" value="${fbbsDTO.freebnum }"/>
		<form:hidden path="freebname" value="${fbbsDTO.freebname }"/>
		<form:hidden path="freebid" value="${fbbsDTO.freebid }"/>

		<div class="form-group row justify-content-left my-3" style="border-bottom:2px solid #FF8800; font-family: 'NanumSquare', sans-serif; font-weight:bold;">
			<p class="h4" id="title"></p>
		</div>	
	
		<div class="form-group row border-bottom ">
			<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="freebtitle">제 목</form:label>
			<form:input class="form-control col-md-10 border border-white" style="background:white;" path="freebtitle"  placeholder="제목을 입력하세요"
				value="${fbbsDTO.freebtitle }" readOnly="true"/>
			<div class="col-md-2"></div>
			<span id="err_1" class="errmsg"></span>
			<form:errors class="errmsg" path="freebtitle" ></form:errors>		
		</div>
		<div class="form-group row border-bottom">
			<label class="col-form-label col-sm-12 col-md-2 px-0" >작성자</label>
			<label class="form-control col-md-10 form-control-plaintext">
			${fbbsDTO.freebname }(${fbbsDTO.freebid })</label>
		</div>
	
		<div class="form-group row">
			<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="freebcontent"></form:label>
			<form:textarea class="form-control col-md-15" path="freebcontent" rows="10" style="background:white;"
										 value="${fbbsDTO.freebcontent }" readOnly="true" placeholder="내용을 입력하세요"/>
			<div class="col-md-2"></div>
			<span id="err_2" class="errmsg"></span>
			<form:errors class="errmsg" path="freebcontent" ></form:errors>	
		</div>
		<!-- 게시글 보기 버튼 -->
		<div id="rmode">
			<div class="form-group row justify-content-end">
				<div class="col-sm-1 px-0 m-1">
				
				</div>
				
				<!-- 작성자만 수정, 삭제 가능 시작 -->
				<c:if test="${fbbsDTO.freebid eq sessionScope.user.id }">
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
		
	
	
<jsp:include page="rereply.jsp"/>
	</div>
	<jsp:include page="../footer.jsp"/>
	
	





