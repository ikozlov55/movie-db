//
//  DarkDescriptionLabel.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class DarkDescriptionLabel: BaseLabel {

    // MARK: - Init
    
    init(_ text: String = "") {
        let color = ColorName.gray.color
        super.init(size: 12, weight: .medium, color: color, text: text)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
