package com.codingdojo.photoconnect.models.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.codingdojo.photoconnect.models.Media;

@Repository
public interface MediaRepository extends CrudRepository<Media, Long> {

	List<Media> findAll();
	
	@Query(value = "SELECT m.* FROM medias m " +
            "LEFT JOIN likes l ON m.id = l.media_id " +
            "GROUP BY m.id " +
            "ORDER BY COUNT(l.user_id) DESC", 
    nativeQuery = true)
	List<Media> findAllOrderedByLikes();
	
	@Query(value = "SELECT m.* FROM medias m " +
            "LEFT JOIN likes l ON m.id = l.media_id " +
            "WHERE m.user_id = :userId " +
            "GROUP BY m.id " +
            "ORDER BY COUNT(l.user_id) DESC", 
    nativeQuery = true)
	List<Media> findUserMediaOrderedByLikes(@Param("userId") Long userId);
	
}
