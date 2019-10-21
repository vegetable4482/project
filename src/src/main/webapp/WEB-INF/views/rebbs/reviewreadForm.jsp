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
	#img{
		
	}
	#content{
		 border: 1px solid gray;
		 padding: 10px;
	}
	#reviewbcontent{
		background-color: white;
		border: none;
	}
	#reviewbtitle{
		background-color: white;
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
				document.location.href="${pageContext.request.contextPath }/rebbs/delete/${page}/${rebbsDTO.reviewbnum}";
			}
		});
		//목록으로 이동
		$("#listBtn, #listBtn2").on("click", function(e){
			e.preventDefault();
			console.log("목록");
			location.href="${pageContext.request.contextPath }/rebbs/list/${page}";
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
				$("#reviewbtitle").attr("readOnly","true");
				$("#reviewbcontent").attr("readOnly","true");
				$("#file").attr("readOnly","true");
				//3) 읽기모드 버튼그룹만 display:true 
				$("#rmode").css({"display":""});
				$("#umode").css({"display":"none"});
				$("#file").css({"display":"none"});
				
			}else{
			//수정모드	
				//1) 제목변경 => 게시글 수정
				$("#title").text("생생리뷰 수정");
				//2) 제목,내용 필드를 readOnly="false"
				$("#reviewbtitle").removeAttr("readOnly");
				$("#reviewbcontent").removeAttr("readOnly");
				$("#file").removeAttr("readOnly");
				//3) 수정모드 버튼그룹만 display:true 		
				$("#rmode").css({"display":"none"});
				$("#umode").css({"display":""});	
				$("#file").css({"display":""});
			}						
		} 
		
		function valChk() {
			//제목 입력값이 없을경우
			if($("#reviewbtitle").val().length == 0) {
				$("#err_1").text("제목을 입력하세요!");
				$("#reviewbtitle").focus();
				return false;
			}
			
			//내용 입력값이 없을경우
			if($("#reviewbcontent").val().length == 0) {
				$("#err_2").text("내용을 입력하세요!");
				$("#reviewbcontent").focus();
				return false;
			}	
			
			return true;
		}
	});
	function cmaTextareaSize(obj, bsize) { // 객체명, 기본사이즈
	    var sTextarea = document.getElementById(obj);
	    var csize = (sTextarea.scrollHeight >= bsize) ? sTextarea.scrollHeight+"px" : bsize+"px";
	    sTextarea.style.height = bsize+"px"; 
	    sTextarea.style.height = csize;
	}
</script>
<hr>
<div class="container">
<div class="row justify-content-center">
	<div class="col col-sm-12 col-md-8">
	<form:form modelAttribute="rebbsDTO" 
						 action="${pageContext.request.contextPath }/rebbs/modify/${page }"
						 method="post"
						 enctype="multipart/form-data">
	<form:hidden path="reviewbnum" value="${rebbsDTO.reviewbnum }"/>
	<form:hidden path="reviewbname" value="${rebbsDTO.reviewbname }"/>
	<form:hidden path="reviewbid" value="${rebbsDTO.reviewbid }"/>
	<form:hidden path="reviewbcdate" value="${rebbsDTO.reviewbcdate }"/>
	<form:hidden path="revieworiginFn" value="${rebbsDTO.revieworiginFn }"/> 
	<form:hidden path="reviewrandomFn" value="${rebbsDTO.reviewrandomFn }"/> 

	<div class="row justify-content-start my-3">
		<p class="h4" id="title"></p>
	</div>	
	<div class="form-group row">
		<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="reviewbtitle">제 목</form:label>
		<form:input class="form-control col-md-10" path="reviewbtitle"  placeholder="제목을 입력하세요"
			value="${rebbsDTO.reviewbtitle }" readOnly="true"/>
		<div class="col-md-2"></div>
		<span id="err_1" class="errmsg"></span>
		<form:errors class="errmsg" path="reviewbtitle" ></form:errors>		
	</div>
	<div class="form-group row">
		<label class="col-form-label col-sm-12 col-md-2 px-0" >작성자</label>
		<label class="form-control col-md-10 form-control-plaintext">
		${rebbsDTO.reviewbid }</label>
	</div>
	<div class="form-group row">
		<label class="col-form-label col-sm-12 col-md-2 px-0" >파일첨부</label>
		<label class="form-control col-md-10 form-control-plaintext">
		${rebbsDTO.revieworiginFn }<input type="file" class="control form-control-sm " id="file" name="file"/>

</label>
		
	</div>
	<div class="form-group row"  id="content">
		
		<img class="col align-self-center px-0"  src="${pageContext.request.contextPath }/resources/img/reupload/${rebbsDTO.reviewrandomFn}" alt="이미지"  height="900" width="600" id=img/>			 
		<form:textarea class="form-control col-md-15" path="reviewbcontent"  onchange="cmaTextareaSize('reviewbcontent', 10);" onkeyup="cmaTextareaSize('reviewbcontent', 10);" 
									 value="${rebbsDTO.reviewbcontent }" readOnly="true" placeholder="내용을 입력하세요"/>
		<script>cmaTextareaSize('reviewbcontent', 10);</script>
		<div class="col-md-2"></div>
		<span id="err_2" class="errmsg"></span>
		<form:errors class="errmsg" path="reviewbcontent" ></form:errors>	
	</div>

	<!-- 게시글 보기 버튼 -->
	<div id="rmode">
		<div class="form-group row justify-content-end">
			
			
			<!-- 작성자만 수정, 삭제 가능 시작 -->
			<c:if test="${rebbsDTO.reviewbid eq sessionScope.user.id }">
			<div class="col-sm-1 px-0 m-1">
			<button class="btn btn-sm btn-outline-secondary btn-block" id="modifyBtn">수정</button>
			</div>
			<div class="col-sm-1 px-0 m-1">
			<button class="btn btn-sm btn-outline-secondary btn-block" id="deleteBtn">삭제</button>
			</div>
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
	





