package com.finance.back.repository;

import com.finance.back.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

// 두 번째 타입 매개변수는 기본 키 필드(id)의 데이터 타입
public interface UserRepository extends JpaRepository<UserModel, Long> {
    boolean existsByUserId(String userId);
}