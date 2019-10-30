//
//  RocketTextCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 03/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit


class RocketCell: UITableViewCell, RocketViewLayout {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
            dismissRocketAlert()
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
        setCornerRadius()
        setShadow()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setConstraints()
    }
    
    func setAutoresizingMask() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        self.setMainViewConstraints()
    }
    
    internal func setMainViewConstraints() {
        shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        shadowView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        shadowView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        mainView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 0).isActive = true
        mainView.rightAnchor.constraint(equalTo: shadowView.rightAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 0).isActive = true
        mainView.leftAnchor.constraint(equalTo: shadowView.leftAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setCornerRadius() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
        mainView.clipsToBounds = true
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 6
    }
        
    fileprivate func setShadow() {
        shadowView.layer.shadowColor = #colorLiteral(red: 0.8767361111, green: 0.8767361111, blue: 0.8767361111, alpha: 1)
        shadowView.layer.shadowRadius = 6
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize.zero
    }
    
    fileprivate func setStyle() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        shadowView.backgroundColor = .clear
        mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

