//
//  RocketAuthor.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

public enum RocketImageStyle {
    case round
    case circular
    case square
    
    internal func cornerRadius(for view: UIView) -> CGFloat {
        switch self {
        case .circular: return view.frame.height/2
        case .round: return 6
        case .square: return 0
        }
    }
}

/// The Rocket Author
public struct RocketAuthor {
    /**
     /// Inizializes and returns a newly Rocket Author object
     
     - parameters:
        - image: the author's image
        - style: the style of the image's view
     
     - Important:
    if you don't provide a style then the .circular will be used
     */
    public init(image: UIImage, style: RocketImageStyle = .circular) {
        self.image = image
        self.style = style
    }
    
    let image: UIImage
    let style: RocketImageStyle
}
