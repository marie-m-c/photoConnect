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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
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
                                            		<li class="nav-item">
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
			<div class="d-flex justify-content-around w-50 mx-auto media-details">
				<div style="width: 300px;" class="ms-4">
                    <c:choose>
                    	<c:when test="${media.mediaType == 'PHOTO'}">
                        		<img src="${pageContext.request.contextPath}/uploads/${media.media}" class="w-100" style="overflow: hidden; object-fit: cover;" alt="${media.caption}"/>
                        </c:when>
                        <c:otherwise>
                        		<video src="${pageContext.request.contextPath}/uploads/${media.media}" class="w-100" style="overflow: hidden; object-fit: cover;" autoplay muted loop></video>
                        </c:otherwise>
                   </c:choose>
                </div>
                <div class="mt-4 ms-4" style="line-height: 1rem; font-size: 1rem;width: 300px;">
                	<p><a href="/profile/${media.user.id}" class="text-decoration-none text-primary"><c:out value="${media.user.alias}"/></a></p>
                	<c:if test="${media.getUser().getId() == userId }">
 							<form action="/medias/update/${media.getId()}" method="post" class="form w-100">
        							<label class="mt-2">Caption</label>
        							<textarea class="form-control mt-2 w-100" name="caption" rows="5">${media.caption }</textarea>
        							<input type="submit" class="text-light bg-secondary py-2 px-4 rounded mt-4" value="Update" />
 							</form>
 							<c:if test="${not empty error}">
    							<div class="alert alert-danger cursor-pointer mt-2" onclick="this.style.display='none'">
        							${error}
    							</div>
							</c:if>
 					</c:if>
                </div>
			</div>			
		</main>
	</div>	
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	   	
</body>
</html>