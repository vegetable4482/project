<%-- nav section --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<nav class="navbar navbar-dark bg-dark border-dark fixed-top p-0">
	  <a class="navbar-brand bg-dark border-dark text-center col-sm-3 col-md-2" href="${pageContext.request.contextPath }/administrator/adminMain">Zipzoong [HOME]</a>
	  <!-- <input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search"> -->
	  <ul class="navbar-nav">
	    <c:choose>
	      <c:when test="${empty sessionScope.administrator }">
		      <a class="btn btn-md btn-outline-light border-dark mr-3" id="adminLogin" href="${pageContext.request.contextPath }/administrator/administratorLogin">LOGIN-[ADMIN]</a>
		      <%-- <a class="btn btn-sm btn-outline-secondary" id="adminJoin" href="#">JOIN US</a> --%>
	    	</c:when>
	    	<c:otherwise>
		    <div class="d-flex">
					<div class="text-white align-self-center">[현재 관리자 : ${sessionScope.administrator.AName }]</div>
		      <a class="btn btn-md btn-outline-light border-dark mr-3" id="adminLogout" href="${pageContext.request.contextPath }/administrator/logoutAccess">LOGOUT</a>
			  </div>
	    	</c:otherwise>
	    </c:choose>
	  </ul>
	</nav>
</div>
