//
//  IdentifiableCell.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип, имеющий свой текстовый идентификатор
protocol IdentifiableCell {
    static var identifier: String { get }
}

extension IdentifiableCell {
    static var identifier: String { String(describing: self) }
}

extension UICollectionViewCell: IdentifiableCell {}

extension UITableViewCell: IdentifiableCell {}
