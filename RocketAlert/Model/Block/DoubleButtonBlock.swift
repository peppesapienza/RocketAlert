//
//  TwoButtonsRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 29/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class DoubleButtonRocketBlock: ControlRocketBlock {
    
    public required init(
        left: ButtonRocketBlock,
        right: ButtonRocketBlock,
        id: String? = nil)
    {
        self.left = left
        self.right = right
        self.id = id
    }
    
    let left: ButtonRocketBlock
    let right: ButtonRocketBlock
    
    public var id: String?
}
