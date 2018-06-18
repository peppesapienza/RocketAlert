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
        self.setConstraints()
    }
    
    fileprivate func setCornerRadius() {
        self.midView.clipsToBounds = true
        self.midView.layer.masksToBounds = true
        self.midView.layer.cornerRadius = 6
    }
    
    fileprivate func setShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0.8767361111, green: 0.8767361111, blue: 0.8767361111, alpha: 1)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
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
        self.button.titleLabel?.textAlignment = .center
        self.button.setTitle(closeButton.title, for: .normal)
        self.button.titleLabel?.font = closeButton.style.font
        self.button.setTitleColor(closeButton.style.color, for: .normal)
        self.button.backgroundColor = .clear
    }

}

extension CloseButtonView: RocketViewLayout {
    func setAutoresizingMask() {
        self.midView.translatesAutoresizingMaskIntoConstraints = false
        self.button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        self.midView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.midView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.midView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.midView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.button.widthAnchor.constraint(equalTo: self.midView.widthAnchor).isActive = true
        self.button.heightAnchor.constraint(equalTo: self.midView.heightAnchor, multiplier: 1).isActive = true
        self.button.leftAnchor.constraint(equalTo: self.midView.leftAnchor).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.midView.centerYAnchor).isActive = true
    }
    
}
