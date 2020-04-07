//
//  UIView+Extension.swift
//  MovieDB
//
//  Created by Илья Козлов on 04.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Прикрепляет переданное `view` к краям `UIView`
    /// - Parameter view: `UIView` которые нужно зафиксировать внутри текущего
    func fill(with view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    /// Проигрывает анимацию моргания изменением alpha и выполняет переданное замыкание
    /// - Parameter completion: Замыкание, выполняемое после анимации
    func blink(completion: (() -> Void)? = nil) {
        let initialAlpha = self.alpha
        UIView.animate(
            withDuration: 0.15,
            animations: {
                self.alpha = 0.5
            },
            completion: { _ in
                self.alpha = initialAlpha
                completion?()
            })
    }
}
