//
//  RocketAuthor.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

public enum RocketAuthorStyle {
    case round
    case circular
    case square
}

/// The Rocket Author
public struct RocketAuthor {
    /**
     /// Inizializes and returns a newly Rocket Author object
     
     - parameters:
        - image: the author's image
        - style: the style of the image's view
     
     - Important:
    if you don't define a style, the .circular will be used
     */
    public init(image: UIImage, style: RocketAuthorStyle = .circular) {
        self.image = image
        self.style = style
    }
    
    let image: UIImage
    let style: RocketAuthorStyle
}
