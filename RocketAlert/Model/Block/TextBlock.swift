//
//  TextRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 23/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class TextRocketBlock: TappableRocketBlock {
    
    public init(text: String, next: RocketBlock) {
        self.text = text
        self.next = next
        self.style = RocketElementStyle.text
    }
    
    public init(
        text: String,
        next: RocketBlock? = nil,
        id: String? = nil,
        style: RocketElementStyle = .text)
    {
        self.text = text
        self.next = next
        self.id = id
        self.style = style
    }
    
    public var next: RocketBlock?
    public var id: String?
    public var style: RocketElementStyle? = .text
    
    internal let text: String
    
    public func add(next block: RocketBlock) {
        self.next = block
    }
    
}


