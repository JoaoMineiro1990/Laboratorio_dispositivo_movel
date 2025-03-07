package com.example.demo.secutiry;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator.Builder;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Map;

@Component
public class JWTHandler {
    @Value("${jwt.secretKey}")
    private String secretKey; // Chave secreta do JWT definida no application.yml

    private static final Integer EXPIRE_TIME = 259200000; // 3 dias
    private Algorithm algorithmSigner; // Algoritmo usado para assinar o JWT
    private static JWTVerifier verifier; // Verificador para validar tokens
        private static final String ISSUER = "gerencias"; // Atualizado para refletir o nome da aplicação
        private final ObjectMapper mapper = new ObjectMapper(); // Utilitário para manipular JSON
    
        @PostConstruct
        private void postConstruct() {
            algorithmSigner = Algorithm.HMAC256(secretKey); // Configura o algoritmo com a chave secreta
            verifier = JWT.require(algorithmSigner)
                    .withIssuer(ISSUER)
                    .acceptExpiresAt(EXPIRE_TIME) // Configura o tempo de expiração
                    .build(); // Constrói o verificador
        }
    
        public String createJWTToken(Map<String, String> data) {
            Builder builder = JWT.create();
    
            // Adiciona claims ao token
            data.forEach(builder::withClaim);
            builder.withExpiresAt(new Date(new Date().getTime() + EXPIRE_TIME)); // Configura expiração
            builder.withIssuer(ISSUER); // Configura o emissor
    
            return builder.sign(algorithmSigner); // Assina o token com o algoritmo configurado
        }
    
        public static DecodedJWT decodeJWTToken(String token) throws JWTVerificationException {
            return verifier.verify(token); // Valida e decodifica o token JWT
    }
}
