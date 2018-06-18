//
//  CloseButton.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 17/06/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public struct RocketCloseButton {
    public init(title: String, style: RocketFont) {
        self.title = title
        self.style = style
    }
    
    var title: String
    var style: RocketFont
}
