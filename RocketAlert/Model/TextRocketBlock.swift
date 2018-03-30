//
//  TextRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 23/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class TextRocketBlock: RocketBlock {
    
    public init(
        text: String,
        next: RocketBlock? = nil,
        id: String? = nil,
        style: RocketElementStyle = RocketElementStyle.text)
    {
        self.text = text
        self.next = next
        self.id = id
        self.style = style
    }
    
    public var next: RocketBlock?
    public var id: String?
    
    internal let text: String
    internal let style: RocketElementStyle
    
    public func add(child block: RocketBlock) {
        self.next = block
    }
}
