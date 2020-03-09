//
//  SubtitleLabel.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class SubtitleLabel: MDBLabel {

    // MARK: - Init
    
    init(_ text: String = "") {
        let color = ColorName.lightBlue.color
        super.init(size: 16, weight: .regular, color: color, text: text)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
