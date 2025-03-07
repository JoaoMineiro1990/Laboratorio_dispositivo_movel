package com.example.demo.exceptions;

public class UserUpdateException extends Exception {

    public enum UserUpdateErrorCode {
        USER_NOT_FOUND,
        DATABASE_ERROR
    }

    private final UserUpdateErrorCode errorCode;

    public UserUpdateException(String message, UserUpdateErrorCode errorCode) {
        super(message);
        this.errorCode = errorCode;
    }

    public UserUpdateException(String message, Throwable cause, UserUpdateErrorCode errorCode) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    public UserUpdateErrorCode getErrorCode() {
        return errorCode;
    }
}
