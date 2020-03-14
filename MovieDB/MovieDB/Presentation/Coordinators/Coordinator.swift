//
//  Coordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: BaseNavigationController { get }
    func start()
}
