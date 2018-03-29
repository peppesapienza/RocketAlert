//
//  RocketAction.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public struct RocketAction {
    public init(next: RocketBlock?, handler: (()->())?) {
        self.next = next
        self.handler = handler
    }

    internal let next: RocketBlock?
    internal let handler: (()->())?
}
