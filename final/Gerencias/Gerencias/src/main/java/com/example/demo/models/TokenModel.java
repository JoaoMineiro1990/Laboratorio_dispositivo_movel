package com.example.demo.models;

import lombok.Data;

@Data
public class TokenModel {
    private String token;

    public TokenModel(String token) {
        this.token = token;
    }
}
