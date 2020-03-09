//
//  PasswordTextField.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class PasswordTextField: LoginTextField {
    
    // MARK: - Public Properties
    
    override var isSecureTextEntry: Bool {
        didSet {
            visibilityIconView.image = isSecureTextEntry ? Asset.visibility.image : Asset.visibilityOff.image
        }
    }
    
    // MARK: - Private Properties
    
    private var visibilityIconView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.visibility.image
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - Positioning Overrides
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightPadding: CGFloat = 15
        let iconWidth = Asset.visibility.image.size.width
        let leftPadding = bounds.size.width - iconWidth - rightPadding
        let padding = UIEdgeInsets(top: 10, left: leftPadding, bottom: 10, right: rightPadding)
        return bounds.inset(by: padding)
    }
    
    // MARK: - Setup View
    
    override func setupView() {
        super.setupView()
        placeholder = L10n.passwordFieldPlaceholder
        rightView = visibilityIconView
        rightViewMode = .always
        isSecureTextEntry = true
        
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(toggleSecureTextEntry))
        visibilityIconView.addGestureRecognizer(iconTap)
    }
    
    // MARK: - Private Methods
    
    @objc private func toggleSecureTextEntry() {
        isSecureTextEntry.toggle()
    }
    
}
