<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

#line2 {
	border-bottom: 1px solid #ccc;
}

#line2:hover {
	background-color: rgba(0, 0, 0, 0.075);
}
</style>
<script>
	$(function() {
		//검색버튼 클릭시
		$("#searchBtn").on("click", function(e) {
			e.preventDefault();
			/* 			search(); */
			//검색어 입력값이 없으면
			if ($("#keyword").val().trim().length == 0) {
				alert('검색어를 입력하세요!');
				$("#keyword").focus();
				return false;
			}
			let $reqPage = $
			{
				pc.rc.reqPage
			}
			;
			let $searchType = $("#key1 option:selected").val();
			let $keyword = $("#keyword").val().trim();
			let $url = "${pageContext.request.contextPath }/fbbs/list/";
			$url += $reqPage + "/" + $searchType + "/" + $keyword;
			document.location.href = $url;
		});

		//검색어 엔터키
		$("#keyword").on("keydown keyup keypress", function(e) {
			//검색어 입력값이 없으면
			if (e.keyCode == 13) {
				e.preventDefault();
				if ($(this).val().trim().length == 0) {
					alert('검색어를 입력하세요!');
					$(this).focus();
					return false;
				}
				let $reqPage = $
				{
					pc.rc.reqPage
				}
				;
				let $searchType = $("#key1 option:selected").val();
				let $keyword = $("#keyword").val().trim();
				let $url = "${pageContext.request.contextPath }/fbbs/list/";
				$url += $reqPage + "/" + $searchType + "/" + $keyword;
				document.location.href = $url;
			}
		});

		//글쓰기 버튼 클릭시
	    //글쓰기 버튼 클릭시
        $("#writeBtn").on("click",function(){
            var user = "${sessionScope.user == null ? null : sessionScope.user.id}";
            //로그인전이면 로그인화면으로 이동
            if(user == null || user == "") {
                document.location.href="${pageContext.request.contextPath }/login/login";
                return;
            }
            //로그인후면 글쓰기화면으로 이동
            document.location.href="${pageContext.request.contextPath }/fbbs/writeForm";        
        });
    });
</script>
<hr>
<div class="container">
	<!-- 게시글목록 Grid -->
	<div class="row justify-content-center">
		<div class="col col-sm-12 ">

			<div class="row justify-content-left my-3 " style="border-bottom:2px solid #FF8800; font-family: 'NanumSquare', sans-serif; font-weight:bold;">
				<p class="h4" >인테리어 토크</p>
			</div>
			<div class="row py-2 my-1 border border-dark ">
				<div class="col col-sm-2 col-md-1 text-center">번호</div>
				<div class="col col-sm-10 col-md-6 text-center">제목</div>
				<div class="col col-md-2 text-center">작성자</div>
				<div class="col col-md-2 text-center">작성일</div>
				<div class="col col-md-1 text-center">조회</div>
			</div>
			<c:forEach var="rec" items="${list }">
				<div class="row py-2" id="line2">
					<div class="col col-sm-2 col-md-1 text-center">${rec.freebnum }</div>
					<div class="col col-sm-10 col-md-6 text-left">
						<c:forEach begin="1" end="${rec.freebindent }">&nbsp;&nbsp;</c:forEach>
						<c:if test="${rec.freebindent > 0 }">
							<img
								src="${pageContext.request.contextPath }/resources/img/icon_reply.gif" />
						</c:if>
						<a class="text-secondary"
							href="${pageContext.request.contextPath }/fbbs/read/${pc.rc.reqPage}/${rec.freebnum}">${rec.freebtitle }</a>

					</div>
					<div class="col col-md-2 text-center">${rec.freebid }</div>
					<div class="col col-md-2 text-center">${rec.freebcdate }</div>
					<div class="col col-md-1 text-center">${rec.freebhit }</div>
				</div>
			</c:forEach>
			<!-- 글쓰기 버튼 -->

			<div class="row justify-content-end my-2">
				<button type=button class="btn btn-sm btn btn-Warning" id="writeBtn"
					style="background: #FF8800;">
					<img alt=""
						src="${pageContext.request.contextPath }/resources/img/p.png"
						height="20" width="20"><span style="color: white">&nbsp;글쓰기</span>
				</button>
			</div>

			<!-- 페이징 Pagination-->
			<div class="row justify-content-center my-2">
				<nav aria-label="...">
					<ul class="pagination pagination-sm">
						<!-- 처음  / 이전 페이지이동 -->
						<c:choose>
							<c:when test="${pc.prev }">
								<li class="page-item "><a class="page-link"
									href="${pageContext.request.contextPath }/fbbs/list/1"
									tabindex="-1" aria-disabled="true"><<</a></li>

								<li class="page-item "><a class="page-link"
									href="${pageContext.request.contextPath }/fbbs/list/${pc.startPage-1}"
									tabindex="-1" aria-disabled="true">◁</a></li>
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
									href="${pageContext.request.contextPath }/fbbs/list/${pageNum}/${pc.searchType}/${pc.keyword}" >${pageNum }</a></li>
							</c:if>
							<!-- 현재페이지와 요청페이지가 같으면 -->
							<c:if test="${pc.rc.reqPage == pageNum }">
								<li class="page-item active" aria-current="page"><a
									class="page-link"
									href="${pageContext.request.contextPath }/fbbs/list/${pageNum}/${pc.searchType}/${pc.keyword}" style="background-color:#FF8800; border:none;" >${pageNum }
										<span class="sr-only">(current)</span>
								</a></li>
							</c:if>
						</c:forEach>

						<!-- 다음  / 끝 페이지이동 -->
						<c:choose>
							<c:when test="${pc.next }">
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath }/fbbs/list/${pc.endPage+1}">></a>
								</li>
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath }/fbbs/list/${pc.finalEndPage}">>></a>
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
			<!-- 검색 select-->
			<div class="row justify-content-center">
				<form>
					<div class="form-group row">
						<div class="col col-sm-4 px-0">
							<select id="key1" name="searchType"
								class="form-control form-control-sm">
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
							<input type="text" name="keyword" id="keyword"
								class="form-control form-control-sm" value="${pc.keyword }"
								placeholder="검색어를 입력하세요!" />
						</div>
						<div class="col col-sm-2 px-0">
							<button class="btn btn-sm btn-outline-secondary align-baseline"
								type="button" id="searchBtn">검색</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	    <div class="row my-5"></div>
</div>
<jsp:include page="../footer.jsp" />

















