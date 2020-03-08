//
//  LoginViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 07.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.welcomeTitle
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        label.textColor = ColorName.lightBlue.color
        view.addSubview(label)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30)
        ])
    }

}
