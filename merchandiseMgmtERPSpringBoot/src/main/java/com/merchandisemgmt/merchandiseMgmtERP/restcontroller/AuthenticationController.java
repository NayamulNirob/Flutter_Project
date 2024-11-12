package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;
import com.merchandisemgmt.merchandiseMgmtERP.entity.AuthenticationResponse;
import com.merchandisemgmt.merchandiseMgmtERP.entity.User;
import com.merchandisemgmt.merchandiseMgmtERP.service.AuthService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@AllArgsConstructor
@CrossOrigin(origins = "http://localhost:4200/")
public class AuthenticationController {


    private final AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(
            @RequestPart User user,
            @RequestParam(value = "image", required = false) MultipartFile imageFile
    ) throws IOException {
        return ResponseEntity.ok(authService.register(user, imageFile));
    }

    @PostMapping("/register/admin")
    public ResponseEntity<AuthenticationResponse> registerAdmin(
            @RequestBody User request
    ) {
        return ResponseEntity.ok(authService.registerAdmin(request));
    }


    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> login(
            @RequestBody User request
    ) {
        return ResponseEntity.ok(authService.authenticate(request));
    }



    @GetMapping("/activate/{id}")
    public ResponseEntity<String> activateUser(@PathVariable("id") int id) {
        String response = authService.activateUser(id);
        return ResponseEntity.ok(response);
    }

}
