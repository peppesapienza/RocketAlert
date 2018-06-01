//
//  ButtonRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 25/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class ButtonRocketBlock: ControlRocketBlock {
    
    public init(
        title: String,
        tapHandler: TapRocketHandler? = nil,
        font: RocketFont? = RocketFont.button,
        id: String? = nil)
    {
        self.title = title
        self.tapHandler = tapHandler
        self.font = font
        self.id = id
    }
    
    public convenience init(title: String, tapHandler: TapRocketHandler) {
        self.init(title: title, tapHandler: tapHandler, font: .button, id: nil)
    }
    
    public convenience init(title: String, tapHandler: TapRocketHandler, font: RocketFont) {
        self.init(title: title, tapHandler: tapHandler, font: font, id: nil)
    }
    
    public var id: String?
    public var tapHandler: TapRocketHandler?
    public var font: RocketFont? = RocketFont.button
    
    internal let title: String
    
}

