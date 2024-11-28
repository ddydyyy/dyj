package com.finance.back.repository;

import com.finance.back.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserModel, Long> {
    boolean existsByUsername(String username);

    boolean existsByEmail(String email);
}