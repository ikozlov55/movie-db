//
//  MovieViewModelTranfsormer.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Статический класс для преобразования бизнес объектов фильмов в модели слоя представления
final class MovieViewModelTransformer {
    
    // MARK: - Private Properties
    static let calendar = Calendar.current
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
    
    // MARK: - Public methods
    
    /// Преобразование модели объекта `Movie` в модель  представления `MovieViewModel`
    /// - Parameter model: бизнес объект `Movie`
    static func viewModel(from model: Movie) -> MovieViewModel {
        var subtitle = model.originalTitle
        
        if let releaseDate = model.releaseDate {
            let components = calendar.dateComponents([.year], from: releaseDate)
            if let releaseYear = components.year {
                subtitle += " (\(String(describing: releaseYear)))"
            }
        }
        return MovieViewModel(
            title: model.title,
            subtitle: subtitle,
            genres: GenresDict.stringFrom(model.genres),
            voteCount: numberFormatter.string(for: model.voteCount) ?? "",
            rating: String(model.voteAverage),
            posterUrl: model.posterUrl,
            
            overview: model.overview
        )
    }
}
