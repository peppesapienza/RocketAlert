//
//  RocketAnimatable.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

protocol RocketAnimatable {
    func prepareAnimation()
    func openAnimation(completionHandler: (()->())?)
    func closeAnimation(completionHandler: (()->())?)
}
