//
//  LoginTextField.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    
    // MARK: - Properties
    
    private let padding = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 0)

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Positioning Overrides
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    // MARK: - UIResponder Overrides
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let disabledActions = [
            #selector(UIResponderStandardEditActions.copy(_:)),
            #selector(UIResponderStandardEditActions.paste(_:))
        ]
        return disabledActions.contains(action) ? false : super.canPerformAction(action, withSender: sender)
    }
    
    // MARK: - Setup View
    
    func setupView() {
        placeholder = L10n.loginFieldPlaceholder
        textColor = ColorName.lightBlue.color
        layer.borderWidth = 2
        layer.borderColor = ColorName.darkBlue.color.cgColor
        layer.cornerRadius = 8
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    // MARK: - Public methods
    
    /// Анимация ошибки в поле ввода
    func dangle() {
        let duration = 0.5
        let borderAnimation = CABasicAnimation(keyPath: "borderColor")
        borderAnimation.duration = duration
        borderAnimation.autoreverses = true
        borderAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        borderAnimation.toValue = ColorName.red.color.cgColor
        layer.add(borderAnimation, forKey: "flashBorderColor")
        
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.4)
        animator.addAnimations {
            self.transform = CGAffineTransform(translationX: -15, y: 0)
        }
        animator.addAnimations({
            self.transform = CGAffineTransform(translationX: 15, y: 0)
        }, delayFactor: 0.2)
        animator.addAnimations({
            self.transform = CGAffineTransform(translationX: -10, y: 0)
        }, delayFactor: 0.4)
        animator.addAnimations({
            self.transform = CGAffineTransform(translationX: 10, y: 0)
        }, delayFactor: 0.6)
        animator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.8)
        animator.addCompletion { _ in self.transform = .identity }
        animator.startAnimation()
    }

}
