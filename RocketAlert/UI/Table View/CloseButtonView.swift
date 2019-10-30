//
//  CloseButtonView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 17/06/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class CloseButtonView: UIView {
    
    init(frame: CGRect, closeButton: RocketCloseButton) {
        self.midView = UIView.init(frame: .zero)
        self.button = UIButton.init(frame: .zero)
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setButtonStyle(closeButton)
        self.addSubview(self.midView)
        self.midView.addSubview(self.button)
        self.midView.backgroundColor = .white
        self.setAutoresizingMask()
        self.setShadow()
        self.setCornerRadius()
        self.button.addTarget(self, action: #selector(CloseButtonView.handle_touchUp), for: .touchUpInside)
    }
    
    fileprivate let midView: UIView
    let button: UIButton
    
    override func updateConstraints() {
        super.updateConstraints()
        setConstraints()
    }
    
    fileprivate func setCornerRadius() {
        midView.clipsToBounds = true
        midView.layer.masksToBounds = true
        midView.layer.cornerRadius = 6
    }
    
    fileprivate func setShadow() {
        layer.shadowColor = #colorLiteral(red: 0.8767361111, green: 0.8767361111, blue: 0.8767361111, alpha: 1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc fileprivate func handle_touchUp(_ sender: UIButton) {
        sender.bounce {
            NotificationCenter.default.post(name: .dismissRocketAlertEvent, object: nil)
        }
    }
    
    fileprivate func setButtonStyle(_ closeButton: RocketCloseButton) {
        button.titleLabel?.textAlignment = .center
        button.setTitle(closeButton.title, for: .normal)
        button.titleLabel?.font = closeButton.style.font
        button.setTitleColor(closeButton.style.color, for: .normal)
        button.backgroundColor = .clear
    }

}

extension CloseButtonView: RocketViewLayout {
    func setAutoresizingMask() {
        midView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        midView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        midView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        midView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        midView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalTo: midView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: midView.heightAnchor, multiplier: 1).isActive = true
        button.leftAnchor.constraint(equalTo: midView.leftAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: midView.centerYAnchor).isActive = true
    }
    
}
