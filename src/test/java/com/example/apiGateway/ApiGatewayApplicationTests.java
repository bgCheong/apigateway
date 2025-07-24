package com.example.apigateway;

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
	}

}
