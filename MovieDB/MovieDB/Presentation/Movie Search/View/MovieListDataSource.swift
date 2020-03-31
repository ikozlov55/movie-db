//
//  MovieListDataSource.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class MovieListDataSource: NSObject, UICollectionViewDataSource {

    // MARK: - Public Properties
    
    var data = [MovieVM]()
    let imagesService = ServiceLayer.imagesService
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCell.identifier,
            for: indexPath
            ) as? MovieListCell
            else { return UICollectionViewCell() }
        let movieVM = data[indexPath.row]
        cell.reset()
        if let posterUtl = movieVM.posterUrl {
            cell.progress = imagesService.load(posterUtl) { result in
                switch result {
                case .success(let image):
                    cell.posterView.image = image
                case .failure:
                    return
                }
            }
        }
        cell.present(movieVM)
        return cell
    }
}
