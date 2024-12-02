package com.codingdojo.photoconnect.models.repositories;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.photoconnect.models.ProfileData;

@Repository
public interface ProfileDataRepository extends CrudRepository<ProfileData, Long> {
	
	Optional<ProfileData> findByUserId(Long userId);
}
