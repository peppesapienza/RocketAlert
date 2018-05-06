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
        tapHandler: TapRocketHandler,
        id: String? = nil,
        style: RocketElementStyle = RocketElementStyle.button)
    {
        self.title = title
        self.handler = tapHandler
        self.id = id
        self.style = style
    }
    
    public var id: String?
    
    internal let style: RocketElementStyle
    internal let title: String
    internal let handler: TapRocketHandler
}

