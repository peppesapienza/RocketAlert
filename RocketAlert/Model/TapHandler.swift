//
//  RocketAction.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public struct TapRocketHandler {
    public init(next: RocketBlock?, action: (()->())?) {
        self.next = next
        self.action = action
    }

    internal let next: RocketBlock?
    internal let action: (()->())?
    
    
}

public struct InputRocketHandler<T> {
    public init(action: ((T)->(RocketBlock?))?) {
        self.action = action
    }
    
    internal let action: ((_ text: T)->(RocketBlock?))?
}
