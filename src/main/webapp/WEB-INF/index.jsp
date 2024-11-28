<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%><%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PhotoConnect</title>
    <link rel="stylesheet" href="fonts/fontawesome/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <!-- https://fonts.google.com/ -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <div class="mx-auto">
        <div class="position-relative">
            <div class="position-absolute site-header">
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
                                        data-bs-toggle="collapse" data-bs-target="#navbar-nav" >
                                        <span>
                                            <i class="fas fa-bars menu-closed-icon"></i>
                                            <i class="fas fa-times menu-opened-icon"></i>
                                        </span>
                                    </button>
                                    <div class="collapse navbar-collapse" id="navbar-nav">
                                        <ul class="navbar-nav text-uppercase">
                                            <li class="nav-item active">
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
            <div class="welcome-container text-center text-white">
                <div class="welcome-container-inner">
                    <p class="welcome-text mb-1 text-white">Showcase your talent, connect with the world.</p>
                    <p class="welcome-text mb-5 text-white">Where photographers and creativity meet.</p>
                    <a href="/gallery" class="btn  btn-cta">
                        <span>Discover</span>
                    </a>
                </div>
            </div>

            <div id="video-container">
                <video autoplay muted loop id="home-video">
                        <source src="videos/ice.mp4" type="video/mp4">
                </video>    
            </div>
        </div>

   </div>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"> </script>
</body>

</html>