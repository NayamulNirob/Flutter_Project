package com.merchandisemgmt.merchandiseMgmtERP.service;


import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.AllArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;


@Service
@AllArgsConstructor
public class EmailService {

    private final JavaMailSender javaMailSender;

    public void sendSimpleMail(String to, String subject, String text) throws MessagingException {
        MimeMessage mes = javaMailSender.createMimeMessage();
        MimeMessageHelper massage= new MimeMessageHelper(mes,true);
        massage.setTo(to);
        massage.setSubject(subject);
        massage.setText(text);
        massage.setFrom("nayamulislam@gmail.com");
        javaMailSender.send(mes);
    }


}
