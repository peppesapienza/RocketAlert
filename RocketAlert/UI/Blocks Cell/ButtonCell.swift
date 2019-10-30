//
//  ButtonTableViewCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 23/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class ButtonRocketCell: RocketCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.button = UIButton.init(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView.addSubview(self.button)
        self.button.addTarget(self, action: #selector(ButtonRocketCell.handle_tapOnButton), for: .touchDown)
    }
    
    override var currentBlock: RocketBlock? {
        didSet {
            guard let b = currentBlock as? ButtonRocketBlock else { return }
            button.setTitle(b.title, for: .normal)
            tapHandler = b.tapHandler
            button.setTitleColor(b.font?.color, for: .normal)
            button.titleLabel?.font = b.font?.font
            setNeedsUpdateConstraints()
        }
    }
    
    fileprivate let button: UIButton
    fileprivate var isTapOnButtonEnabled = true
    fileprivate var tapHandler: TapRocketHandler?
    
    @objc
    fileprivate func handle_tapOnButton(_ sender: UIButton) {
        guard isTapOnButtonEnabled else { return }
        isTapOnButtonEnabled = false
        mainView.smoothBounce(completionHandler: {
            self.show(next: self.tapHandler?.next)
        })
        tapHandler?.action?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isTapOnButtonEnabled = true
    }
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setConstraints() {
        super.setConstraints()
        button.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        button.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
        button.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
