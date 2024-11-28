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
                                            <li class="nav-item active">
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
			<c:if test="${loggedIn}">
			<section>
			<div class="container mt-4">
				<h1 class="text-start text-primary mb-4">Upload New Media</h1>
				<div class="border">
					<form action="/media/uploadFile/${userId}" method="post" enctype="multipart/form-data" class="form d-flex align-items-center justify-content-between">
						<div class="me-4">
  							<label for="mediaFile" class="form-label text-primary ms-4">Media <i class="fas fa-image"></i> <i class="fas fa-video"></i></label>
  							<input class="form-control-sm d-none" type="file" id="mediaFile" name="file" required>
						</div>
						<div class="me-4">
  							<label for="media-caption" class="form-label text-primary">caption </label>
  							<input class="form-control-sm" id="media-caption" name="caption" required>
						</div>
						<input type="submit" class="btn btn-primary btn-sm" value="Upload">
					</form>
				</div>
			</div>
			</section>
			</c:if>
			
			
			<section>
				<div class="container mt-4">
    				<h1 class="text-start text-primary mb-4">Gallery</h1>
    				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
        				<c:forEach var="media" items="${mediaList}">
            				<div class="col">
                				<div class="card position-relative mb-4" style="height: 300px;" >
                				<div class="h-100">
                    				<c:choose>
                    					<c:when test="${media.mediaType == 'PHOTO'}">
                        					<img src="${pageContext.request.contextPath}/uploads/${media.media}" class="card-img-top h-100" style="overflow: hidden; object-fit: cover;" alt="${media.caption}"/>
                        				</c:when>
                        				<c:otherwise>
                        					<video src="${pageContext.request.contextPath}/uploads/${media.media}" class="card-img-top h-100" style="overflow: hidden; object-fit: cover;" autoplay muted loop></video>
                        				</c:otherwise>
                        			</c:choose>
                        			</div>
                    				<div class="card-body">
                    					<c:choose>
                    						<c:when test="${loggedIn}">
                        						<p class="card-text position-absolute" style="bottom: -35px; left: 5px;"><a href="/profile/${userId }" class="text-primary text-decoration-none">${media.user.getAlias()} : </a>${media.caption}</p>
                        					</c:when>
                        					<c:otherwise>
                        						<p class="card-text position-absolute" style="bottom: -35px; left: 5px;"><a href="/login" class="text-primary text-decoration-none">${media.user.getAlias()} : </a>${media.caption}</p>
                        					</c:otherwise>
                        				</c:choose>
                    				</div>
                				</div>
            				</div>
        				</c:forEach>
    				</div>
				</div>
			</section>
		</main>
	</div>
	
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>