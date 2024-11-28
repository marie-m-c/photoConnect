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
    <link rel="stylesheet" href="fonts/fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="mx-auto join-wrap-container">
		<div class="position-relative">
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
                                            		<li class="nav-item">
                                                	<a class="nav-link nav-link-text" href="/profile/${userId}">Profile</a>
                                            		</li>
                                            		<li class="nav-item">
                                                	<a class="nav-link nav-link-text" href="/logout">Logout</a>
                                            		</li>
                                            	</c:when>
                                            	<c:otherwise>
                                            		<li class="nav-item active">
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
		<div class="join-container join-img d-flex justify-content-center align-items-end pb-4">
			<div class="form-wrapper">
				<form:form action="/signup" method="post" modelAttribute="newUser" class="d-flex flex-column">
					<h2>Register</h2>
					<div class="input-field">
    					<form:input class="form-control-sm" path="userName"/>
        				<form:label path="userName">Enter your Name</form:label>
    				</div>
    				<form:errors class="form-error" path="userName"/>
    				<div class="input-field">
    					<form:input class="form-control-sm" path="alias"/>
        				<form:label path="alias">Enter your Alias</form:label>
    				</div>
    				<form:errors class="form-error" path="alias"/>
    				<div class="input-field">
    					<form:input class="form-control-sm" path="email"/>
        				<form:label path="email">Enter your email</form:label>
    				</div>
    				<form:errors class="form-error" path="email"/>
    				<div class="input-field">
    					<form:input type="password" class="form-control-sm" path="password"/>
        				<form:label path="password">Enter your password </form:label>
    				</div>
    				<form:errors class="form-error" path="password"/>
    				<div class="input-field">
    					<form:input type="password" class="form-control-sm" path="confirm"/>
        				<form:label path="confirm">Confirm your password </form:label>
    				</div>
    				<form:errors class="form-error" path="confirm"/>
    				<button type="submit">Register</button>
				</form:form>
			</div>
		</div>
	</div>
	
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>