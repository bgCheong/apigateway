package com.example.apiGateway;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import com.example.apigateway.jwt.JwtUtil;

@SpringBootTest
class ApiGatewayApplicationTests {

	 @MockBean
	 private JwtUtil jwtUtil; 

    @Test
    void contextLoads() {
        // 이 테스트는 이제 컨텍스트를 성공적으로 불러올 수 있습니다.
    }

}
