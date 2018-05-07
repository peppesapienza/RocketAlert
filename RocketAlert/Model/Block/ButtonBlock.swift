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
        style: RocketElementStyle? = RocketElementStyle.button,
        id: String? = nil)
    {
        self.title = title
        self.tapHandler = tapHandler
        self.style = style
        self.id = id
    }
    
    public convenience init(title: String, tapHandler: TapRocketHandler) {
        self.init(title: title, tapHandler: tapHandler, style: .button, id: nil)
    }
    
    public convenience init(title: String, tapHandler: TapRocketHandler, style: RocketElementStyle) {
        self.init(title: title, tapHandler: tapHandler, style: style, id: nil)
    }
    
    public var id: String?
    public var tapHandler: TapRocketHandler?
    public var style: RocketElementStyle? = RocketElementStyle.button
    
    internal let title: String
    
}

