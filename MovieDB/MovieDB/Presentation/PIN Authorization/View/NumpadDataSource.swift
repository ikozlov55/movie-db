//
//  NumpadDataSource.swift
//  MovieDB
//
//  Created by Илья Козлов on 07.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class NumpadDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NumpadButtonCell.identifier,
            for: indexPath) as? NumpadButtonCell
            else {
                return UICollectionViewCell()
        }
        return cell
    }
}
