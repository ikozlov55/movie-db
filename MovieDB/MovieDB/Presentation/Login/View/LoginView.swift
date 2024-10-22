//
//  LoginView.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` экрана авторизации
final class LoginView: ViewWithLoadingIndicator {
    
    // MARK: - Subviews
    
    let header = HeaderLabel(L10n.welcomeTitle)
    
    let subtitle = SubtitleLabel(L10n.welcomeSubtitle)
    
    let loginTextField = LoginTextField()
    
    let passwordTextField = PasswordTextField()
    
    let errorLabel = ErrorLabel()
    
    let pinImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Asset.pin.image
        view.isUserInteractionEnabled = true
        view.isHidden = true
        return view
    }()
    
    let loginButton = LoginButton()
    
    lazy var textFields = [loginTextField, passwordTextField]
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        addSubviews(header, subtitle, loginTextField, passwordTextField, errorLabel, pinImage, loginButton)
        loginButton.isEnabled = false
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        let inset: CGFloat = 24
        let pinImageSize: CGFloat = 80
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 91),
            header.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            header.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -inset),
            
            subtitle.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 25),
            subtitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            subtitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            
            loginTextField.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 32),
            loginTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            loginTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: inset),
            passwordTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            passwordTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: inset),
            errorLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            errorLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            
            pinImage.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            pinImage.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -50),
            pinImage.widthAnchor.constraint(equalToConstant: pinImageSize),
            pinImage.heightAnchor.constraint(equalToConstant: pinImageSize),
            
            loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            loginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            loginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -27)
        ])
    }
    
}
