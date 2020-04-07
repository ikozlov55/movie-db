//
//  EmptySearchResultsViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `ViewController` заглушка для отображения пустого результата поиска
final class EmptySearchResultsViewController: BaseViewController {

    // MARK: - Private Properties
    
    private var emptySearchResultsView = EmptySearchResultsView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = emptySearchResultsView
    }

}
