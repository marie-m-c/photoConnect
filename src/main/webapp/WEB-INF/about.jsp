<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%><%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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
		<div class="position-relative about-header-bg">
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
                                            <li class="nav-item active">
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
			<div class="welcome-container about-header  about-header-img">
				  
				  <div class="text-center">
					<p class="pt-5 px-3 welcome-text welcome-text-2 mb-1 mt-lg-0 mt-5 text-white mx-auto">Connecting Photographers<br>Inspiring Creativity<br>Showcase Your Vision, Build Your Network</p>                	
				 </div>                
				
            </div>
		</div>
		
		<!-- Page content -->
		<main>
			<div class="container-fluid px-0">
				<div class="mx-auto content-container">					
					<div class="mx-auto about-text-container px-3">
						<h2 class="page-title mb-4 text-primary">About the PhotoConnect Community</h2>
						<p class="mb-4">PhotoConnect is a vibrant online community designed for photographers to showcase their creativity and connect with enthusiasts and potential clients.</p>
						<p class="mb-4">Our platform provides a space for photographers to share their work through stunning photos and captivating videos, allowing them to build their brand and grow their audience.</p>
						<p class="mb-0">Whether you're here to browse inspiring photography, find a professional for your next project, or share your portfolio with the world, PhotoConnect is your go-to platform.</p>
					</div>	
				</div>
			</div>
		</main>	
	</div>
	<!-- <div class="row mt-3 mb-5 pb-3">
						<div class="col-12"> -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>