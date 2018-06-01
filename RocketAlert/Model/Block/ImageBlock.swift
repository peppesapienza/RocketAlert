//
//  ImageBlock.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 01/06/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

public class ImageRocketBlock: TextRocketBlock {
    
    public init(image: UIImage, text: String?, next: RocketBlock?, showNextAfter: TimeInterval?, id: String?) {
        self.image = image
        super.init(text: text ?? "", next: next, showNextAfter: showNextAfter, id: id, font: .text)
    }
    
    public var imageStyle: RocketImageStyle = .round
    
    internal let image: UIImage

}
