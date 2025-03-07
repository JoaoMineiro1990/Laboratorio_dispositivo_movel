package com.example.demo.exceptions;


public class AuthException extends Exception {

    public enum AuthErrorCode {
        INVALID_TOKEN,       // Para tokens inválidos
        EMAIL_NOT_FOUND,     // Quando o email não é encontrado no banco
        PASSWORD_MISMATCH,   // Quando a senha não bate com o email
        TOKEN_EXPIRED,       // Quando o token expirou
        UNAUTHORIZED_ACCESS  // Quando o usuário tenta acessar algo sem permissão
    }

    private final AuthErrorCode errorCode;

    // Construtor para passar apenas a mensagem e o código do erro
    public AuthException(String message, AuthErrorCode errorCode) {
        super(message);
        this.errorCode = errorCode;
    }

    // Construtor para passar a mensagem, causa do erro e o código do erro
    public AuthException(String message, Throwable cause, AuthErrorCode errorCode) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    // Getter para acessar o código do erro
    public AuthErrorCode getErrorCode() {
        return errorCode;
    }
}
