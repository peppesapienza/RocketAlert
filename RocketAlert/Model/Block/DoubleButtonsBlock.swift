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
        first: ButtonRocketBlock,
        second: ButtonRocketBlock,
        id: String? = nil)
    {
        self.first = first
        self.second = second
        self.id = id
    }
    
    let first: ButtonRocketBlock
    let second: ButtonRocketBlock
    
    public var next: RocketBlock?
    public var id: String?
}
