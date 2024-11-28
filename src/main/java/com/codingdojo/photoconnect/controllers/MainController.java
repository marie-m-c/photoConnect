package com.codingdojo.photoconnect.controllers;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.codingdojo.photoconnect.models.LoginUser;
import com.codingdojo.photoconnect.models.Media;
import com.codingdojo.photoconnect.models.User;
import com.codingdojo.photoconnect.services.MediaService;
import com.codingdojo.photoconnect.services.UserService;

import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MainController {
	
	@Value("${media.storage.path}") // Defined in application.properties
    private String storagePath;
	
	@Autowired
	private UserService userService;
	
	@Autowired MediaService mediaService;
	
	@GetMapping("/")
	public String home() {
		return "index.jsp";
	}
	
	@GetMapping("/about")
	public String about() {
		return "about.jsp";
	}
	
	@GetMapping("/gallery")
	public String gallery(Model model) {
		model.addAttribute("mediaList", mediaService.getAllMedia());
		return "gallery.jsp";
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
	            @PathVariable("userId")Long userId) {
	    	
	    	// Validate file size (limit: 100MB)
	    	try {
	            if (file.getSize() > (100 * 1024 * 1024)) {
	                throw new RuntimeException("File size exceeds the maximum allowed size of 100MB.");
	            }
	            
	         // Determine file type
	            String originalFilename = file.getOriginalFilename();
	            if (originalFilename == null || !originalFilename.contains(".")) {
	                throw new RuntimeException("Invalid file. Could not determine file type.");
	            }

	            String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
	            Media.MediaType mediaType;

	            // Check if the file is an image or video
	            if (extension.matches("jpg|jpeg|png|gif")) {
	                mediaType = Media.MediaType.PHOTO;
	            } else if (extension.matches("mp4|avi|mov|wmv")) {
	                mediaType = Media.MediaType.VIDEO;
	            } else {
	                throw new RuntimeException("Unsupported file type. Only images and videos are allowed.");
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
	            System.out.print("error"+ "Failed to upload media: " + e.getMessage());
	        }

	        return "redirect:/gallery";
	    }
	    
}
