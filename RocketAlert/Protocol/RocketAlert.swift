//
//  Rocket.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 01/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public protocol RocketAlert {
    init(author: RocketAuthor, block: RocketBlock)
    func show()
    func dismiss()
}

