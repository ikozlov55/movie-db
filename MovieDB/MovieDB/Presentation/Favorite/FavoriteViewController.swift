//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class FavoriteViewController: BaseViewController {

    // MARK: - Properties
    
    var coordinator: FavoriteTabCoordinator?
    
    private var favoriteView = FavoriteView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = favoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
