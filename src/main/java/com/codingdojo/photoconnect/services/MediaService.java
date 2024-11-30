package com.codingdojo.photoconnect.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.photoconnect.models.Media;
import com.codingdojo.photoconnect.models.User;
import com.codingdojo.photoconnect.models.repositories.MediaRepository;

@Service
public class MediaService {
	
	@Autowired
	MediaRepository mediaRepository;
	
	public void saveMedia(String filePath, String caption, User user, Media.MediaType mediaType) {
        Media media = new Media();
        media.setMedia(filePath);
        media.setCaption(caption);
        media.setUser(user);
        media.setMediaType(mediaType);
        mediaRepository.save(media);
    }
	
	public List<Media> getAllMedia() {
        return mediaRepository.findAllOrderedByLikes(); // Fetch all media from the database
    }
	
	public List<Media> getAllUserMedia(Long userId) {
        return mediaRepository.findUserMediaOrderedByLikes(userId); // Fetch all media from the database
    }
	
	public void deleteMedia(Long id) {
		mediaRepository.deleteById(id);
	}
	
	 // Toggle like status for a media item
    public boolean toggleLike(Media media, User user) {
        if (media.getLikes().contains(user)) {
            media.getLikes().remove(user);
            mediaRepository.save(media);
            return false;
        } else {
            media.getLikes().add(user);
            mediaRepository.save(media);
            return true;
        }
    }

    public Media findMedia(Long id) {
	     Optional<Media> optionalMedia = mediaRepository.findById(id);
	     if(optionalMedia.isPresent()) {
	         return optionalMedia.get();
	     } else {
	         return null;
	     }
	 }
}
