//
//  ProfileTabCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class ProfileTabCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var nc: BaseNavigationController
    
    // MARK: - Init
    
    init(_ nc: BaseNavigationController) {
        self.nc = nc
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let vc = ProfileViewController()
        vc.coordinator = self
        let tabBarItem = UITabBarItem(
            title: L10n.profileTabTitle,
            image: Asset.tabBarProfile.image,
            tag: 2
        )
        vc.tabBarItem = tabBarItem
        nc.pushViewController(vc, animated: false)
    }

}
