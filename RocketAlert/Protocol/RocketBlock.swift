//
//  RocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 01/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

public protocol RocketBlock {
    var id: String? { get set }
    var next: RocketBlock? { get set }
    var hasChild: Bool { get }
}

extension RocketBlock {
    public var hasChild: Bool {
        guard
            let _ = self.next
        else { return false }
        
        return true
    }
}

protocol ControlRocketBlock: RocketBlock {
    
}
