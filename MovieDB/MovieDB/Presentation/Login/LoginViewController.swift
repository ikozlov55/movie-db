//
//  LoginViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 07.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import MovieDBAPI
import UIKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    var coordinator: LoginCoordinator?
    
    private var loginView = LoginView()
    private let authService = ServiceLayer.authService
    
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
        loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginView.textFields.forEach { $0.delegate = self }
        
        let pinImageTap = UITapGestureRecognizer(target: self, action: #selector(pinImageTapped))
        loginView.pinImage.addGestureRecognizer(pinImageTap)
    }
    
    @objc private func hideKeyboard() {
        loginView.textFields.forEach { $0.resignFirstResponder() }
    }
    
    @objc private func pinImageTapped() {
        loginView.pinImage.blink { self.coordinator?.authorizeWithPin() }
    }
    
    @objc private func login() {
        guard let login = loginView.loginTextField.text?.trim,
            let password = loginView.passwordTextField.text?.trim
            else { return }
        loginView.startLoadingIndicator()
        authService.login(username: login, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.coordinator?.login(self)
            case .failure(let error):
                self?.loginView.errorLabel.text = self?.message(for: error)
                self?.loginView.stopLoadingIndicator()
                self?.loginView.textFields.forEach { if $0.isEditing { $0.dangle() } }
            }
        }
    }
    
    private func message(for error: Error) -> String {
        if let errorDTO = error as? RequestStatusDTO,
            let statusCode = StatusCode(rawValue: errorDTO.statusCode),
            statusCode == .invalidCredentials {
            return L10n.invalidCredentialsError
        } else {
            return L10n.loginFailedError
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let input = loginView.textFields.compactMap { $0.text }.filter { !$0.trim.isEmpty }
        loginView.loginButton.isEnabled = input.count == loginView.textFields.count
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = ColorName.purpure.color.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor = ColorName.darkBlue.color.cgColor
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate

extension LoginViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LoginAnimator()
    }
}
