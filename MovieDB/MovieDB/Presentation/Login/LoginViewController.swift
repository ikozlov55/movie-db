//
//  LoginViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 07.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    var coordinator: LoginCoordinator?
    
    private var loginView = LoginView()
    
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
        
        if login != "user" && password != "123456" {
            loginView.errorLabel.text = L10n.invalidCredentialsError
        } else {
            coordinator?.login()
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let input = loginView.textFields.compactMap { $0.text }.filter { !$0.trim.isEmpty }
        loginView.loginButton.isEnabled = input.count == loginView.textFields.count ? true : false
    }
    
}
