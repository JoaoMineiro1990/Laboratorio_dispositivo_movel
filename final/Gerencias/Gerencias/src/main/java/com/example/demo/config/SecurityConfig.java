package com.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // Configuração para desabilitar CSRF (recomendado para APIs REST)
        http.csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(authz -> authz
                // Permite que qualquer pessoa acesse esta rota
                .requestMatchers("/api/v1/users/insert").permitAll() // Rota sem autenticação
                // Exige autenticação para qualquer outra rota
                .anyRequest().authenticated()
            );

        return http.build();
    }
}
