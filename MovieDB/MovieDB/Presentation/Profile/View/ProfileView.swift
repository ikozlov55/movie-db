//
//  ProfileView.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    // MARK: - Subviews
    
    let logoutButton = LogoutButton()
    
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
        addSubview(logoutButton)
        
        let inset: CGFloat = 24
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -inset),
            logoutButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            logoutButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }

}
