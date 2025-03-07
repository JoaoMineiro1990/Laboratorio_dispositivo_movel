package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.example.demo.repositories") // Repositórios
@EntityScan(basePackages = "com.example.demo.*") // Entidades
public class GerenciasApplication {

    public static void main(String[] args) {
        SpringApplication.run(GerenciasApplication.class, args);
    }
}
