<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.myapp.intbbs.dto.IntDTO"%>     
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../header.jsp"/>
<style>
	.errmsg {
		color : #f00;
		font-weight: bold;
		font-size : 0.8em;
	}

</style>
<script src="${pageContext.request.contextPath }/resources/js/ckeditor.js"></script>
<script>
	$(function() {

		//CKEDITOR
/*     ClassicEditor
        .create( document.querySelector( '#intbcontent' ) )
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
			location.href="${pageContext.request.contextPath }/intbbs/intlist";
		});
		

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
	});
	
</script>
<% IntDTO mdto = (IntDTO)request.getAttribute("mdto"); %>
<div class="container">
<div class="row justify-content-center">
	<div class="col col-sm-12 col-md-8">
	<form:form modelAttribute="intDTO" action="${pageContext.request.contextPath }/intbbs/intwrite" enctype="multipart/form-data"  method="POST" >
	
	<form:hidden path="intbid" value="${sessionScope.user2.cid }"/>
	<form:hidden path="intbname" value="${sessionScope.user2.cname }"/>

	<div class="form-group row justify-content-center my-3">
		<p class="h4"> 게시글 작성 </p>
	</div>	
	<div class="form-group row">

		<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="intbtitle">제 목</form:label>
		<form:input class="form-control col-md-10" path="intbtitle"  placeholder="제목을 입력하세요"/>
	
		<div class="col-md-2"></div>
		<span id="err_1" class="errmsg"></span>
		<form:errors class="errmsg" path="intbtitle" ></form:errors>		
	</div>
	<div class="form-group row">
		<label class="col-form-label col-2 px-0" >작성자</label>
		<label class="form-control col-md-10 form-control-plaintext">
			${sessionScope.user2.cname }(${sessionScope.user2.cid })
		</label>
	</div>
	<div class="form-group row">
    <label for="file" class="col-form-label col-2 px-0">파일첨부</label>
    <input type="file" class="form-control col-md-10 form-control" id="file" name="file"/>
   </div> 
	<div class="form-group row">


<!--   <div class="form-row">
    <div class="col-sm-12 mb-1">
       <label for="file" class="col-form-label-sm my-0 py-1">파일첨부</label>
       <input type="file" class="form-control form-control-sm " id="file" name="file"/>
    	 <div class=""></div>
    </div>
   </div>  -->

<div class="row justify-content-between my-5 border"><!--메뉴 영역-->
         
            <div class="align-self-center mx-3">
              공간
            </div>

            <select class="form-control form-control-lg align-self-center" style="width: 100px" name="intbtype" id="intbtype">
              <option value="0">전체</option>
              <option value="아파트">아파트</option>
              <option value="빌라">빌라</option>
              <option value="주택">주택</option>
            </select>
            
            <div class="align-self-center mx-3">
              스타일
            </div>

            <select class="form-control form-control-lg align-self-center" style="width: 100px" name="intbstyle" id="intbstyle">
              <option value="전체">전체</option>
              <option value="모던">모던</option>
              <option value="클래식">클래식</option>
              <option value="빈티지">빈티지</option>
              <option value="인더스트리얼">인더스트리얼</option>
              <option value="미니멀리즘">미니멀리즘</option>
            </select>

            <div class="align-self-center mx-3">
              평수
            </div>

            <select class="form-control form-control-lg align-self-center" style="width: 100px" name="intblandmeter" id="intblandmeter">
              <option value="전체">전체</option>
              <option value="30평이하">30평이하</option>
              <option value="30평~60평">30평~60평</option>
              <option value="60평이상">60평이상</option>
            </select>
           
            <div class="align-self-center mx-3">
              지역
            </div>
            
             <select class="form-control form-control-lg align-self-center" style="width: 100px" name="intbarea" id="intbarea">
              <option value="전체">전체</option>
              <option value="서울">서울</option>
              <option value="경기">경기</option>
              <option value="충천">충천</option>
              <option value="강원">강원</option>
              <option value="전라">전라</option>
              <option value="경상">경상</option>
              <option value="제주">제주</option>
            </select>
        </div><!--메뉴 영역 끝-->




		<form:label class="col-form-label col-sm-12 col-md-2 px-0" path="intbcontent"></form:label>
		<form:textarea class="form-control col-md-15" path="intbcontent" rows="10" placeholder="내용을 입력하세요"/>

		<div class="col-md-2"></div>
		<span id="err_2" class="errmsg"></span>
		<form:errors class="errmsg" path="intbcontent" ></form:errors>	
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
<jsp:include page="../footer.jsp"/>