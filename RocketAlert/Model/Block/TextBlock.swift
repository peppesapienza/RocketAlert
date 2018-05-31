//
//  TextRocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 23/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class TextRocketBlock: TappableRocketBlock {
    
    public init(text: String, next: RocketBlock, showNextAfter: TimeInterval? = nil) {
        self.text = text
        self.next = next
        self.style = RocketElementStyle.text
        self.showNextAfter = showNextAfter
    }
    
    public convenience init(text: String, showNextAfter: TimeInterval) {
        self.init(text: text, next: nil, showNextAfter: showNextAfter, id: nil, style: .text)
    }
    
    public init(
        text: String,
        next: RocketBlock? = nil,
        showNextAfter: TimeInterval? = nil,
        id: String? = nil,
        style: RocketElementStyle = .text)
    {
        self.text = text
        self.next = next
        self.showNextAfter = showNextAfter
        self.id = id
        self.style = style
    }
    
    public var next: RocketBlock?
    
    /**
     Automatically show the next attached Block after an amount of time.
     - Important:
        The default value is *nil*. Pass a *value* will disable the *TapGestureRecognizer* and will show automatically the next attached block or will close the RocketAlert if the next block is not defined
    */
    public var showNextAfter: TimeInterval?
    public var id: String?
    public var style: RocketElementStyle? = .text
    
    internal let text: String
    
    public func add(next block: RocketBlock) {
        self.next = block
    }
    
}


