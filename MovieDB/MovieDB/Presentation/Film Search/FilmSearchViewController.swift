//
//  FilmSearchViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class FilmSearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    var coordinator: FilmsTabCoordinator?

    private var filmSearchView = FilmSearchView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = filmSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}