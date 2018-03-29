//
//  TwoButtonsRocketCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class DoubleButtonRocketCell: RocketCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.firstButton = UIButton.init(frame: .zero)
        self.secondButton = UIButton.init(frame: .zero)
        self.separatorView = UIView.init(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView.addSubview(self.firstButton)
        self.mainView.addSubview(self.secondButton)
        self.mainView.addSubview(self.separatorView)
        self.separatorView.backgroundColor = #colorLiteral(red: 0.9480613426, green: 0.9480613426, blue: 0.9480613426, alpha: 1)
        self.firstButton.addTarget(self,
                                   action: #selector(DoubleButtonRocketCell.handleTapOnFirstButton(_:)), for: .touchUpInside)
        self.secondButton.addTarget(self,
                                   action: #selector(DoubleButtonRocketCell.handleTapOnSecondButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let separatorView: UIView
    fileprivate let firstButton: UIButton
    fileprivate let secondButton: UIButton
    fileprivate var firstButtonAction: RocketAction?
    fileprivate var secondButtonAction: RocketAction?
    fileprivate var isTapOnButtonsEnabled: Bool = true
    
    override var currentBlock: RocketBlock? {
        didSet {
            guard let b = self.currentBlock as? DoubleButtonRocketBlock else { return }
            self.firstButton.setTitle(b.first.title, for: .normal)
            self.firstButton.setTitleColor(b.first.style.color, for: .normal)
            self.firstButton.titleLabel?.font = b.first.style.font
            self.firstButtonAction = b.first.action
            self.secondButton.setTitle(b.second.title, for: .normal)
            self.secondButton.setTitleColor(b.second.style.color, for: .normal)
            self.secondButton.titleLabel?.font = b.second.style.font
            self.secondButtonAction = b.second.action
            self.setNeedsUpdateConstraints()
        }
    }
    
    @objc func handleTapOnFirstButton(_ sender: UIButton) {
        guard self.isTapOnButtonsEnabled else { return }
        self.isTapOnButtonsEnabled = false
        self.firstButton.bounce(completionHandler: {
            self.notifyObserver(nextBlock: self.firstButtonAction?.next)
            self.firstButtonAction?.handler?()
        })
    }
    
    @objc func handleTapOnSecondButton(_ sender: UIButton) {
        guard self.isTapOnButtonsEnabled else { return }
        self.isTapOnButtonsEnabled = false
        self.secondButton.bounce(completionHandler: {
            self.notifyObserver(nextBlock: self.secondButtonAction?.next)
            self.secondButtonAction?.handler?()
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isTapOnButtonsEnabled = true
    }
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        self.firstButton.translatesAutoresizingMaskIntoConstraints = false
        self.secondButton.translatesAutoresizingMaskIntoConstraints = false
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setSizeConstraints() {
        super.setSizeConstraints()
        self.secondButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -10).isActive = true
        self.secondButton.widthAnchor.constraint(equalTo: self.mainView.widthAnchor, multiplier: 0.45).isActive = true
        self.firstButton.widthAnchor.constraint(equalTo: self.secondButton.widthAnchor, multiplier: 1).isActive = true
        self.firstButton.heightAnchor.constraint(equalTo: self.secondButton.heightAnchor, multiplier: 1).isActive = true
        self.separatorView.heightAnchor.constraint(equalTo: self.firstButton.heightAnchor, multiplier: 1).isActive = true
        self.separatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    override func setPositionConstraints() {
        super.setPositionConstraints()
        self.secondButton.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -10).isActive = true
        self.secondButton.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10).isActive = true
        self.firstButton.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 10).isActive = true
        self.firstButton.centerYAnchor.constraint(equalTo: self.secondButton.centerYAnchor).isActive = true
        self.separatorView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
        self.separatorView.centerYAnchor.constraint(equalTo: self.mainView.centerYAnchor).isActive = true
    }

}
