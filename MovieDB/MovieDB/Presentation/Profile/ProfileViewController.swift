//
//  ProfileViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    var coordinator: ProfileTabCoordinator?
    
    private var profileView = ProfileView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInteractions()
    }
    
    // MARK: - Private Methods
    
    private func setupInteractions() {
        profileView.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc private func logout() {
        coordinator?.logout()
    }
}
