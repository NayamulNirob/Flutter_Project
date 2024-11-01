package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.User;
import com.merchandisemgmt.merchandiseMgmtERP.repository.UserRepository;


import jakarta.mail.MessagingException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;



import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;


@Service
public class UserService implements UserDetailsService {

    private final UserRepository userRepository;

    private final EmailService emailService;

    @Value("${image.upload.dir}")
    private String uploadDir;



    public UserService(UserRepository userRepository, EmailService emailService) {
        this.userRepository = userRepository;
        this.emailService = emailService;
    }

    @Transactional
    public void saveUser(User user, MultipartFile imageFile) throws IOException, MessagingException {

        if(imageFile != null && !imageFile.isEmpty()) {

           String imageFileName = saveImage(imageFile);

            user.setImage(imageFileName);
        }

        String toEmail = user.getEmail();
        String subject = "Registration confarmation";
        String body = String.format("Thanks %s, \n Stay with us and your \n User Name is %s.", toEmail, user.getName());

        emailService.sendSimpleMail(toEmail, subject, body);
        userRepository.save(user);
    }

    private String saveImage(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String fileName = UUID.randomUUID() +"_"+file.getOriginalFilename().toString();
        Path filePath = uploadPath.resolve(fileName);


        Files.copy(file.getInputStream(), filePath);

        return fileName;
    }


    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User findById(long id) {
        return userRepository.findById(id).orElseThrow(
                () -> new RuntimeException("User with id " + id + " not found")
        );
    }

    public void delete(long id) {
        userRepository.deleteById(id);
    }

    public void update(User user, long id) {
        userRepository.save(user);
    }


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByEmail(username)
                .orElseThrow(
                        ()->  new UsernameNotFoundException("User Not Found With this Email Address"));
    }


}
