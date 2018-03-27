//
//  ButtonRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 25/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class ButtonRocketBlock: ControlRocketBlock {
    
    public required init(title: String, onComplete: (nextBlock: RocketBlock?, operation: () -> ()), style: RocketElementStyle = RocketElementStyle.Button) {
        self.style = style
        self.title = title
        self.onClickEvent = onComplete.operation
        self.child = onComplete.nextBlock
    }
    
    internal let style: RocketElementStyle
    internal let title: String
    internal let onClickEvent: () -> ()
    public var child: RocketBlock?
}
