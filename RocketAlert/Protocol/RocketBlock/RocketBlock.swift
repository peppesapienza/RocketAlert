//
//  RocketBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 01/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit


public protocol RocketBlock {
    var child: RocketBlock? { get set }
    var hasChild: Bool { get }
}

extension RocketBlock {
    public var hasChild: Bool {
        guard
            let _ = self.child
        else { return false }
        
        return true
    }
}

protocol ControlRocketBlock: RocketBlock {
    
}
