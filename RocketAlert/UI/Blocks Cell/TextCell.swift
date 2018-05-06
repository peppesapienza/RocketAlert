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
            self.label.textColor = b.style.color
            self.label.font = b.style.font
            self.label.text = b.text
            self.setNeedsUpdateConstraints()
        }
    }
    
    fileprivate let label: UILabel
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        self.label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setSizeConstraints() {
        super.setSizeConstraints()
        self.label.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -12).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -16).isActive = true
    }
    
    override func setPositionConstraints() {
        super.setPositionConstraints()
        self.label.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 16).isActive = true
        self.label.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

