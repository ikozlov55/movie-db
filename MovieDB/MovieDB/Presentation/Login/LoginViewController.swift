//
//  LoginViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 07.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    var coordinator: LoginCoordinator?
    
    private var loginView = LoginView()
    
    private let authService: AuthServiceProtocol = AuthService.shared
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInteractions()
    }
    
    // MARK: - Private Methods
    
    private func setupInteractions() {
        let hideKeyboardOnTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        loginView.addGestureRecognizer(hideKeyboardOnTap)
        loginView.textFields.forEach { $0.delegate = self }
        loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc private func hideKeyboard() {
        loginView.textFields.forEach { $0.resignFirstResponder() }
    }
    
    @objc private func login() {
        guard
            let login = loginView.loginTextField.text?.trim,
            let password = loginView.passwordTextField.text?.trim
            else { return }
        loginView.startLoadingIndicator()
        authService.login(
            username: login,
            password: password,
            success: { [weak self] _ in self?.coordinator?.login() },
            failure: { [weak self] error in
                switch error {
                case .invalidCredentials:
                    self?.loginView.errorLabel.text = L10n.invalidCredentialsError
                default:
                    self?.loginView.errorLabel.text = L10n.loginFailedError
                }
                self?.loginView.stopLoadingIndicator()
            }
        )
        
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let input = loginView.textFields.compactMap { $0.text }.filter { !$0.trim.isEmpty }
        loginView.loginButton.isEnabled = input.count == loginView.textFields.count
    }
    
}
