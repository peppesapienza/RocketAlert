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
        self.tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RocketCell.handleTap(_:)))
        self.mainView.addGestureRecognizer(self.tapGestureRecognizer)
        self.setStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let shadowView: UIView
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer!
    let mainView: UIView
    var block: RocketBlock?
    var tapOnCell = true
    
    @objc
    fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        guard self.tapOnCell else { return }
        self.animateOnTap(completion: {
            self.notifyObserverWithNextBlock()
            self.tapOnCell = false
        })
    }
    
    func animateOnTap(completion: @escaping () -> ()) {
        let firstAnimator = UIViewPropertyAnimator.init(
        duration: 0.15,
        curve: .easeInOut)
        {
            self.mainView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        }
        
        firstAnimator.addCompletion { (_) in
            let secondAnimator = UIViewPropertyAnimator.init(
                duration: 0.15,
                curve: .easeInOut,
                animations:
            {
                self.mainView.transform = CGAffineTransform.identity
            })
            secondAnimator.addCompletion({ (_) in
                completion()
            })
            secondAnimator.startAnimation()
        }
        firstAnimator.startAnimation()
    }
    
    func notifyObserverWithNextBlock() {
        guard let nextBlock = self.block?.child else {
            self.notifyObserverWithDismissRocket()
            return
        }
        
        NotificationCenter.default.post(name: .clickOnBlockEvent, object: nil, userInfo: [
            "block" : nextBlock
        ])
    }
    
    func notifyObserverWithDismissRocket() {
        NotificationCenter.default.post(name: .clickOnLastBlockEvent, object: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.tapOnCell = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setAutoresizingMask()
        self.setPositionConstraints()
        self.setSizeConstraints()
        self.setCornerRadius()
        self.setShadow()
    }

    func setAutoresizingMask() {
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPositionConstraints() {
        self.shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.shadowView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        self.mainView.topAnchor.constraint(equalTo: self.shadowView.topAnchor, constant: 0).isActive = true
        self.mainView.leftAnchor.constraint(equalTo: self.shadowView.leftAnchor, constant: 0).isActive = true
    }
    
    func setSizeConstraints() {
        self.shadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.shadowView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        self.mainView.bottomAnchor.constraint(equalTo: self.shadowView.bottomAnchor, constant: 0).isActive = true
        self.mainView.rightAnchor.constraint(equalTo: self.shadowView.rightAnchor, constant: 0).isActive = true
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
        self.shadowView.layer.shadowRadius = 10
        self.shadowView.layer.shadowOpacity = 1
        self.shadowView.layer.shadowOffset = CGSize.zero
    }
    
    fileprivate func setStyle() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.shadowView.backgroundColor = .clear
        self.mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectionStyle = .none
    }
    
}

