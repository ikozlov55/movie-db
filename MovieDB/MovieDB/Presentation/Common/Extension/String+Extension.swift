//
//  String+Extension.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

extension String {
    
    var trim: Self {
        self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    
}
