//
//  NumpadDataSource.swift
//  MovieDB
//
//  Created by Илья Козлов on 07.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `UICollectionViewDataSource` для клавиатуры ввода пин-кода
final class NumpadDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Public Properties
    
    var buttons: [NumpadButtonType] = []
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        buttons.count
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
        cell.present(buttons[indexPath.row])
        
        return cell
    }
}
