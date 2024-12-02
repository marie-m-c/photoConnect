package com.codingdojo.photoconnect.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.photoconnect.models.ProfileData;
import com.codingdojo.photoconnect.models.repositories.ProfileDataRepository;

@Service
public class ProfileDataService {
	
	@Autowired
	ProfileDataRepository profileDataRepository;
	
	public ProfileData findProfileData(Long id) {
	     Optional<ProfileData> optionalProfileData = profileDataRepository.findById(id);
	     if(optionalProfileData.isPresent()) {
	         return optionalProfileData.get();
	     } else {
	         return null;
	     }
	 }
	
	public ProfileData findProfileDataByUserId(Long id) {
	     Optional<ProfileData> optionalProfileData = profileDataRepository.findByUserId(id);
	     if(optionalProfileData.isPresent()) {
	         return optionalProfileData.get();
	     } else {
	         return null;
	     }
	 }
	
	public ProfileData updateProfileData(ProfileData profileData) {
		   return profileDataRepository.save(profileData
				   );
		}
}
