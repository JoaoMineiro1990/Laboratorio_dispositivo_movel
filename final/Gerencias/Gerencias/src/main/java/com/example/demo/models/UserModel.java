package com.example.demo.models;

import java.util.HashMap;
import com.example.demo.entities.UserEntity;
import lombok.Data;

@Data
public class UserModel {
    private String id;
    private String name;
    private String email;

    // Construtor utilizando o UserEntity
    public UserModel(UserEntity userEntity) {
        this.id = userEntity.getId().toString();
        this.name = userEntity.getName();
        this.email = userEntity.getEmail();
    }

    // Construtor utilizando um HashMap
    public UserModel(HashMap<String, String> userMap) {
        this.id = userMap.get("id");
        this.name = userMap.get("name");
        this.email = userMap.get("email");
    }
}
