//
//  LoginCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var nc: BaseNavigationController
    
    // MARK: - Init
    
    init(_ nc: BaseNavigationController) {
        self.nc = nc
        self.nc.isNavigationBarHidden = true
    }
    
    // MARK: - Navigation methods
    
    func start() {
        print("LoginCoordinator")
    }
}
