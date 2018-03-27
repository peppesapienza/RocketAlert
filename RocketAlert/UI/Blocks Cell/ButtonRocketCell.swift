//
//  ButtonTableViewCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 23/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class ButtonRocketCell: RocketCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.button = UIButton.init(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView.addSubview(self.button)
        self.button.addTarget(self, action: #selector(ButtonRocketCell.handleTapOnButton), for: .touchDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let button: UIButton
    var tapOnButton = true
    
    var titleButton: String? {
        didSet {
            self.button.setTitle(self.titleButton, for: .normal)
        }
    }
    
    var style: RocketElementStyle? {
        didSet {
            self.button.setTitleColor(style?.color, for: .normal)
            self.button.titleLabel?.font = style?.font
        }
    }
    
    var onClickEvent: (() -> ())?
    
    @objc func handleTapOnButton(_ sender: UIButton) {
        guard self.tapOnButton else { return }
        self.animateOnTap(completion: {
            self.notifyObserverWithNextBlock()
            self.tapOnButton = false
            self.onClickEvent?()
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.tapOnButton = true
    }
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        self.button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setSizeConstraints() {
        super.setSizeConstraints()
        self.button.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -10).isActive = true
        self.button.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -10).isActive = true
    }
    
    override func setPositionConstraints() {
        super.setPositionConstraints()
        self.button.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 10).isActive = true
        self.button.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10).isActive = true
    }
    
}
