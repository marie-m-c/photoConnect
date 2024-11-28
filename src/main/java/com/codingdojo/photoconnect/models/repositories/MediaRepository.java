package com.codingdojo.photoconnect.models.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.photoconnect.models.Media;

@Repository
public interface MediaRepository extends CrudRepository<Media, Long> {

	List<Media> findAll();
}
