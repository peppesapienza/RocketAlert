//
//  RocketLayoutCreator.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 02/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

struct TopViewFinder {
    init(in vc: UIViewController?) throws {
        guard let vc = vc else {
            throw TopViewFinderError.cantFindRootViewController
        }
        
        self.view = vc.view
    }
    
    let view: UIView
}

enum TopViewFinderError: Error {
    case cantFindRootViewController
}

extension TopViewFinderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cantFindRootViewController: return "😵 [Rocket] I can't find the UIApplication.keyWindow.rootViewController"
        }
    }
}


