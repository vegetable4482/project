<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.kh.myapp.intbbs.dto.IntDTO"%>
<jsp:include page="../header.jsp" />
<style>
.btn {
	
}

.page-link {
	position: relative;
	display: block;
	padding: 0.5rem 0.75rem;
	margin-left: -1px;
	line-height: 1.25;
	color: #000;
	background-color: #fff;
	/* border: 1px solid #dee2e6; */
	border: none;
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
	background-color: #FFC107;
	border-color: #FFC107;
}

.page-item.disabled .page-link {
	color: #6c757d;
	pointer-events: none;
	cursor: auto;
	background-color: #fff;
	border-color: #dee2e6;
}
</style>
<script>
	$(function() {

		//검색어 엔터키
		$("#searchBtn2").on("click", function(e) {
		
			let $reqPage = "${pc.rc.reqPage}";
			let $searchType2 = $("#searchType2 option:selected").val();
			let $searchType3 = $("#searchType3 option:selected").val();
			let $searchType4 = $("#searchType4 option:selected").val();
			let $addsearch = $searchType2 + $searchType3 + $searchType4;
			let $url = "${pageContext.request.contextPath }/intbbs/intlist/";
			$url += $reqPage + "/" + $addsearch;
			console.log($addsearch);
 			document.location.href = $url; 
		});
	});
</script>
<hr>
<div class="row justify-content-center my-5 py-3 " style="background:rgb(244,244,244); font-family: 'NanumSquare', sans-serif; font-weight:bold;">
				<p class="h4 py-3" >종합 인테리어</p>
			</div>
<div class="container">
	<!-- 게시글목록 Grid -->
	<div class="row justify-content-center">
		<div class="col col-10">

			<div class="row justify-content-center">
				<form>
					<div class="form-group row">

						<div class="align-self-center col-1 p-0">공간</div>

						<select id="searchType2" name="searchType2"
							class="form-control form-control-lg col-2 m-0 p-0" style="font-size:14px;">
							<option value="A">
								<c:out value="${pc.searchType2 == 'A' ? 'selected' : ''}" /> 
								전체
							</option>

							<option value="B">
								<c:out value="${pc.searchType2 == 'B' ? 'selected' : ''}" />
								아파트
							</option>

							<option value="C">
								<c:out value="${pc.searchType2 == 'C' ? 'selected' : ''}" /> 
								빌라
							</option>

							<option value="D">
								<c:out value="${pc.searchType2 == 'D' ? 'selected' : ''}" /> 
								주택
							</option>
						</select>

						<div class="align-self-center col-1 mx-2" style="padding:0">스타일</div>

						<select id="searchType3" name="searchType3"
							class="form-control form-control-lg align-self-center col-3 m-0 p-0"  style="width: 210px; font-size:14px;">
							<option value="A">
								<c:out value="${pc.searchType3 == 'A' ? 'selected' : ''}" /> 
								전체
							</option>

							<option value="B">
								<c:out value="${pc.searchType3 == 'B' ? 'selected' : ''}" /> 
								모던
							</option>

							<option value="C">
								<c:out value="${pc.searchType3 == 'C' ? 'selected' : ''}" />
								클래식
							</option>

							<option value="D">
								<c:out value="${pc.searchType3 == 'D' ? 'selected' : ''}" />
								빈티지
							</option>

							<option value="E">
								<c:out value="${pc.searchType3 == 'E' ? 'selected' : ''}" />
								인더스트리얼
							</option>
							
							<option value="F">
								<c:out value="${pc.searchType3 == 'E' ? 'selected' : ''}" />
								미니멀리즘
							</option>
						</select>

						<div class="align-self-center col-1 p-0">&nbsp; 평수</div>

						<select id="searchType4" name="searchType4"
							class="form-control form-control-lg align-self-center col-2 m-0 p-0"  style="font-size:14px;"> 
							<option value="A">
								<c:out value="${pc.searchType4 == 'A' ? 'selected' : ''}" /> 전체
							</option>

							<option value="B">
								<c:out value="${pc.searchType4 == 'B' ? 'selected' : ''}" />
								30평이하
							</option>

							<option value="C">
								<c:out value="${pc.searchType4 == 'C' ? 'selected' : ''}" />
								30평~60평
							</option>

							<option value="D">
								<c:out value="${pc.searchType4 == 'D' ? 'selected' : ''}" />
								60평이상
							</option>
						</select>
						
						<button type="button" class="btn" style="background-color:#FF8800; color:white; margin-left:10px;" id="searchBtn2">
							검색
						</button>
					</div>
				</form>
			</div>
			<hr>
			<!--메뉴 영역 끝-->
			<div class="row justify-content-center">
				<c:forEach var="rec" items="${list }">
					<div class="row">
						<div class=" col-4 my-3 mx-3">
							<a href="${pageContext.request.contextPath }/intbbs/intread/${pc.rc.reqPage}/${rec.intbnum}"> <img
								src="${pageContext.request.contextPath }/resources/img/upload/${rec.randomFn}"
								width="250px" height="200px">
							</a>
							<div class="border border2" style="width: 250px">
								<div class="my-3 mx-3">
									<div class="row">
										<div class="col col-sm-12 col-md-12 text-center">
											<c:forEach begin="1" end="${rec.intbindent }">&nbsp;&nbsp;</c:forEach>
											<c:if test="${rec.intbindent > 0 }">
												<img
													src="${pageContext.request.contextPath }/resources/img/icon_reply.gif" />
											</c:if>
											<a class="text-secondary"
												href="${pageContext.request.contextPath }/intbbs/intread/${pc.rc.reqPage}/${rec.intbnum}" style="font-size:1.2rem;">${rec.intbtitle }
											</a>
										</div>
									</div>
									<div class="row my-2 justify-content-center">
										<span class="mx-2 " style="font-size: 1em; color:#ccc;">${rec.intbtype}
											<span class="mx-2">|</span>
										</span> <span class="" style="font-size: 1em; color:#ccc; ">${rec.intbstyle}
											<span class="mx-2">|</span>
										</span> <span class="" style="font-size: 1em;  color:#ccc;">${rec.intblandmeter}
										</span>
										<div class="row justify-content-center" style="font-size: 1.7em;">
											<p class="" style="color:#FF8800; font-weight:bold;">${rec.intbname }</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="row">
					<c:choose> 
						<c:when test="${empty sessionScope.user2}">
						</c:when>
						<c:otherwise>
						<div class="row">
						 <div class="col" style="margin-left:800px;">
							<button type=button class="btn " style=" background-color:#FF8800; color:white; font-size:14px;" id="writeBtn" onclick="location.href='${pageContext.request.contextPath }/intbbs/intwriteForm'">
								글쓰기 
							</button>
						</div>
						</div>
						</c:otherwise>
					</c:choose>
				</div>
			<!-- 페이징 Pagination-->
			<div class="row justify-content-center my-2">
				<nav aria-label="...">
					<ul class="pagination pagination-sm">
						<!-- 처음  / 이전 페이지이동 -->
						<c:choose>
							<c:when test="${pc.prev }">
								<li class="page-item "><a class="page-link"
									href="${pageContext.request.contextPath }/intbbs/intlist/1"
									tabindex="-1" aria-disabled="true"><<</a></li>

								<li class="page-item "><a class="page-link"
									href="${pageContext.request.contextPath }/intbbs/intlist/${pc.startPage-1}"
									tabindex="-1" aria-disabled="true"><</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link"
									href="#" tabindex="-1" aria-disabled="true"><<</a></li>

								<li class="page-item disabled"><a class="page-link"
									href="#" tabindex="-1" aria-disabled="true"><</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="pageNum" begin="${pc.startPage }"
							end="${pc.endPage }">
							<!-- 현재페이지와 요청페이지가 다르면 -->
							<c:if test="${pc.rc.reqPage != pageNum }">
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath }/intbbs/intlist/${pageNum}/${pc.searchType}/${pc.keyword}">${pageNum }</a></li>
							</c:if>
							<!-- 현재페이지와 요청페이지가 같으면 -->
							<c:if test="${pc.rc.reqPage == pageNum }">
								<li class="page-item active" aria-current="page"><a style="background-color:#FF8800"
									class="page-link"
									href="${pageContext.request.contextPath }/intbbs/intlist/${pageNum}/${pc.searchType}/${pc.keyword}">${pageNum }
										<span class="sr-only">(current)</span>
								</a></li>
							</c:if>
						</c:forEach>

						<!-- 다음  / 끝 페이지이동 -->
						<c:choose>
							<c:when test="${pc.next }">
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath }/intbbs/intlist/${pc.endPage+1}">></a>
								</li>
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath }/intbbs/intlist/${pc.finalEndPage}">>></a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link"
									href="#">></a></li>
								<li class="page-item disabled"><a class="page-link"
									href="#">>></a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../footer.jsp" />

















