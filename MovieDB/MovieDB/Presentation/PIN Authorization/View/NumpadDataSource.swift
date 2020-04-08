//
//  NumpadDataSource.swift
//  MovieDB
//
//  Created by Илья Козлов on 07.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `UICollectionViewDataSource` для клавиатуры ввода ПИН кода
class NumpadDataSource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NumpadButtonCell.identifier,
            for: indexPath) as? NumpadButtonCell
            else {
                return UICollectionViewCell()
        }
        switch indexPath.row {
        case 0...9:
            cell.present(.number(indexPath.row))
        case 9:
            cell.present(.number(0))
        case 10:
            cell.present(.backspace)
        default:
            break
        }
        return cell
    }
}
