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
        style: RocketElementStyle = RocketElementStyle.Button)
    {
        self.style = style
        self.title = title
        self.action = action.handler
        self.child = action.next
    }
    
    internal let style: RocketElementStyle
    internal let title: String
    internal let action: (() -> ())?
    public var child: RocketBlock?
}
