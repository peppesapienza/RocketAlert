//
//  RocketElementStyle.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 23/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//
import Foundation

public struct RocketElementStyle {
    public static var text = RocketElementStyle.init(font: UIFont.systemFont(ofSize: 18, weight: .regular), color: #colorLiteral(red: 0.1621472239, green: 0.2301641703, blue: 0.3008684814, alpha: 1))
    public static var button = RocketElementStyle.init(font: UIFont.systemFont(ofSize: 20, weight: .black), color: #colorLiteral(red: 0.1902082911, green: 0.6098146351, blue: 0.968627451, alpha: 1))
    public static var lightButton = RocketElementStyle.init(font: UIFont.systemFont(ofSize: 18, weight: .regular), color: #colorLiteral(red: 0.1902082911, green: 0.6098146351, blue: 0.968627451, alpha: 1))
    public static var cancel = RocketElementStyle.init(font: UIFont.systemFont(ofSize: 20, weight: .semibold), color: #colorLiteral(red: 0.9267585874, green: 0.367726624, blue: 0.3804723024, alpha: 1))
    public static var emoji = RocketElementStyle.init(font: UIFont.systemFont(ofSize: 25, weight: .black), color: #colorLiteral(red: 0.9267585874, green: 0.367726624, blue: 0.3804723024, alpha: 1))
    
    public var color: UIColor
    public var font: UIFont
    
    public init() {
        self.color = UIColor.black
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    public init(font: UIFont, color: UIColor) {
        self.font = font
        self.color = color
    }
}

