package com.example.demo.forms;

import lombok.Data;

@Data
public class CreateUserForm {
    private String name;
    private String email;
    private String password;
}
