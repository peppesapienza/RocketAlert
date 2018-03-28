//
//  RocketAuthor.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

public enum RocketAuthorStyle {
    case normal
}

public struct RocketAuthor {
    public init(image: UIImage, style: RocketAuthorStyle = .normal) {
        self.image = image
        self.style = style
    }
    
    let image: UIImage
    let style: RocketAuthorStyle
}
