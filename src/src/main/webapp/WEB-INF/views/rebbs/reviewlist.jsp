<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<jsp:include page="../header.jsp"/>
<style>
.page-link {
  position: relative;
  display: block;
  padding: 0.5rem 0.75rem;
  margin-left: -1px;
  line-height: 1.25;
  color: #000;
  background-color: #fff;
  /* border: 1px solid #dee2e6; */
  border:none;
}

.page-link:hover {
  z-index: 2;
  color: #0056b3;
  text-decoration: none;
  background-color: #e9ecef;
  border-color: #dee2e6;
}

.page-link:focus {
  z-index: 2;
  outline: 0;
  box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

.page-item:first-child .page-link {
  margin-left: 0;
  border-top-left-radius: 0.25rem;
  border-bottom-left-radius: 0.25rem;
}

.page-item:last-child .page-link {
  border-top-right-radius: 0.25rem;
  border-bottom-right-radius: 0.25rem;
}

.page-item.active .page-link {
  z-index: 1;
  color: #fff;
  background-color: #007bff;
  border-color: #007bff;
}

.page-item.disabled .page-link {
  color: #6c757d;
  pointer-events: none;
  cursor: auto;
  background-color: #fff;
  border-color: #dee2e6;
}
#star{
	color:#FF8800;
	font-size: 20px;
}
#writeBtn  {
	background: orange;
}	
.reviewTile{
 color:black;
 font-size: 20px;
   font-family: 'NanumSquare', sans-serif;
}
</style>
<script>
	$(function() {		
		//검색버튼 클릭시
		$("#searchBtn").on("click" ,function(e){
			e.preventDefault();
/* 			search(); */
			//검색어 입력값이 없으면
			if($("#keyword").val().trim().length == 0){
				alert('검색어를 입력하세요!');
				$("#keyword").focus();
				return false;
			}
			let $reqPage = ${pc.rc.reqPage};
			let $searchType = $("#key1 option:selected").val();
			let $keyword = $("#keyword").val().trim();
			let $url  = "${pageContext.request.contextPath }/rebbs/list/";
					$url += $reqPage+"/"+$searchType+"/"+$keyword;	
			document.location.href = $url;
		});
		
		//검색어 엔터키
		$("#keyword").on("keydown keyup keypress",function(e){
			//검색어 입력값이 없으면
			if(e.keyCode == 13) {
				e.preventDefault();
				if($(this).val().trim().length == 0){
					alert('검색어를 입력하세요!');
					$(this).focus();
					return false;
				}
				let $reqPage = ${pc.rc.reqPage};
				let $searchType = $("#key1 option:selected").val();
				let $keyword = $("#keyword").val().trim();
				let $url  = "${pageContext.request.contextPath }/rebbs/list/";
						$url += $reqPage+"/"+$searchType+"/"+$keyword;		
				document.location.href = $url;
			}
		});
		
		//글쓰기 버튼 클릭시
		$("#writeBtn").on("click",function(){
			var user = "${sessionScope.user == null ? null : sessionScope.user.id}";
			//로그인전이면 로그인화면으로 이동
			if(user == null || user == "") {
				document.location.href="${pageContext.request.contextPath }/login/login";
				return;
			}
			//로그인후면 글쓰기화면으로 이동
			document.location.href="${pageContext.request.contextPath }/rebbs/write";		
		});
	});

</script>
<hr>
<div class="row justify-content-center my-5 py-3 " style="background:rgb(244,244,244); font-family: 'NanumSquare', sans-serif; font-weight:bold;">
				<p class="h4 py-3" >생생리뷰</p>
			</div>
<div class="container">
	<!-- 게시글목록 Grid -->
	<div class="row justify-content-center">
		<div class="col">
		
			
			<div class="list alert row justify-content-center">
				<c:forEach var="rec" items="${list }">
					<div class="card row col-2.7 my-1 mx-1"  style="width: 12rem;">
						<a href="${pageContext.request.contextPath }/rebbs/read/${pc.rc.reqPage}/${rec.reviewbnum}"><img src="${pageContext.request.contextPath }/resources/img/reupload/${rec.reviewrandomFn}"
							class="card-img-top" alt="..." width="200" height="200">
						</a>
						<div class="card-title">
							<a href="${pageContext.request.contextPath }/rebbs/read/${pc.rc.reqPage}/${rec.reviewbnum}" class="reviewTile">${rec.reviewbtitle }</a>
							<span class="" style="float:right; height:25;" id="star">♥ ${rec.reviewbscore }</span>
							<p class="card-text">
							<span class="card-name" style="color:#ccc">${rec.reviewbid }</span><span style="float:right"><img alt=""
						src="${pageContext.request.contextPath }/resources/img/hit.png"
						height="20" width="20">&nbsp; ${rec.reviewbhit }</span>
							</p>
						</div>
					</div>
				</c:forEach>
				</div>
				
			<!-- 글쓰기 버튼 -->
			<div class="row justify-content-end my-2  mr-3"  style="padding-right:50px;">
				
				<button type=button class="btn btn-sm" id="writeBtn" style=" background:#FF8800; "><img alt=""
						src="${pageContext.request.contextPath }/resources/img/p.png"
						height="20" width="20"><span style="color: white; border:none;">&nbsp;글쓰기</span></button>
			</div>
			<!-- 페이징 Pagination-->
			<div class="row justify-content-center my-2">
				<nav aria-label="...">
				  <ul class="pagination pagination-sm">
				  	<!-- 처음  / 이전 페이지이동 -->
						<c:choose>
							<c:when test="${pc.prev }">	  
						    <li class="page-item ">
						      <a class="page-link" href="${pageContext.request.contextPath }/rebbs/list/1" tabindex="-1" aria-disabled="true"><<</a>
						    </li>
		
						    <li class="page-item ">
						      <a class="page-link" href="${pageContext.request.contextPath }/rebbs/list/${pc.startPage-1}" tabindex="-1" aria-disabled="true"><</a>
						    </li>
				    	</c:when>
				    	<c:otherwise>
						    <li class="page-item disabled">
						      <a class="page-link" href="#" tabindex="-1" aria-disabled="true"><<</a>
						    </li>
		
						    <li class="page-item disabled">
						      <a class="page-link" href="#" tabindex="-1" aria-disabled="true"><</a>
						    </li>				    					    	
				    	</c:otherwise>
				    </c:choose>
				    
				    <c:forEach var="pageNum" begin="${pc.startPage }" end="${pc.endPage }">
				    <!-- 현재페이지와 요청페이지가 다르면 -->
				    <c:if test="${pc.rc.reqPage != pageNum }">
				    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/rebbs/list/${pageNum}/${pc.searchType}/${pc.keyword}">${pageNum }</a></li>
				    </c:if>
				    <!-- 현재페이지와 요청페이지가 같으면 -->
				    <c:if test="${pc.rc.reqPage == pageNum }">
				    <li class="page-item active" aria-current="page">
				      <a class="page-link" href="${pageContext.request.contextPath }/rebbs/list/${pageNum}/${pc.searchType}/${pc.keyword}" style="background-color:#FF8800; border:none;">${pageNum } <span class="sr-only">(current)</span></a>
				    </li>
				    </c:if>
				    </c:forEach>
				    
				  	<!-- 다음  / 끝 페이지이동 -->				    
						<c:choose>
							<c:when test="${pc.next }">	 
						    <li class="page-item">
						      <a class="page-link" href="${pageContext.request.contextPath }/rebbs/list/${pc.endPage+1}">></a>
						    </li>		
						    <li class="page-item">
						      <a class="page-link" href="${pageContext.request.contextPath }/rebbs/list/${pc.finalEndPage}">>></a>
						    </li>
						  </c:when>
						  <c:otherwise>
						    <li class="page-item disabled">
						      <a class="page-link" href="#">></a>
						    </li>		
						    <li class="page-item disabled">
						      <a class="page-link" href="#">>></a>
						    </li>						  
						  </c:otherwise>
						</c:choose>
				  </ul>
				</nav>		
			</div>
			<!-- 검색 select-->	
			<div class="row justify-content-center">
				<form>
				<div class="form-group row">
					<div class="col col-sm-4 px-0">
					<select id="key1" name="searchType" class="form-control form-control-sm">
						<option value="TC"
							<c:out value="${pc.searchType == 'TC' ? 'selected' : ''}"/>>제목+내용</option>
						<option value="T"
							<c:out value="${pc.searchType == 'T' ? 'selected' : ''}"/>>제목</option>
						<option value="C"
							<c:out value="${pc.searchType == 'C' ? 'selected' : ''}"/>>내용</option>
						<option value="N"
							<c:out value="${pc.searchType == 'N' ? 'selected' : ''}"/>>작성자</option>
						<option value="I"
							<c:out value="${pc.searchType == 'I' ? 'selected' : ''}"/>>아이디</option>
					</select>
					</div>
					<div class="col col-sm-6 px-1">
					<input type="text" name="keyword" id="keyword" class="form-control form-control-sm"
								 value="${pc.keyword }" placeholder="검색어를 입력하세요!"/>
					</div>
					<div class="col col-sm-2 px-0">							 
					<button class="btn btn-sm btn-outline-secondary align-baseline" type="button" id="searchBtn">검색</button>
					</div>
					</div>
				</form>
			</div>
		
	</div>
</div></div>

<jsp:include page="../footer.jsp"/>