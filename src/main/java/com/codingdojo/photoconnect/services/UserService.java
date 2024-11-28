package com.codingdojo.photoconnect.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.photoconnect.models.LoginUser;
import com.codingdojo.photoconnect.models.User;
import com.codingdojo.photoconnect.models.repositories.UserRepository;

@Service
public class UserService {
	
	 @Autowired
	 private UserRepository userRepo;
	    
	 public User register(User newUser, BindingResult result) {
		 Optional<User> user = userRepo.findByEmail(newUser.getEmail());
		 if (user.isPresent()) {
			 result.rejectValue("email", "unique", "already taken");
		 }
		 if(!newUser.getPassword().equals(newUser.getConfirm())) {
			 result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
		 }
		 if (result.hasErrors()) {
			 return null;
		 }
		 String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
		 newUser.setPassword(hashed);
		 return userRepo.save(newUser);
	 }
	    
	 public User login(LoginUser newLoginObject, BindingResult result) {
		 Optional<User> potentialUser = userRepo.findByEmail(newLoginObject.getEmail());
		 if (!potentialUser.isPresent()) {
			 result.rejectValue("email", "exist", "Invalid Credential!");
			 return null;
		 }
		 User user = potentialUser.get();
		 if(!BCrypt.checkpw(newLoginObject.getPassword(), user.getPassword())) {
			 result.rejectValue("password", "Matches", "Invalid Password!");
		 }
		 if (result.hasErrors()) {
			 return null;
		 } else {
			 return user;
		 }
	 }
	 
	 public User findUser(Long id) {
	     Optional<User> optionalUser = userRepo.findById(id);
	     if(optionalUser.isPresent()) {
	         return optionalUser.get();
	     } else {
	         return null;
	     }
	 }
	
}
