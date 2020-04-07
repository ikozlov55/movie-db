//
//  LoginButton.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class LoginButton: UIButton {
    
    // MARK: - Properties
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? ColorName.orange.color : ColorName.inactiveButtonBlue.color
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: [.beginFromCurrentState, .allowUserInteraction],
                animations: { self.alpha = self.isHighlighted ? 0.5 : 1 },
                completion: nil
            )
        }
    }
    
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
        contentEdgeInsets = UIEdgeInsets(top: 19, left: 0, bottom: 19, right: 0)
        layer.cornerRadius = 8
        setTitle(L10n.loginButtonText, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        setTitleColor(ColorName.gray.color, for: .disabled)
        setTitleColor(ColorName.lightBlue.color, for: .normal)
    }
    
}
