//
//  TextRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 23/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class TextRocketBlock: RocketBlock {
    
    public init(text: String) {
        self.text = text
        self.style = RocketElementStyle.text
    }
    
    public init(text: String, next: RocketBlock, style: RocketElementStyle = RocketElementStyle.text) {
        self.text = text
        self.child = next
        self.style = style
    }
    
    public var child: RocketBlock?
    internal let text: String
    internal let style: RocketElementStyle
    
    public func add(child block: RocketBlock) {
        self.child = block
    }
}
