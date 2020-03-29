//
//  ViewWithLoadingIndicator.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class ViewWithLoadingIndicator: UIView {
    
    // MARK: - Subviews
    
    var loadingIndicator: LoadingIndicatorView?
    
    // MARK: - Public methods
    
    func startLoadingIndicator() {
        loadingIndicator = LoadingIndicatorView(frame: frame)
        guard let indicator = loadingIndicator else { return }
        addSubview(indicator)
        indicator.startAnimating()
    }
    
    func stopLoadingIndicator() {
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
    }
    
}
