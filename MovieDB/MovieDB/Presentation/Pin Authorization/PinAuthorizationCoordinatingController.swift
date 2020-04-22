//
//  PinAuthorizationCoordinatingController.swift
//  MovieDB
//
//  Created by Илья Козлов on 18.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Этап авторизации по пин-коду: этап создания, повторный ввод или ввод при быстрой авторизации
enum PinAuthorizationStage {
    case makePin
    case repeatPin
    case fastLogin
}

/// `CoordinatingController` флоу авторизации по пин-коду и биометрии
final class PinAuthorizationCoordinatingController: BaseViewController {
    
    // MARK: - Public Properties
    
    var coordinator: LoginCoordinator?
    
    // MARK: - Private Properties
    
    private let setPinHeaderController: PinAuthorizationHeaderViewController
    private let setPinNumpadController: PinAuthorizationNumpadViewController
    
    private let authorizationService = ServiceLayer.pinAuthorizationService
    private let keychain = ServiceLayer.keychainService
    
    private var stage: PinAuthorizationStage
    private let pinLenght = 4
    private var firstInput = [Int]()
    private var currentInput = [Int]()
    
    private let maxInputsCount = 5
    private var failedInputCount = 0
    
    // MARK: - Init
    
    init(stage: PinAuthorizationStage) {
        self.stage = stage
        setPinHeaderController = PinAuthorizationHeaderViewController()
        setPinNumpadController = PinAuthorizationNumpadViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setPinNumpadController.delegate = self
        setPinHeaderController.delegate = self
        resloveAuthorizationStage()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        add(child: setPinHeaderController)
        add(child: setPinNumpadController)
        let safeArea = view.safeAreaLayoutGuide
        setPinHeaderController.view.translatesAutoresizingMaskIntoConstraints = false
        setPinNumpadController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setPinHeaderController.view.topAnchor.constraint(equalTo: safeArea.topAnchor),
            setPinHeaderController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            setPinHeaderController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            setPinHeaderController.view.heightAnchor.constraint(equalToConstant: view.frame.height / 4),
            
            setPinNumpadController.view.topAnchor.constraint(equalTo: setPinHeaderController.view.bottomAnchor),
            setPinNumpadController.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            setPinNumpadController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            setPinNumpadController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func resloveAuthorizationStage() {
        switch stage {
        case .makePin, .repeatPin:
            setPinHeaderController.setHeaderState(.makePin)
            setPinNumpadController.setNumpadState(.makePin)
        case .fastLogin:
            let userName = keychain.getString(key: "userName") ?? ""
            setPinHeaderController.setHeaderState(.fastLogin(userName: userName))
            setPinNumpadController.setNumpadState(.fastLoginNoInput)
        }
        setPinHeaderController.showInputFor(pageNumber: 0)
    }
    
}

// MARK: - PinAuthorizationHeaderDelegate

extension PinAuthorizationCoordinatingController: PinAuthorizationHeaderDelegate {
    func arrowBackTapped(_ controller: PinAuthorizationHeaderViewController) {
        coordinator?.back()
    }
}

// MARK: - PinAuthorizationNumpadDelegate

extension PinAuthorizationCoordinatingController: PinAuthorizationNumpadDelegate {
    func buttonPressed(_ controller: PinAuthorizationNumpadViewController, type: NumpadButtonType) {
        switch type {
        case .number(let value):
            currentInput.append(value)
            setPinHeaderController.showInputFor(pageNumber: currentInput.count)
            resolveInputState()
        case .backspace:
            _ = currentInput.popLast()
            setPinHeaderController.showInputFor(pageNumber: currentInput.count)
            resolveInputState()
        case .exit:
            abortFastLogin()
        case .faceId:
            authorizationService.checkBiometrics { [weak self] success in
                if success { self?.coordinator?.login(self) }
            }
        case .placeholder:
            break
        }
    }
    
    private func resolveInputState() {
        guard currentInput.count == pinLenght else {
            if stage == .fastLogin {
                if currentInput.isEmpty {
                    setPinNumpadController.setNumpadState(.fastLoginNoInput)
                } else {
                    setPinNumpadController.setNumpadState(.fastLogin)
                }
            }
            return
        }
        
        switch stage {
        case .makePin:
            firstInput = currentInput
            currentInput = []
            setPinHeaderController.setHeaderState(.repeatPin)
            setPinHeaderController.showInputFor(pageNumber: 0)
            stage = .repeatPin
        case .repeatPin:
            if currentInput == firstInput {
                let pin = currentInput.map { String($0) }.joined(separator: "")
                authorizationService.setCredentials(pin)
                coordinator?.login(self)
            } else {
                setPinHeaderController.showError(L10n.pinDoesntMatchError)
            }
        case .fastLogin:
            let pin = currentInput.map { String($0) }.joined(separator: "")
            authorizationService.checkPin(pin) { success in
                if success {
                    coordinator?.login(self)
                } else {
                    setPinHeaderController.showError(L10n.invalidPinError)
                    failedInputCount += 1
                    if failedInputCount >= maxInputsCount { abortFastLogin() }
                }
            }
        }
    }
    
    func abortFastLogin() {
        authorizationService.clearCredentials()
        coordinator?.start()
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate

extension PinAuthorizationCoordinatingController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LoginAnimator()
    }
}
