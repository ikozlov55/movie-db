//
//  ViewWithLoadingIndicator.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Базовый `UIView` с индикатором загрузки
class ViewWithLoadingIndicator: UIView {
    
    // MARK: - Subviews
    
    private lazy var loadingIndicator = LoadingIndicatorView(frame: frame)
    
    // MARK: - Public methods
    
    /// Старт анимации вложенного `UIActivityIndicatorView`
    func startLoadingIndicator() {
        addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    /// Остановка анимации вложенного `UIActivityIndicatorView`
    func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
    
}
