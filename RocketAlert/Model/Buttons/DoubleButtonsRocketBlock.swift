//
//  TwoButtonsRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 29/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class DoubleButtonsRocketBlock: ControlRocketBlock {
    
    public required init(first: ButtonRocketBlock, second: ButtonRocketBlock) {
        self.first = first
        self.second = second
    }
    
    let first: ButtonRocketBlock
    let second: ButtonRocketBlock
    
    public var child: RocketBlock?
}
