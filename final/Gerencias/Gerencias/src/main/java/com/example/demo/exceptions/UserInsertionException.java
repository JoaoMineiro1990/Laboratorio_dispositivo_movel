package com.example.demo.exceptions;

public class UserInsertionException extends Exception {

    public enum UserInsertionErrorCode {
        EMAIL_ALREADY_EXISTS,
        DATABASE_ERROR
    }

    private final UserInsertionErrorCode errorCode;

    public UserInsertionException(String message, UserInsertionErrorCode errorCode) {
        super(message);
        this.errorCode = errorCode;
    }

    public UserInsertionException(String message, Throwable cause, UserInsertionErrorCode errorCode) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    public UserInsertionErrorCode getErrorCode() {
        return errorCode;
    }
}
