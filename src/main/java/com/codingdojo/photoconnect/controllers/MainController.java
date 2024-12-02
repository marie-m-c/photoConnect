package com.codingdojo.photoconnect.controllers;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.codingdojo.photoconnect.models.LoginUser;
import com.codingdojo.photoconnect.models.Media;
import com.codingdojo.photoconnect.models.ProfileData;
import com.codingdojo.photoconnect.models.User;
import com.codingdojo.photoconnect.services.MediaService;
import com.codingdojo.photoconnect.services.ProfileDataService;
import com.codingdojo.photoconnect.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MainController {
	
	@Value("${media.storage.path}") // Defined in application.properties
    private String storagePath;
	
	@Autowired
	private UserService userService;
	
	@Autowired 
	private MediaService mediaService;
	
	@Autowired
	private ProfileDataService profileDataService;
	
	@GetMapping("/")
	public String home() {
		return "index.jsp";
	}
	
	@GetMapping("/about")
	public String about() {
		return "about.jsp";
	}
	
	@GetMapping("/gallery")
	public String gallery(Model model, HttpSession session) {
		if (session.getAttribute("userId") != null ) {
			Long id = (Long) session.getAttribute("userId");
			model.addAttribute("currentUser", userService.findUser(id));
    	}
		model.addAttribute("mediaList", mediaService.getAllMedia());
		return "gallery.jsp";
	}
	
	@GetMapping("/profile/{Id}")
	public String userProfile(@PathVariable("Id") Long id, Model model, HttpSession session) {
		if (session.getAttribute("userId") == null ) {
			return "redirect:/login";
    	}
		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("currentUser", userService.findUser(userId));
		model.addAttribute("profileUser", userService.findUser(id));
		model.addAttribute("profileData", profileDataService.findProfileDataByUserId(id));
		model.addAttribute("likes", mediaService.getTotalLikesForUserUploadedMedia(id));
		model.addAttribute("mediaList", mediaService.getAllUserMedia(id));
		return "profile.jsp";
	}
	
	@GetMapping("/medias/{mediaId}")
	public String mediaDetails(@PathVariable("mediaId") Long id, Model model, HttpSession session) {
		if (session.getAttribute("userId") == null ) {
			return "redirect:/login";
    	}
		
		model.addAttribute("media", mediaService.findMedia(id));
		return "media.jsp";
	}
	
	
	
	@GetMapping("/login")
	public String login(@ModelAttribute("newLogin")LoginUser newLogin) {
		return "login.jsp";
	}
	
	@GetMapping("/register")
	public String register(@ModelAttribute("newUser")User newUser) {
		return "register.jsp";
	}
	
	 @PostMapping("/signup")
	    public String signUp(@Valid @ModelAttribute("newUser") User newUser, 
	            BindingResult result, HttpSession session) {
	        
	        User created = userService.register(newUser, result);
	        
	        if(result.hasErrors()) {
	            return "register.jsp";
	        }
	        
	        session.setAttribute("userId", created.getId());
	        session.setAttribute("userName", created.getUserName());
	        session.setAttribute("loggedIn", true);
	    
	        return "redirect:/gallery";
	    }
	    
	    @PostMapping("/signin")
	    public String signIn(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
	            BindingResult result, HttpSession session) {
	        
	        User user = userService.login(newLogin, result);
	    
	        if(result.hasErrors()) {
	            return "login.jsp";
	        }
	    
	        session.setAttribute("userId", user.getId());
	        session.setAttribute("userName", user.getUserName());
	        session.setAttribute("loggedIn", true);
	    
	        return "redirect:/gallery";
	    }
	    
	    @GetMapping("/logout")
	    String logout(HttpSession session) {
	    	session.invalidate();
	    	return "redirect:/";
	    }
	    
	    @PostMapping("/media/uploadFile/{userId}")
	    public String uploadMedia(
	            @RequestParam("file") MultipartFile file,
	            @RequestParam("caption") String caption,
	            @PathVariable("userId") Long userId,
	            Model model, HttpSession session) {
	    	
	    	Long id = (Long) session.getAttribute("userId");
	    	model.addAttribute("currentUser", userService.findUser(id));
        	model.addAttribute("mediaList", mediaService.getAllMedia());
			
	        try {
	            // Validate file size (limit: 100MB)
	            if (file.getSize() > (100 * 1024 * 1024)) {
	                model.addAttribute("error", "File size exceeds the maximum allowed size of 100MB.");
	                return "gallery.jsp";
	            }
	            
	         // Validate caption length (3 to 30 characters)
	            if (caption == null || caption.trim().length() < 3 || caption.trim().length() > 150) {
	                model.addAttribute("error", "Caption must be between 3 and 150 characters.");
	                return "gallery.jsp";
	            }

	            // Determine file type
	            String originalFilename = file.getOriginalFilename();
	            if (originalFilename == null || !originalFilename.contains(".")) {
	                model.addAttribute("error", "Invalid file. Could not determine file type.");
	                return "gallery.jsp";
	            }

	            String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
	            Media.MediaType mediaType;

	            // Check if the file is an image or video
	            if (extension.matches("(?i)(jpg|jpeg|png|gif)")) {
	                mediaType = Media.MediaType.PHOTO;
	            } else if (extension.matches("(?i)(mp4|avi|mov|wmv)")) {
	                mediaType = Media.MediaType.VIDEO;
	            } else {
	                model.addAttribute("error", "Unsupported file type. Only images and videos are allowed.");
	                return "gallery.jsp";
	            }

	            // Generate a unique file name
	            String uniqueFileName = UUID.randomUUID() + "_" + originalFilename;

	            // Save the file to the local storage
	            File storageDirectory = new File(storagePath);
	            if (!storageDirectory.exists()) {
	                storageDirectory.mkdirs();
	            }
	            File destinationFile = new File(storageDirectory, uniqueFileName);
	            file.transferTo(destinationFile);

	            // Save the media details in the database
	            mediaService.saveMedia(uniqueFileName, caption, userService.findUser(userId), mediaType);

	        } catch (IOException e) {
	            model.addAttribute("error", "Failed to upload media due to an internal error: " + e.getMessage());
	            return "gallery.jsp";
	        } catch (RuntimeException e) {
	            model.addAttribute("error", "Invalid file or unsupported file type: " + e.getMessage());
	            return "gallery.jsp";
	        }

	        return "redirect:/gallery"; // Success, redirect to gallery
	    }

	    @DeleteMapping("/medias/{source}/{id}/delete")
	    public String removeMedia(@PathVariable("source")String source, @PathVariable("id") Long id, HttpSession session) {
	    	mediaService.deleteMedia(id);
	    	if (source.equals("profile")) {
	    		Long userId = (Long) session.getAttribute("userId");
	    		return "redirect:/profile/" + userId;
	    	}
	    	return "redirect:/gallery";
	    }
	    
	    @PostMapping("/medias/{id}/edit")
	    public String editMedia(@PathVariable("id") Long id, Model model, HttpSession session) {
	    	if (session.getAttribute("userId") == null ) {
	    		return "redirect:/";
	    	}
	    	model.addAttribute("media", mediaService.findMedia(id));
	    	return "edit.jsp";
	    }
	    
	    @PostMapping("/medias/update/{id}")
	    public String updateMedia(@RequestParam("caption") String caption, @PathVariable("id") Long id, Model model) {
	          Media media = mediaService.findMedia(id);
	          if (caption == null || caption.trim().length() < 3 || caption.trim().length() > 150) {
	        	  model.addAttribute("error", "Caption must be between 3 and 150 characters.");
	        	  model.addAttribute("media", media);
	        	  return "edit.jsp";
	    	}
	          media.setCaption(caption);
	          mediaService.updateMedia(media);
	         return "redirect:/medias/" + id;
	    }
	    
	    @PostMapping("/profileData/{id}/edit")
	    public String editProfileData(@PathVariable("id") Long id, Model model, HttpSession session) {
	    	if (session.getAttribute("userId") == null ) {
	    		return "redirect:/";
	    	}
	    	model.addAttribute("profileData", profileDataService.findProfileData(id));
	    	return "editProfileData.jsp";
	    }
	    
	    @PutMapping("/profileData/update/{id}")
	    public String updateProfile(@Valid @ModelAttribute ProfileData profileData, BindingResult result,
	    		Model model, @PathVariable("id") Long id) {
	    	ProfileData existingProfile = profileDataService.findProfileData(id);
	    	profileData.setUser(existingProfile.getUser());
	    	profileData.setProfilePicture(existingProfile.getProfilePicture());
	    	if (result.hasErrors()) {
	    		model.addAttribute("profileData", profileData);
	    		return "editProfileData.jsp";
	    	} else {
	    		profileDataService.updateProfileData(profileData);
	    		return "redirect:/profile/" + profileData.getUser().getId();
	    	}
	    }
	    
	    @PutMapping("/profile/picture/update/{id}")
	    public String updateProfilePicture(@RequestParam("profilePicture") MultipartFile file,
	    		@PathVariable("id") Long id) {
	        ProfileData profileData = profileDataService.findProfileData(id);
	        
	        if (file.getSize() > (100 * 1024 * 1024)) {
	        	return "redirect:/profile/" + profileData.getUser().getId();
	        }
	        
	        
	        String originalFilename = file.getOriginalFilename();
	        if (originalFilename == null || !originalFilename.contains(".")) {
	        	return "redirect:/profile/" + profileData.getUser().getId();
	        }

	        String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
	            if (!extension.matches("(?i)(jpg|jpeg|png|gif)")) {
	            	return "redirect:/profile/" + profileData.getUser().getId();
	            }
	            
	        String uniqueFileName = UUID.randomUUID() + "_" + originalFilename;
	            File storageDirectory = new File(storagePath);
	            if (!storageDirectory.exists()) {
	                storageDirectory.mkdirs();
	            }
	            File destinationFile = new File(storageDirectory, uniqueFileName);
	            try {
	            	file.transferTo(destinationFile);
	            }  catch (IOException e) {
	            	
	            	return "redirect:/profile/" + profileData.getUser().getId();
	            }
	           profileData.setProfilePicture(uniqueFileName);
	           profileDataService.updateProfileData(profileData);

	        return "redirect:/profile/" + profileData.getUser().getId();
	        
	    }
	    
}
