//
//  MakePinViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 06.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class MakePinViewController: BaseViewController {
    
    // MARK: - Properties
    
    var coordinator: LoginCoordinator?
    private var makePinView = MakePinView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = makePinView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInteraction()
    }
    
    // MARK: - Private Methods
    
    private func setupInteraction() {
        let goBackOnArrowTap = UITapGestureRecognizer(target: self, action: #selector(back))
        makePinView.arrowBackImage.addGestureRecognizer(goBackOnArrowTap)
    }
    
    @objc private func back() {
        coordinator?.back()
    }
    
}
