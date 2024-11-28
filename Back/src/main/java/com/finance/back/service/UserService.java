package com.finance.back.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finance.back.model.UserModel;
import com.finance.back.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public String registerUser(UserModel user) {
        if (userRepository.existsByUsername(user.getUsername())) {
            return "이미 존재하는 아이디입니다.";
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            return "이미 존재하는 이메일입니다.";
        }
        userRepository.save(user);
        return "회원가입 성공!";
    }
}