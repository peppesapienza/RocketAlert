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
    var cellIdentifier: String { get }
}

extension RocketBlock {
    public var cellIdentifier: String {
        return String.init(describing: type(of: self))
    }
}


protocol TappableRocketBlock: RocketBlock {
    var next: RocketBlock? { get set }
}

extension TappableRocketBlock {
    public var hasChild: Bool {
        guard
            let _ = self.next
            else { return false }
        
        return true
    }
}

protocol ControlRocketBlock: RocketBlock {
    
}

protocol InputRocketBlock: RocketBlock {
    associatedtype InputType
    var handler: InputRocketHandler<InputType> { get }
}
