//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Модель фильма для отображаения в ячейке
struct MovieViewModel {
    
    //Идентификатор сущности
    let id: Int
    
    /// Локализованное название
    let title: String
    
    /// Оригинальное название и год выхода
    let subtitle: String
    
    /// Жанры фильма через запятую
    let genres: String
    
    /// Количество голосов/лайков
    let voteCount: String
    
    /// Рейтинг фильма от 0 до 10
    let rating: String
    
    /// Адрес файла с постером
    let posterUrl: URL?
    
    /// Описание
    let overview: String
    
}
