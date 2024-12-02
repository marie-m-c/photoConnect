<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%> <%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PhotoConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/fontawesome/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="mx-auto">
		<div class="position-relative gallery-header-container header-img">
			<div class="potition-absolute site-header">
				<div class="container-fluid position-relative">
					<div class="row">						
                        <div class="col-7 col-md-4">
                            <div class="text-light text-center logo-container">
                                <h1 class="logo">PhotoConnect</h1>
                            </div>
                        </div>
                        <div class="col-5 col-md-8 ml-auto mr-0">
                            <div>
                                <nav class="navbar navbar-expand-lg mr-0 ml-auto" id="main-nav">
                                    <button class="navbar-toggler bg-black py-2 px-3 mr-0 ml-auto collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#navbar-nav">
                                        <span>
                                            <i class="fas fa-bars menu-closed-icon"></i>
                                            <i class="fas fa-times menu-opened-icon"></i>
                                        </span>
                                    </button>
                                    <div class="collapse navbar-collapse" id="navbar-nav">
                                        <ul class="navbar-nav text-uppercase">
                                            <li class="nav-item">
                                                <a class="nav-link nav-link-text" href="/">Home</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link nav-link-text" href="/gallery">Gallery</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link nav-link-text" href="/about">About</a>
                                            </li>
                                            <c:choose>
                                            	<c:when test="${loggedIn}">
                                            		<li class="nav-item active">
                                                	<a class="nav-link nav-link-text" href="/profile/${userId}">Profile</a>
                                            		</li>
                                            		<li class="nav-item">
                                                	<a class="nav-link nav-link-text" href="/logout">Logout</a>
                                            		</li>
                                            	</c:when>
                                            	<c:otherwise>
                                            		<li class="nav-item">
                                                	<a class="nav-link nav-link-text text-nowrap" href="/login">Join Now</a>
                                            		</li>
                                            	</c:otherwise>
                                            </c:choose>
                                        </ul>
                                    </div>
                                </nav>
                            </div>
                        </div>
					</div>
				</div>
			</div>
		</div>
		<!-- Page Content -->
		
		<main class="m-4 p-4">
		<h3 class="text-primary my-4">Edit Profile Data</h3>
		<form:form action="/profileData/update/${profileData.getId()}" method="post" modelAttribute="profileData" class="form border py-4 px-4 w-100">
    	 <input type="hidden" name="_method" value="put" />
    	 
    	 <form:errors class="ms-2 text-sm text-danger" path="bio"/>
    	<div class="d-flex align-items-center p-1 m-1">
        	<form:label class="w-50" path="bio">Bio</form:label>
        	<form:textarea class="form-control" path="bio"/>
    	</div>
    	 
    	<form:errors class="ms-2 text-sm text-danger" path="linkedinLink"/>
    	<div class="d-flex align-items-center p-1 m-1">
        	<form:label class="w-50" path="linkedinLink">LinkedIn</form:label>
        	<form:input class="form-control" path="linkedinLink"/>
    	</div>
    	
    	<form:errors class="ms-2 text-sm text-danger" path="instagramLink"/>
    	<div class="d-flex align-items-center p-1 m-1">
        	<form:label class="w-50" path="instagramLink">Instagram</form:label>
        	<form:input class="form-control" path="instagramLink"/>
    	</div>
    	
    	<br/><input class="btn btn-primary text-light m-1" type="submit" value="Submit"/>
	</form:form>
		</main>
	</div>
	
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>