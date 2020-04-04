//
//  MovieListDataSource.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `DataSource` для отображения результатов поиска фильмов
final class MovieListDataSource: NSObject, UICollectionViewDataSource {

    // MARK: - Public Properties
    
    var movieViewModels = [MovieViewModel]()
    let imagesService = ServiceLayer.imagesService
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieViewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCell.identifier,
            for: indexPath
            ) as? MovieListCell
            else { return UICollectionViewCell() }
        let viewModel = movieViewModels[indexPath.row]
        cell.reset()
        if let posterUtl = viewModel.posterUrl {
            cell.progress = imagesService.load(posterUtl) { result in
                switch result {
                case .success(let image):
                    cell.setPoster(image)
                case .failure:
                    return
                }
            }
        }
        cell.present(viewModel)
        return cell
    }
}
