package com.example.demo.controllers;

import com.example.demo.exceptions.AuthException;
import com.example.demo.exceptions.UserInsertionException;
import com.example.demo.forms.CreateUserForm;
import com.example.demo.models.UserModel;
import com.example.demo.services.UserService;

import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;
    @PostMapping("/insert")
    public ResponseEntity<UserModel> insertUser(
        @RequestHeader(name = HttpHeaders.AUTHORIZATION) String token, 
        @RequestBody CreateUserForm createUserForm) {
    try {
        // Print para verificar o token recebido
        System.out.println("Token recebido: " + token);

        // Chamando o serviço para inserir o usuário
        UserModel newUser = userService.insertUser(token, createUserForm);
        System.out.println("Usuário inserido com sucesso: " + newUser.getEmail());

        // Retorna resposta com status CREATED
        return new ResponseEntity<>(newUser, HttpStatus.CREATED);
    } catch (UserInsertionException e) {
        // Print para capturar quando o e-mail já está em uso ou outros erros de inserção
        System.out.println("Erro ao inserir usuário (UserInsertionException): " + e.getMessage());

        // Retorna resposta com status BAD_REQUEST
        return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
    } catch (AuthException e) {
        // Print para capturar problemas de autenticação
        System.out.println("Erro de autenticação (AuthException): " + e.getMessage());

        // Retorna resposta com status FORBIDDEN
        return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);
    } catch (Exception e) {
        // Print para capturar qualquer outro erro inesperado
        System.out.println("Erro inesperado: " + e.getMessage());

        // Retorna resposta com status INTERNAL_SERVER_ERROR
        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}

    // Deletar usuário
@DeleteMapping(value = "/delete")
public ResponseEntity<UserModel> deleteUser(@RequestHeader(HttpHeaders.AUTHORIZATION) String token) {
    try {
        return new ResponseEntity<>(userService.deleteUser(token), HttpStatus.OK);
    } catch (AuthException e) {
        return new ResponseEntity<>(null, HttpStatus.FORBIDDEN); // Caso ocorra erro de autenticação
    } catch (NoSuchElementException e) {
        return new ResponseEntity<>(null, HttpStatus.NOT_FOUND); // Caso o usuário não seja encontrado
    } catch (Exception e) {
        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR); // Para qualquer outro erro genérico
    }
}

}
