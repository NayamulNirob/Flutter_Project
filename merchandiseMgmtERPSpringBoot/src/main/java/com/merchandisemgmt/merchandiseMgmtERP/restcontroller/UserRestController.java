package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;


import com.merchandisemgmt.merchandiseMgmtERP.entity.User;
import com.merchandisemgmt.merchandiseMgmtERP.service.UserService;
import jakarta.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("api/user")
@CrossOrigin("*")
public class UserRestController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public ResponseEntity<List<User>> getAllUser() {
        List<User> users = userService.getAllUsers();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }


    @PostMapping("/save")
    public ResponseEntity<User> addUser(@RequestPart("user") User user, @RequestParam(value = "image", required = false) MultipartFile imageFile) {
        try {
            userService.saveUser(user, imageFile);
            return new ResponseEntity<>(user, HttpStatus.OK);
        }
        catch (MessagingException | IOException e) {
            return new ResponseEntity<>(user, HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }



}

