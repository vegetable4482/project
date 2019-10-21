<%-- sidebar section --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>    
	<div class="container-fluid">
	  <div class="row">
	    <nav class="col-md-2 d-none d-md-block bg-light sidebar">
	      <div class="sidebar-sticky">
	        <ul class="nav flex-column">
	        <c:choose>
	        	<c:when test="${empty sessionScope.administrator }">
		          <li class="nav-item">
		            <a class="nav-link text-center" id="managerMenu1" href="javascript:alert('접근 권한이 없습니다.')" title="견적서 관리">
		            	Estimate 
		            </a>
		          </li>
		          <li class="nav-item">
		            <a class="nav-link text-center" id="managerMenu2" href="javascript:alert('접근 권한이 없습니다.')" title="개인 회원 관리">
		            	Member
		            </a>
		          </li>
		          <li class="nav-item">
		            <a class="nav-link text-center" id="managerMenu3" href="javascript:alert('접근 권한이 없습니다.')" title="기업 회원 관리">
		              Company
		            </a>
		          </li>
	          </c:when>
	          <c:otherwise>
		          <li class="nav-item">
		            <a class="nav-link text-center" id="managerMenu1" href="${pageContext.request.contextPath }/request/estimateList">
		            	Estimate 
		            </a>
		          </li>
		          <li class="nav-item">
		            <a class="nav-link text-center" id="managerMenu2" href="${pageContext.request.contextPath }/member/memberList">
		            	Member
		            </a>
		          </li>
		          <li class="nav-item">
		            <a class="nav-link text-center" id="managerMenu3" href="${pageContext.request.contextPath }/company/companyList">
		              Company
		            </a>
		          </li>
	          </c:otherwise>
	        </c:choose>
	        </ul>
	      </div>
	    </nav>
	  </div>
	</div>
</div>
