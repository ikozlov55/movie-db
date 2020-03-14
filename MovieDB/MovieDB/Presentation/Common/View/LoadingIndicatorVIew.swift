//
//  LoadingIndicatorVIew.swift
//  MovieDB
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class LoadingIndicatorVIew: UIView {
    
    // MARK: - Subviews
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .whiteLarge
        return indicator
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
        isUserInteractionEnabled = false
        backgroundColor = ColorName.backgroundBlack.color
        alpha = 0.8
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Public methods
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }

}
