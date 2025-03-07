package com.example.demo.services;

import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.demo.entities.UserEntity;
import com.example.demo.exceptions.AuthException;
import com.example.demo.exceptions.DatabaseException;
import com.example.demo.exceptions.UserInsertionException;
import com.example.demo.forms.CreateUserForm;
import com.example.demo.models.UserModel;
import com.example.demo.repositories.UserRepository;
import com.example.demo.secutiry.JWTHandler;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    private JWTHandler jwtHandler;
    private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();


    public UserModel insertUser(String token, CreateUserForm form) throws UserInsertionException, AuthException {
        try {
            // Logando a chegada do token
            System.out.println("Verificando token: " + token);
    
            // Verificando se o token é válido (aqui você pode adicionar a função de validação do token)
            UserModel userModel = retrieveTokenInfo(token);
            System.out.println("Token validado com sucesso.");
    
            // Verificando se o e-mail já está cadastrado
            if (userRepository.findByEmail(form.getEmail()) != null) {
                System.out.println("Email já está em uso: " + form.getEmail());
                throw new UserInsertionException("Email já está em uso!", UserInsertionException.UserInsertionErrorCode.EMAIL_ALREADY_EXISTS);
            }
            System.out.println("Email disponível para cadastro: " + form.getEmail());
    
            // Criando o novo usuário
            UserEntity newUser = new UserEntity(
                null,
                form.getName(),
                encoder.encode(form.getPassword()),  // Certificando que a senha está sendo criptografada
                form.getEmail()
            );
    
            // Salvando o novo usuário no banco de dados
            userRepository.save(newUser);
            System.out.println("Novo usuário inserido com sucesso: " + newUser.getEmail());
    
            // Retornando o modelo do usuário
            UserModel userModelResponse = new UserModel(newUser);
            System.out.println("Modelo de usuário retornado com sucesso: " + userModelResponse.getEmail());
    
            return userModelResponse;
    
        } catch (UserInsertionException e) {
            System.out.println("Erro ao inserir usuário: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            // Caso haja qualquer outra exceção, logamos o erro
            System.out.println("Erro inesperado: " + e.getMessage());
            throw new RuntimeException("Erro ao tentar inserir usuário: " + e.getMessage());
        }
    }
    
    
    public UserModel retrieveTokenInfo(String token) throws JWTVerificationException {
        // Decodifica e valida o token JWT
        DecodedJWT decodedJWT = jwtHandler.decodeJWTToken(token);
    
        // Cria o HashMap para armazenar as informações do token
        HashMap<String, String> userMap = new HashMap<>();
    
        // Preenche o HashMap com as claims do token
        for (Map.Entry<String, Claim> entry : decodedJWT.getClaims().entrySet()) {
            String key = entry.getKey();
            Claim value = entry.getValue();
            userMap.put(key, value.asString());
        }
    
        // Retorna o UserModel utilizando o HashMap
        return new UserModel(userMap);
    }
    

    // Deletar usuário
    public UserModel deleteUser(String token) throws AuthException, DatabaseException {
    try {
        // Verifica o token e encontra o usuário
        UserModel loggedUser = getUserFromToken(token);
        
        // Tenta encontrar o usuário no banco
        UserEntity user = userRepository.findById(UUID.fromString(loggedUser.getId()))
                                        .orElseThrow(() -> new AuthException("Usuário não encontrado!", AuthException.AuthErrorCode.EMAIL_NOT_FOUND));

        // Tenta deletar o usuário
        userRepository.deleteById(user.getId());

        return new UserModel(user);
    } catch (Exception e) {
        // Lança exceção de banco de dados genérico
        throw new DatabaseException("Erro ao tentar excluir o usuário", e);
    }
    
}
public UserModel getUserFromToken(String token) throws AuthException {
    try {
        // Decodificar o token JWT
        DecodedJWT decodedJWT = JWTHandler.decodeJWTToken(token);
        
        // Extrair o ID do usuário a partir do token
        String userId = decodedJWT.getClaim("id").asString();

        // Buscar o usuário no banco de dados
        UserEntity user = userRepository.findById(UUID.fromString(userId))
                                        .orElseThrow(() -> new AuthException("Usuário não encontrado!", AuthException.AuthErrorCode.EMAIL_NOT_FOUND));

        return new UserModel(user);
    } catch (JWTVerificationException e) {
        // Lança exceção de token inválido
        throw new AuthException("Token inválido!", e, AuthException.AuthErrorCode.INVALID_TOKEN);
    } catch (Exception e) {
        // Lança exceção de erro inesperado
        throw new AuthException("Erro ao buscar o usuário com o token!", e, AuthException.AuthErrorCode.UNAUTHORIZED_ACCESS);
    }
}

}
