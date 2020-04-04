//
//  LoadingViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 31.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `UIViewController` с вложенным индикатором загрузки, анимация стартует
/// сразу при загрузке во `viewDidLoad`
class LoadingViewController: BaseViewController {
    
    // MARK: - Private Properties
    
    var indicatorView = LoadingIndicatorView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = indicatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.startAnimating()
    }
    
}
