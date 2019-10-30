//
//  TwoButtonsRocketCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 28/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class DoubleButtonRocketCell: RocketCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
            guard let b = currentBlock as? DoubleButtonRocketBlock else { return }
            firstButton.setTitle(b.left.title, for: .normal)
            firstButton.setTitleColor(b.left.font?.color, for: .normal)
            firstButton.titleLabel?.font = b.left.font?.font
            tapFirstButtonHandler = b.left.tapHandler
            secondButton.setTitle(b.right.title, for: .normal)
            secondButton.setTitleColor(b.right.font?.color, for: .normal)
            secondButton.titleLabel?.font = b.right.font?.font
            tapSecondButtonHandler = b.right.tapHandler
            setNeedsUpdateConstraints()
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
        guard isTapOnButtonsEnabled else { return }
        isTapOnButtonsEnabled = false
        firstButton.bounce(completionHandler: {
            self.show(next: self.tapFirstButtonHandler?.next)
        })
        tapFirstButtonHandler?.action?()
    }
    
    @objc
    fileprivate func handle_tapOnSecondButton(_ sender: UIButton) {
        guard self.isTapOnButtonsEnabled else { return }
        isTapOnButtonsEnabled = false
        secondButton.bounce(completionHandler: {
            self.show(next: self.tapSecondButtonHandler?.next)
        })
        tapSecondButtonHandler?.action?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isTapOnButtonsEnabled = true
    }
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
    }

    
    override func setConstraints() {
        super.setConstraints()
        firstButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        firstButton.centerYAnchor.constraint(equalTo: secondButton.centerYAnchor).isActive = true
        firstButton.widthAnchor.constraint(equalTo: secondButton.widthAnchor, multiplier: 1).isActive = true
        firstButton.heightAnchor.constraint(equalTo: secondButton.heightAnchor, multiplier: 1).isActive = true
        
        secondButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
        secondButton.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.45).isActive = true
        secondButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        secondButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        
        separatorView.heightAnchor.constraint(equalTo: firstButton.heightAnchor, multiplier: 1).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        separatorView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
