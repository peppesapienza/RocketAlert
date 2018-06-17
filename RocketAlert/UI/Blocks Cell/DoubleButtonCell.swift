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
                                   action: #selector(DoubleButtonRocketCell.handle_tapOnFirstButton(_:)), for: .touchUpInside)
        self.secondButton.addTarget(self,
                                   action: #selector(DoubleButtonRocketCell.handle_tapOnSecondButton(_:)), for: .touchUpInside)
    }
    
    override var currentBlock: RocketBlock? {
        didSet {
            guard let b = self.currentBlock as? DoubleButtonRocketBlock else { return }
            self.firstButton.setTitle(b.left.title, for: .normal)
            self.firstButton.setTitleColor(b.left.font?.color, for: .normal)
            self.firstButton.titleLabel?.font = b.left.font?.font
            self.tapFirstButtonHandler = b.left.tapHandler
            self.secondButton.setTitle(b.right.title, for: .normal)
            self.secondButton.setTitleColor(b.right.font?.color, for: .normal)
            self.secondButton.titleLabel?.font = b.right.font?.font
            self.tapSecondButtonHandler = b.right.tapHandler
            self.setNeedsUpdateConstraints()
        }
    }
    
    fileprivate let separatorView: UIView
    fileprivate let firstButton: UIButton
    fileprivate let secondButton: UIButton
    fileprivate var tapFirstButtonHandler: TapRocketHandler?
    fileprivate var tapSecondButtonHandler: TapRocketHandler?
    fileprivate var isTapOnButtonsEnabled: Bool = true
    
    @objc
    fileprivate func handle_tapOnFirstButton(_ sender: UIButton) {
        guard self.isTapOnButtonsEnabled else { return }
        self.isTapOnButtonsEnabled = false
        self.firstButton.bounce(completionHandler: {
            self.show(next: self.tapFirstButtonHandler?.next)
        })
        self.tapFirstButtonHandler?.action?()
    }
    
    @objc
    fileprivate func handle_tapOnSecondButton(_ sender: UIButton) {
        guard self.isTapOnButtonsEnabled else { return }
        self.isTapOnButtonsEnabled = false
        self.secondButton.bounce(completionHandler: {
            self.show(next: self.tapSecondButtonHandler?.next)
        })
        self.tapSecondButtonHandler?.action?()
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

    
    override func setConstraints() {
        super.setConstraints()
        self.firstButton.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 10).isActive = true
        self.firstButton.centerYAnchor.constraint(equalTo: self.secondButton.centerYAnchor).isActive = true
        self.firstButton.widthAnchor.constraint(equalTo: self.secondButton.widthAnchor, multiplier: 1).isActive = true
        self.firstButton.heightAnchor.constraint(equalTo: self.secondButton.heightAnchor, multiplier: 1).isActive = true
        
        self.secondButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -10).isActive = true
        self.secondButton.widthAnchor.constraint(equalTo: self.mainView.widthAnchor, multiplier: 0.45).isActive = true
        self.secondButton.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -10).isActive = true
        self.secondButton.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10).isActive = true
        
        self.separatorView.heightAnchor.constraint(equalTo: self.firstButton.heightAnchor, multiplier: 1).isActive = true
        self.separatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        self.separatorView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
        self.separatorView.centerYAnchor.constraint(equalTo: self.mainView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
