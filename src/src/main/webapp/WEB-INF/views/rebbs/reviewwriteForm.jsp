<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../header.jsp"/>
<style>
	.errmsg {
		color : #f00;
		font-weight: bold;
		font-size : 0.8em;
	}
	.alert{
		border: 1px solid gray;
	}
	.fileDrop {
		width: 600px;
		height: 70px;
		border: 2px dotted gray;
		background-color: gray;
	}	
</style>
<script src="${pageContext.request.contextPath }/resources/js/ckeditor.js"></script>
<script>
	$(function() {

		//CKEDITOR
/*     ClassicEditor
        .create( document.querySelector( '#bcontent' ) )
		    .then( editor => {
		        console.log( 'Editor was initialized', editor );
		    } )      
        .catch( error => {
            console.error( error );
        } ); */
  
		
		//게시글 등록
		$("#writeBtn").on("click", function(e){
			e.preventDefault();
			///console.log("등록");
			/* if(valChk()) { */
				$("form").submit();
			/* } */
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
			location.href="${pageContext.request.contextPath }/rebbs/list";
		});
		

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
<div class="container">
<div class="row justify-content-center">
	<div class="col col-sm-12 col-md-8">
	<form:form modelAttribute="rebbsDTO" action="${pageContext.request.contextPath }/rebbs/write"
		enctype="multipart/form-data">
	<form:hidden path="reviewbid" value="${sessionScope.user.id }"/>
	<form:hidden path="reviewbname" value="${sessionScope.user.name }"/>
	<div class="row justify-content-start my-3">
		<p class="h4">생생리뷰 작성</p>
	</div>	
	<div class="form-group row">
		<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="reviewbtitle">제 목</form:label>
		<form:input class="form-control col-md-10" path="reviewbtitle"  placeholder="제목을 입력하세요"/>
		<div class="col-md-2"></div>
		<span id="err_1" class="errmsg"></span>
		<form:errors class="errmsg" path="reviewbtitle" ></form:errors>		
	</div>
	<div class="form-group row">
		<label class="col-form-label col-sm-12 col-md-2 px-0" >작성자</label>
		<label class="form-control col-md-10 form-control-plaintext">
		${sessionScope.user.id }</label>
	</div>
	<div class="form-group row">
		<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="">파일첨부</form:label>
		<div class="col-md-10" >
            <input type="file" class="control form-control-sm " id="file" name="file"/>
		</div>
		
	</div>
	<div class="form-group row">
		<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="reviewbcontent">내 용</form:label>
		<form:textarea class="form-control col-md-10" path="reviewbcontent" rows="10" placeholder="내용을 입력하세요"/>
		
		
		<div class="col-md-2"></div>
		<span id="err_2" class="errmsg"></span>	
		<form:errors class="errmsg" path="reviewbcontent" ></form:errors>	
	</div>
	<div class="form-group row justify-content-start">
	<div class="alert alert-light mr-3">평점:</div>
	<div class="row alert alert-light justify-content-content">
		    <!-- 평점 선택창 -->
    <form:label path="reviewbscore" ></form:label>
    <form:select path="reviewbscore" style="color:#FF8800">
        <form:options items="${ ratingOptions }"/>
    </form:select>
		</div>
	</div>
<%-- 		<div class="form-group row justify-content-start">
	<div class="alert alert-light mr-3">공사품질</div>
	<div class="row alert alert-light justify-content-content" >
    <form:label path="reviewbscore"></form:label>
    <form:select path="reviewbscore">
        <form:options items="${ ratingOptions }"/>
    </form:select>
		</div>
	</div> --%>

				<div class="form-group row justify-content-end">
		<div class="col-sm-1 px-0 m-1">
		<button class="btn btn-sm btn-outline-secondary btn-block" id="writeBtn" style="background-color:#FF8800">등록</button>
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
<jsp:include page="../footer.jsp"/>