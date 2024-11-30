package com.codingdojo.photoconnect.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.codingdojo.photoconnect.models.Media;
import com.codingdojo.photoconnect.models.User;
import com.codingdojo.photoconnect.services.MediaService;
import com.codingdojo.photoconnect.services.UserService;

@RestController
@RequestMapping("/api/likes")
public class LikeController {

    @Autowired
    private MediaService mediaService;

    @Autowired
    private UserService userService;

    @PostMapping("/{mediaId}/toggle")
    public ResponseEntity<Integer> toggleLike(@PathVariable Long mediaId, @SessionAttribute("userId") Long currentUserId) {
    	System.out.print("**** userId****** " + currentUserId + "*******mediaId****" + mediaId);
        Media media = mediaService.findMedia(mediaId);
        User user = userService.findUser(currentUserId);
        

        mediaService.toggleLike(media, user);
        int likesCount = media.getLikes().size();
        System.out.print("****likes ****** " + likesCount);
        return ResponseEntity.ok(likesCount);
    }
    
    @GetMapping("/user/{userId}/count")
    public ResponseEntity<Long> getLikesCountForUserUploadedMedia(@PathVariable Long userId) {
        Long totalLikes = mediaService.getTotalLikesForUserUploadedMedia(userId);
        return ResponseEntity.ok(totalLikes);
    }
}
