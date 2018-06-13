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
    
    public convenience init(image: UIImage, text: String?) {
        self.init(image: image, text: text, next: nil, showNextAfter: nil, id: nil)
    }
    
    public var paddingLeft: CGFloat = 0
    public var paddingRight: CGFloat = 0
    public var imageStyle: RocketImageStyle = .square
    
    internal let image: UIImage

}
