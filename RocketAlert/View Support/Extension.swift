//
//  Extension.swift
//  iSpazio.net
//
//  Created by Giuseppe Sapienza on 14/11/16.
//  Copyright © 2016 xCoding.it. All rights reserved.
//

import UIKit

extension String {
    
    public var htmlDecoded: String {
        
        guard let encodedData = self.data(using: String.Encoding.unicode) else {
            return ""
        }
        
        do {
            let attributed = try NSAttributedString.init(data: encodedData, options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.unicode.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            
        }
        
        return ""
        
    }
}


extension UITableView {
    public func addRow(at: Int, with: UITableViewRowAnimation = .automatic) {
        self.beginUpdates()
        self.insertRows(at: [IndexPath.init(row: at-1, section: 0)], with: with)
        self.endUpdates()
    }
}

extension UIView {
    public func clickAnimated(completionHandler: (()->())? = nil, duration: Double = 0.5) {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut], animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (bool) in
            UIView.animate(withDuration: duration,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 15,
                           options: .curveLinear,
                           animations:
            {
                self.transform = CGAffineTransform.identity
            }, completion: {bool in
                completionHandler?()
            })
        }
        
    }
    
    public func fadeIn() {
        self.alpha = 0
        UIViewPropertyAnimator.init(duration: 0.3, curve: .easeInOut) {
            self.alpha = 1
        }.startAnimation()
    }
    
    public func bounce() {
        self.transform = CGAffineTransform.init(scaleX: 0.6, y: 0.6)
        let animator = UIViewPropertyAnimator.init(duration: 0.3, curve: .easeInOut) {
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }
        animator.addCompletion { (_) in
            UIViewPropertyAnimator.init(duration: 0.3, curve: .easeInOut, animations: {
                self.transform = CGAffineTransform.identity
            }).startAnimation()
        }
        
        animator.startAnimation()
    }
}


extension UIColor {
    public convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}


