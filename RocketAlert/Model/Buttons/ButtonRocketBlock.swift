//
//  ButtonRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 25/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class ButtonRocketBlock: ControlRocketBlock {
    
    public required init(
        title: String,
        action: RocketAction,
        style: RocketElementStyle = RocketElementStyle.button)
    {
        self.style = style
        self.title = title
        self.action = action
    }
    
    internal let style: RocketElementStyle
    internal let title: String
    internal let action: RocketAction
    public var child: RocketBlock?
}

