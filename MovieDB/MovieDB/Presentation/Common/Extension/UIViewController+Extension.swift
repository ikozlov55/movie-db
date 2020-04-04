//
//  UIViewController+Extension.swift
//  MovieDB
//
//  Created by Илья Козлов on 31.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Добавление дочернего `UIViewController`
    /// - Parameter child: Дочерний контроллер
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// Удаление `UIViewController` из родительского
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    /// Отображение `UIAlertController` с указанными `title` и `message` и кнопкой ОК
    /// - Parameters:
    ///   - title: Заголовок `UIAlertController`
    ///   - message: Текст сообщения в `UIAlertController`
    func showAlert(title: String = L10n.alertDefaultTitle, message: String = L10n.alertDefaultMessage) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(dismiss)
        self.present(alert, animated: true)
    }
}
