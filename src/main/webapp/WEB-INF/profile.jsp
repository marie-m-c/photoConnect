<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%> <%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
			<section>
			<div class="container d-flex gap-4 mb-4 user-data-container">
				<div class="d-flex align-items-center gap-2">
					<c:if test="${profileUser.id == userId }">
    				<form action="/profile/picture/update/${profileData.id}" method="post" enctype="multipart/form-data" id="profilePictureForm">
                		<input type="hidden" name="_method" value="put">
                		<div class="rounded-circle overflow-hidden position-relative" style="width: 150px; height: 150px; border: 2px solid #ddd;">
                    	<c:choose>
    						<c:when test="${profileData.profilePicture != null}">
        						<img src="${pageContext.request.contextPath}/uploads/${profileData.profilePicture}"
        						alt="Profile Picture" class="w-100 h-100" 
        						onclick="document.getElementById('profilePictureInput').click();">
    						</c:when>
    						<c:otherwise>
        						<img src="${pageContext.request.contextPath}/images/placeholder.png"
        						alt="Profile Picture" class="w-100 h-100"
        						onclick="document.getElementById('profilePictureInput').click();">
    						</c:otherwise>
						</c:choose>
                    		<input 
                        		type="file" 
                        		name="profilePicture" 
                        		id="profilePictureInput" 
                        		class="d-none" 
                        		accept="image/*" 
                        		onchange="document.getElementById('profilePictureForm').submit();"
                    		>
                		</div>
            		</form>
            		</c:if>
            		<c:if test="${profileUser.id != userId }">
            		<div class="rounded-circle overflow-hidden position-relative" style="width: 150px; height: 150px; border: 2px solid #ddd;">
            			<img src="${pageContext.request.contextPath}/uploads/${profileData.profilePicture}"
        						alt="Profile Picture" class="w-100 h-100" >
            		</div>
            		</c:if>
        			<h3 class="text-primary align-self-end" style="margin-left: -20px;">
        				<c:out value="${profileUser.userName}" />
        			</h3>
				</div>
				<div style="line-height: 1rem;" class="align-self-end">
					<p>Alias <c:out value="${profileUser.alias}" /></p>
					<p><i class="fas fa-envelope"></i>  <c:out value="${profileUser.email}" /></p>
					<c:if test="${profileData.getLinkedinLink() != null}">
						<p><i class="fab fa-linkedin"></i> <c:out value="${profileData.linkedinLink}" /></p>
					</c:if>
					<c:if test="${profileData.getInstagramLink() != null}">
						<p><i class="fab fa-instagram"></i> <c:out value="${profileData.instagramLink}" /></p>
					</c:if>
				</div>
			</div>
			<c:if test="${profileData.getBio() != null}">
				<p class="ms-4 ps-4"><c:out value="${profileData.bio}" /></p>
			</c:if>
			<c:if test="${profileUser.getId() == userId }">
 							<form action="/profileData/${profileData.getId()}/edit" method="post">
 								<label for="update" class="text-primary text-decoration-underline ms-4 ps-4">edit profile data</label>
 								<input type="submit" class="d-none" value="edit" id="update" />
 							</form>
 					</c:if>
			</section>
			
			<hr/>
			<section>
				<div class="container mt-4">
					<h4 class="text-start text-primary mb-4">Album(<c:out value="${fn:length(mediaList)}" />) Likes(<span><c:out value="${likes}" /></span>)</h4>
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
 									<form action="/medias/profile/${media.getId()}/delete" method="post">
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