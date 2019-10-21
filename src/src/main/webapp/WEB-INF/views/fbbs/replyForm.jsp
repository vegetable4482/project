<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../header.jsp"/>
<style>
	.errmsg {
		color : #f00;
		font-weight: bold;
		font-size : 0.8em;
	}

</style>
<script>
	$(function() {
		//게시글 등록
		$("#writeBtn").on("click", function(e){
			e.preventDefault();
			///console.log("등록");
			if(valChk()) {
				$("form").submit();
			}
		});
		
		//게시글 취소
		$("#cancelBtn").on("click", function(e){
			e.preventDefault();
			//console.log("취소");
			$("form").each(function(){
				this.reset();
			});
		});
		
		//목록으로 이동
		$("#listBtn").on("click", function(e){
			e.preventDefault();
			//console.log("목록");
			location.href="${pageContext.request.contextPath }/fbbs/list/${page}";
		});
		

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
<div class="container">
<div class="row justify-content-center">
	<div class="col col-sm-12 col-md-8">
	<form:form modelAttribute="fbbsDTO" action="${pageContext.request.contextPath }/fbbs/reply">
	<form:hidden path="freebid" value="${sessionScope.user.id }"/>
	<form:hidden path="freebname" value="${sessionScope.user.nickname }"/>
	<form:hidden path="freebgroup" value="${fbbsDTO.freebgroup }"/>
	<form:hidden path="freebstep" value="${fbbsDTO.freebstep }"/>
	<form:hidden path="freebindent" value="${fbbsDTO.freebindent }"/>
	<div class="form-group row justify-content-center my-3">
		<p class="h4"> 답글 작성 </p>
	</div>	
	<div class="form-group row">
		<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="freebtitle">제 목</form:label>
		<form:input class="form-control col-md-10" path="freebtitle"  placeholder="제목을 입력하세요"
								value="[답글]: ${fbbsDTO.freebtitle }"/>
		<div class="col-md-2"></div>
		<span id="err_1" class="errmsg"></span>
		<form:errors class="errmsg" path="freebtitle" ></form:errors>		
	</div>
	<div class="form-group row">
		<label class="col-form-label col-sm-12 col-md-2 px-0" >작성자</label>
		<label class="form-control col-md-10 form-control-plaintext">
		${sessionScope.user.nickname }(${sessionScope.user.id })</label>
	</div>
	<div class="form-group row">
		<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="freebcontent">내 용</form:label>
		<form:textarea class="form-control col-md-10" path="freebcontent" rows="10" placeholder="내용을 입력하세요"
									 value="[원글]: ${fbbsDTO.freebcontent }"/>
		<div class="col-md-2"></div>
		<span id="err_2" class="errmsg"></span>
		<form:errors class="errmsg" path="freebcontent" ></form:errors>	
	</div>
	<div class="form-group row justify-content-end">
		<div class="col-sm-1 px-0 m-1">
		<button class="btn btn-sm btn-outline-secondary btn-block" id="writeBtn">등록</button>
		</div>
		<div class="col-sm-1 px-0 m-1">
		<button class="btn btn-sm btn-outline-secondary btn-block" id="cancelBtn">취소</button>
		</div>
		<div class="col-sm-1 px-0 m-1">
		<button class="btn btn-sm btn-outline-secondary btn-block" id="listBtn">목록</button>
		</div>
	</div>	
	</form:form>
	</div>
</div>
</div>
<jsp:include page="../footer.jsp"/> --%>