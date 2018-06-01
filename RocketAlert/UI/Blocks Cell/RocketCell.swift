//
//  RocketTextCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 03/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit


class RocketCell: UITableViewCell, RocketViewLayout {
        
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.mainView = UIView.init(frame: .zero)
        self.shadowView = UIView.init(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.shadowView)
        self.shadowView.addSubview(self.mainView)
        self.setStyle()
        self.setAutoresizingMask()
    }
    
    var currentBlock: RocketBlock?
    let mainView: UIView
    fileprivate let shadowView: UIView
    
    func show(next: RocketBlock?) {
        guard let nextBlock = next else {
            self.dismissRocketAlert()
            return
        }
        
        NotificationCenter.default.post(name: .showNextBlockEvent, object: nil, userInfo: [
            "block" : nextBlock
        ])
    }
    
    func dismissRocketAlert() {
        NotificationCenter.default.post(name: .dismissRocketAlertEvent, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCornerRadius()
        self.setShadow()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        self.setConstraints()
    }
    
    func setAutoresizingMask() {
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        self.shadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.shadowView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        self.shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.shadowView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        
        self.mainView.bottomAnchor.constraint(equalTo: self.shadowView.bottomAnchor, constant: 0).isActive = true
        self.mainView.rightAnchor.constraint(equalTo: self.shadowView.rightAnchor, constant: 0).isActive = true
        self.mainView.topAnchor.constraint(equalTo: self.shadowView.topAnchor, constant: 0).isActive = true
        self.mainView.leftAnchor.constraint(equalTo: self.shadowView.leftAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setCornerRadius() {
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 6
        self.mainView.clipsToBounds = true
        self.mainView.layer.masksToBounds = true
        self.mainView.layer.cornerRadius = 6
    }
        
    fileprivate func setShadow() {
        self.shadowView.layer.shadowColor = #colorLiteral(red: 0.8767361111, green: 0.8767361111, blue: 0.8767361111, alpha: 1)
        self.shadowView.layer.shadowRadius = 6
        self.shadowView.layer.shadowOpacity = 1
        self.shadowView.layer.shadowOffset = CGSize.zero
    }
    
    fileprivate func setStyle() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.shadowView.backgroundColor = .clear
        self.mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

