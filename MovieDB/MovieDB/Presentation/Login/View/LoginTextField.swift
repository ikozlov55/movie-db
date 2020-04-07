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

}