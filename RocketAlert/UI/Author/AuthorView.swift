//
//  AuthorView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 02/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class RocketAuthorView: UIView, RocketSubView {
    
     required init(author: RocketAuthor, in container: UIView) {
        self.midView = UIView.init(frame: .zero)
        self.imageView = UIImageView.init(frame: .zero)
        self.imageView.image = author.image
        self.imageView.backgroundColor = .white
        self.container = container
        self.style = author.style
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.midView.addSubview(imageView)
        self.addSubview(midView)
        container.addSubview(self)
        
        self.setAutoresizingMask()
        self.setClipToBounds()
        self.setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius()
        setShadow()
    }
    
    weak var container: UIView!
    fileprivate let imageView: UIImageView
    fileprivate let midView: UIView
    fileprivate let style: RocketImageStyle
    
    fileprivate func setClipToBounds() {
        midView.clipsToBounds = true
        imageView.clipsToBounds = true
    }
    
    fileprivate func setCornerRadius() {
        midView.layer.masksToBounds = true
        midView.layer.cornerRadius = style.cornerRadius(for: midView)
    }
    
    fileprivate func setShadow() {
        layer.shadowColor = #colorLiteral(red: 0.8767361111, green: 0.8767361111, blue: 0.8767361111, alpha: 1)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
    }
    
    //deinit { print("🔥 [Rocket] Deinit RocketAuthorView") }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RocketAuthorView: RocketAnimatable {
    func closeAnimation(completionHandler: (()->())? = nil) {
        let animator = UIViewPropertyAnimator.init(duration: 1, curve: .easeInOut) {
            self.prepareAnimation()
        }
        
        animator.addCompletion { (_) in
            completionHandler?()
        }
        
        animator.startAnimation()
    }
    
    func prepareAnimation() {
        self.transform = CGAffineTransform.init(translationX: 0, y: 300)
    }
    
    func openAnimation(completionHandler: (()->())? = nil) {
        let animator = UIViewPropertyAnimator.init(duration: 1, curve: .easeInOut) {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
        }
        
        animator.addCompletion { (_) in
            completionHandler?()
        }
        
        animator.startAnimation()
    }
}

extension RocketAuthorView: RocketViewLayout {
    func setAutoresizingMask() {
        translatesAutoresizingMaskIntoConstraints = false
        midView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        let tabBarHeight: CGFloat = Rocket.hasTabBar ? -60 : -30
        let size: CGFloat = 60
        
        rightAnchor.constraint(equalTo: container.rightAnchor, constant: -20).isActive = true
        bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: tabBarHeight).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
        widthAnchor.constraint(equalToConstant: size).isActive = true
        
        midView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        midView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        midView.heightAnchor.constraint(equalToConstant: size).isActive = true
        midView.widthAnchor.constraint(equalToConstant: size).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: midView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: midView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: size).isActive = true
    }

}
