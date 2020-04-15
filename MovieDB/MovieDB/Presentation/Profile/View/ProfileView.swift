//
//  ProfileView.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` экрана профиля
final class ProfileView: UIView {
    
    // MARK: - Subviews
    
    let logoutButton = LogoutButton()
    
    let coreDataSwitchLabel = SubtitleLabel("Core Data")
    
    let coreDataSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let realmSwitchLabel = SubtitleLabel("Realm")
    
    let realmSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        setupLayout()
        setupSwitches()
    }
    
    private func setupLayout() {
        addSubviews(logoutButton, coreDataSwitchLabel, coreDataSwitch, realmSwitchLabel, realmSwitch)
        
        let inset: CGFloat = 24
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            coreDataSwitchLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            coreDataSwitchLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            coreDataSwitch.leadingAnchor.constraint(equalTo: coreDataSwitchLabel.trailingAnchor, constant: inset),
            coreDataSwitch.centerYAnchor.constraint(equalTo: coreDataSwitchLabel.centerYAnchor),
            
            realmSwitchLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            realmSwitchLabel.topAnchor.constraint(equalTo: coreDataSwitchLabel.bottomAnchor, constant: inset),
            realmSwitch.centerXAnchor.constraint(equalTo: coreDataSwitch.centerXAnchor),
            realmSwitch.centerYAnchor.constraint(equalTo: realmSwitchLabel.centerYAnchor),
            
            logoutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -inset),
            logoutButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            logoutButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }
    
    private func setupSwitches() {
        coreDataSwitch.isOn = ServiceLayer.storageService.storageType == .coreData
        realmSwitch.isOn = ServiceLayer.storageService.storageType == .realm
        
        coreDataSwitch.addTarget(self, action: #selector(coreDataSwitchValueChanged), for: .valueChanged)
        realmSwitch.addTarget(self, action: #selector(realmSwitchValueChanged), for: .valueChanged)
    }
    
    @objc private func coreDataSwitchValueChanged() {
        coreDataSwitch.setOn(true, animated: true)
        ServiceLayer.storageService.storageType = .coreData
        realmSwitch.setOn(false, animated: true)
    }
    
    @objc private func realmSwitchValueChanged() {
        realmSwitch.setOn(true, animated: true)
        ServiceLayer.storageService.storageType = .realm
        coreDataSwitch.setOn(false, animated: true)
    }
    
}
