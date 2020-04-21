//
//  PinAuthorizationHeaderViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 18.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Состояние модуля верхней панели индикатора ввода пин-кода, влияет на текст заголовка и
/// отображение вложенных view
enum PinAuthorizationHeaderState {
    case makePin
    case repeatPin
    case fastLogin(userName: String)
}

/// Тип, ответственный за обработку взаимодействия с модулем верхней панели индикатора ввода пин-кода
protocol PinAuthorizationHeaderDelegate: class {
    
    /// Нажатие стрелочки навигации - назад
    func arrowBackTapped(_ controller: PinAuthorizationHeaderViewController)
    
}

final class PinAuthorizationHeaderViewController: BaseViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: PinAuthorizationHeaderDelegate?
    
    // MARK: - Private Properties
    
    private var pinAuthorizationHeader = PinAuthorizationHeaderView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = pinAuthorizationHeader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
    }
    
    // MARK: - Public methods
    
    func setHeaderState(_ state: PinAuthorizationHeaderState) {
        switch state {
        case .makePin:
            pinAuthorizationHeader.backArrow.isHidden = false
            pinAuthorizationHeader.title.text = L10n.enterNewPinTitle
        case .repeatPin:
            pinAuthorizationHeader.backArrow.isHidden = false
            pinAuthorizationHeader.title.text = L10n.repeatPinTitle
        case .fastLogin(let userName):
            pinAuthorizationHeader.backArrow.isHidden = true
            pinAuthorizationHeader.title.text = userName
        }
    }
    
    func showInputFor(pageNumber: Int) {
        pinAuthorizationHeader.inputIndicator.currentPage = pageNumber
        pinAuthorizationHeader.errorLabel.text = nil
        pinAuthorizationHeader.inputIndicator.setColorScheme(.input)
    }
    
    func showError(_ text: String) {
        pinAuthorizationHeader.errorLabel.text = text
        pinAuthorizationHeader.inputIndicator.setColorScheme(.error)
    }
    
    // MARK: - Private Methods
    
    private func setupGestures() {
        let arrowBackTap = UITapGestureRecognizer(target: self, action: #selector(arrowBackTapped))
        pinAuthorizationHeader.backArrow.addGestureRecognizer(arrowBackTap)
    }
    
    @objc private func arrowBackTapped() {
        delegate?.arrowBackTapped(self)
    }
    
}
