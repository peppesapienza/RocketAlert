//
//  RocketViewLayout.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

protocol RocketSubView {
    var container: RocketContainerView! { get }
}

protocol RocketViewLayout {
    func setAutoresizingMask()
    func setConstraints()
}
