//
//  LoginViewController.swift
//  Closure_Practice
//
//  Created by Nabiyev Anar on 18.01.26.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(emailDidChange), for: .editingChanged)
        return textField
    }()
    
    private let emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        return textField
    }()
    
    private let passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 16
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        title = "Login"
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
            view.addSubview(emailTextField)
            view.addSubview(emailErrorLabel)
            view.addSubview(passwordTextField)
            view.addSubview(passwordErrorLabel)
            view.addSubview(loginButton)
            
            emailTextField.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(44)
            }
            
            emailErrorLabel.snp.makeConstraints { make in
                make.top.equalTo(emailTextField.snp.bottom).offset(4)
                make.leading.trailing.equalTo(emailTextField)
            }
            
            passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(emailErrorLabel.snp.bottom).offset(20)
                make.leading.trailing.height.equalTo(emailTextField)
            }
            
            passwordErrorLabel.snp.makeConstraints { make in
                make.top.equalTo(passwordTextField.snp.bottom).offset(4)
                make.leading.trailing.equalTo(passwordTextField)
            }
            
            loginButton.snp.makeConstraints { make in
                make.top.equalTo(passwordErrorLabel.snp.bottom).offset(40)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(50)
            }
        }
    
    private func setupBindings() {
        viewModel.onEmailValidationChanged = { [weak self] isValid, errorMessage in
            self?.handleEmailValidation(isValid: isValid, error: errorMessage)
        }
        
        viewModel.onPasswordValidationChanged = { [weak self] isValid, errorMessage in
            self?.handlePasswordValidation(isValid: isValid, error: errorMessage)
        }
        
        viewModel.onLoginButtonStateChanged = { [weak self] isEnabled in
            self?.updateLoginButton(isEnabled: isEnabled)
        }
        
        viewModel.onLoginSuccess = { [weak self] in
            self?.handleLoginSuccess()
        }
        
        viewModel.onLoginFailed = { [weak self] errorMessage in
            self?.handleLoginFailed(error: errorMessage)
        }
    }
    
    private func handleEmailValidation(isValid: Bool, error: String?) {
        if let error = error {
            emailErrorLabel.text = error
            emailErrorLabel.isHidden = false
        } else {
            emailErrorLabel.isHidden = true
        }
    }
    
    private func handlePasswordValidation(isValid: Bool, error: String?) {
        if let error = error {
            passwordErrorLabel.text = error
            passwordErrorLabel.isHidden = false
        } else {
            passwordErrorLabel.isHidden = true
        }
    }
    
    private func updateLoginButton(isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
        loginButton.backgroundColor = isEnabled ? .systemIndigo : .systemGray
    }
    
    private func handleLoginSuccess() {
        let alert = UIAlertController(title: "Success!", message: "You are logged in!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func handleLoginFailed(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc
    private func emailDidChange() {
        viewModel.email = emailTextField.text ?? ""
        viewModel.validateEmail()
    }
    
    @objc
    private func passwordDidChange() {
        viewModel.password = passwordTextField.text ?? ""
        viewModel.validatePassword()
    }
    
    @objc
    private func didTapLogin() {
        viewModel.login()
    }
}
