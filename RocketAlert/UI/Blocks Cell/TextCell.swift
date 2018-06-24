//
//  RocketTextCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 10/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

class TextRocketCell: TapableRocketCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.label = UILabel.init(frame: .zero)
        self.label.numberOfLines = 0
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView.addSubview(self.label)
    }
    
    override var currentBlock: RocketBlock? {
        didSet {
            guard let b = currentBlock as? TextRocketBlock else { return }
            self.label.textColor = b.font?.color
            self.label.font = b.font?.font
            self.label.text = b.text
            if (!b.isNextShowed) {
                self.showNextAfter(seconds: b.showNextAfter)
                b.isNextShowed = true
            }
            self.setNeedsUpdateConstraints()
        }
    }
    
    internal let label: UILabel
    
    internal func showNextAfter(seconds: TimeInterval?) {
        guard let t = seconds, t > 0.0 else {
            self.isTapEnabled = true
            return
        }
        
        self.isTapEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + t) {
            self.tapAction()
        }
    }
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        self.label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setConstraints() {
        super.setConstraints()
        self.label.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 16).isActive = true
        self.label.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -12).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
