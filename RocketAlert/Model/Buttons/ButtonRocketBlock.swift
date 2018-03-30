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
        action: RocketAction,
        id: String? = nil,
        style: RocketElementStyle = RocketElementStyle.button)
    {
        self.title = title
        self.action = action
        self.id = id
        self.style = style
    }
    
    public var next: RocketBlock?
    public var id: String?
    
    internal let style: RocketElementStyle
    internal let title: String
    internal let action: RocketAction
}

