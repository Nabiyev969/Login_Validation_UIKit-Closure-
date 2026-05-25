//
//  LoginViewModel.swift
//  Closure_Practice
//
//  Created by Nabiyev Anar on 18.01.26.
//

import Foundation

final class LoginViewModel {
    
    var email: String = ""
    var password: String = ""
    
    var onEmailValidationChanged: ((Bool, String?) -> ())?
    var onPasswordValidationChanged: ((Bool, String?) -> ())?
    var onLoginButtonStateChanged: ((Bool) -> ())?
    var onLoginSuccess: (() -> ())?
    var onLoginFailed: ((String) -> ())?
    
    private var isEmailValid = false
    private var isPasswordValid = false
    
    func validateEmail() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        
        if trimmedEmail.isEmpty {
            isEmailValid = false
            onEmailValidationChanged?(false, nil)
        } else if !trimmedEmail.contains("@") || !trimmedEmail.contains(".") {
            isEmailValid = false
            onEmailValidationChanged?(false, "Email must contain @ and .")
        } else {
            isEmailValid = true
            onEmailValidationChanged?(true, nil)
        }
        
        updateLoginButtonState()
    }
    
    func validatePassword() {
        if password.isEmpty {
            isPasswordValid = false
            onPasswordValidationChanged?(false, nil)
        } else if password.count < 6 {
            isPasswordValid = false
            onPasswordValidationChanged?(false, "Password must be at least 6 characters")
        } else {
            isPasswordValid = true
            onPasswordValidationChanged?(true, nil)
        }
        
        updateLoginButtonState()
    }
    
    private func updateLoginButtonState() {
        
        let isEnabled = isEmailValid && isPasswordValid
        onLoginButtonStateChanged?(isEnabled)
    }
    
    func login() {
        
        guard isEmailValid && isPasswordValid else {
            onLoginFailed?("Please fill all fields correctly")
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            
            if self.email == "test@mail.com" && self.password == "123456" {
                self.onLoginSuccess?()
            } else {
                self.onLoginFailed?("Invalid email or password")
            }
        }
    }
}
