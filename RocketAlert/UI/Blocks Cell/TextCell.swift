//
//  RocketTextCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 10/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

class TextRocketCell: TapableRocketCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.label = UILabel.init(frame: .zero)
        self.label.numberOfLines = 0
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView.addSubview(self.label)
    }
    
    override var currentBlock: RocketBlock? {
        didSet {
            guard let b = currentBlock as? TextRocketBlock else { return }
            label.textColor = b.font?.color
            label.font = b.font?.font
            label.text = b.text
            if (!b.isNextShowed) {
                showNextAfter(seconds: b.showNextAfter)
                b.isNextShowed = true
            }
            setNeedsUpdateConstraints()
        }
    }
    
    internal let label: UILabel
    
    internal func showNextAfter(seconds: TimeInterval?) {
        guard let t = seconds, t > 0.0 else {
            isTapEnabled = true
            return
        }
        
        isTapEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + t) {
            self.tapAction()
        }
    }
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setConstraints() {
        super.setConstraints()
        label.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16).isActive = true
        label.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12).isActive = true
        label.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
