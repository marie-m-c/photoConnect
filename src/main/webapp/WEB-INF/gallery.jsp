<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%> <%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
				<!-- Display error if present -->
				<c:if test="${not empty error}">
    				<div class="alert alert-danger cursor-pointer" onclick="window.location.href='${pageContext.request.contextPath}/gallery'">
        				${error}
    				</div>
				</c:if>
				
				<div class="border">
					<form action="/media/uploadFile/${userId}" method="post" enctype="multipart/form-data" class="form d-flex flex-columns align-items-center justify-content-between form-upload">
						<div class="me-4">
  							<label for="mediaFile" class="form-label text-primary ms-4">Media <i class="fas fa-image"></i> <i class="fas fa-video"></i></label>
  							<input class="form-control-sm d-none" type="file" id="mediaFile" name="file" required>
						</div>
						<div class="form-floating">
  							<label for="media-caption" style="color: rgb(13,110,253,0.5);">caption </label>
  							<textarea class="form-control-sm" id="media-caption" name="caption" placeholder="caption" row="3"> </textarea>
						</div>
						<button type="submit" class="btn btn-primary"> Upload </button>
					</form>
				</div>
			</div>
			</section>
			</c:if>
			
			
			<section>
				<div class="container mt-4">
    				<h1 class="text-start text-primary mb-4">Gallery</h1>
    				<div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
        				<c:forEach var="media" items="${mediaList}">
            				<div class="col">
                				<div class="card position-relative mb-4" style="height: 300px; min-width: 200px;" >
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
                        			<c:if test="${media.getUser().getId() == userId }">
 									<form action="/medias/gallery/${media.getId()}/delete" method="post">
 										<input type="hidden" name="_method" value="delete" />
 										<label for="delete-media-${media.getId()}" class="position-absolute delete-cross"><i class="fas fa-times delete-cross-icon"></i></label>
 										<input type="submit" class="d-none" value="delete" id="delete-media-${media.getId()}" />
 									</form>
 								</c:if>
                    				<div class="card-body">
                    					<c:choose>
                    						<c:when test="${loggedIn}">
                        						<p class="position-absolute" style="bottom: -55px; left: 5px;">
                        							<a href="/profile/${media.user.id }" class="text-primary text-decoration-none">${media.user.getAlias()} : </a>${fn:substring(media.caption, 0, 3)}..
                        						</p>
                        						<p class="position-absolute" style="bottom: -55px; right: 5px;">
                        							<i class="fas fa-thumbs-up like-icon ${media.likedByUser(currentUser) ? 'text-primary' : ''}" data-media-id="${media.id}"></i>&nbsp;&nbsp;
                            						<span class="text-primary" style="cursor: pointer;" onclick="window.location.href='/medias/${media.id}'">
                            							<span class="like-count">${media.getLikes().size()}</span> like(s)
                            						</span>
                        						</p>
                        					</c:when>
                        					<c:otherwise>
                        						<p class="position-absolute" style="bottom: -55px; left: 5px;">
                        							<a href="/login" class="text-primary text-decoration-none">${media.user.getAlias()} : </a>${fn:substring(media.caption, 0, 3)}..
                        						</p>
                        						<p class="position-absolute" style="bottom: -55px; right: 5px;">
                            						<span class="text-primary" style="cursor: pointer;" onclick="window.location.href='/login'">
                            						<span class="like-count">${media.getLikes().size()}</span> like(s)
                            						</span>
                        						</p>
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
	<script>
    document.addEventListener('DOMContentLoaded', function() {

        document.querySelectorAll('.like-icon').forEach(icon => {
            icon.addEventListener('click', function() {

                const mediaId = icon.getAttribute('data-media-id');
                if (!mediaId) {
                    console.error("mediaId is missing for the clicked element.");
                    return;
                }
                

                const isLiked = icon.classList.contains('text-primary');
				apiUrl = "/api/likes/" + mediaId + "/toggle"

                fetch(apiUrl, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Network response was not ok");
                    }
                    return response.json();
                })
                .then(data => {
                        console.log(data)
                        icon.classList.toggle('text-primary', !isLiked);

                        const likeCountSpan = icon.nextElementSibling;
                        likeCountSpan.textContent = data + "  like(s)";
                })
                .catch(error => console.error("Error during fetch:", error));
            });
        });
    });
</script>	
</body>
</html>