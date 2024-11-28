package com.codingdojo.photoconnect.services;

import java.util.List;

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
        return mediaRepository.findAll(); // Fetch all media from the database
    }
}
