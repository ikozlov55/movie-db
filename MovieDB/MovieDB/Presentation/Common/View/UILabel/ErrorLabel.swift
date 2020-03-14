//
//  ErrorLabel.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class ErrorLabel: BaseLabel {

    // MARK: - Init
    
    init(_ text: String = "") {
        let color = ColorName.red.color
        super.init(size: 16, weight: .regular, color: color, text: text)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
