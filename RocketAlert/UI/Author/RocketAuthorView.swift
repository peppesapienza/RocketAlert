//
//  AuthorView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 02/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

protocol RocketViewLayout {
    func setAutoresizingMask()
    func setPositionConstraints()
    func setSizeConstraints()
}

protocol RocketAnimatable {
    func prepareAnimation()
    func openAnimation(completionHandler: (()->())?)
    func closeAnimation(completionHandler: (()->())?)
}

protocol RocketSubView {
    var container: UIView! { get }
}

class RocketAuthorView: UIView, RocketSubView {
    
     required init(author: RocketAuthor, in container: RocketContainerView) {
        self.midView = UIView.init(frame: .zero)
        self.imageView = UIImageView.init(frame: .zero)
        self.imageView.image = author.image
        self.container = container
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.midView.addSubview(imageView)
        self.addSubview(midView)
        container.addSubview(self)
        
        self.setAutoresizingMask()
        self.setClipToBounds()
        self.setPositionConstraints()
        self.setSizeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCornerRadius()
        self.setShadow()
    }
    
    weak var container: UIView!
    private let imageView: UIImageView
    private let midView: UIView
    
    private func setClipToBounds() {
        self.midView.clipsToBounds = true
        self.imageView.clipsToBounds = true
    }
    
    private func setCornerRadius() {
        self.midView.layer.masksToBounds = true
        self.midView.layer.cornerRadius = self.midView.layer.frame.height/2
    }
    
    private func setShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0.8767361111, green: 0.8767361111, blue: 0.8767361111, alpha: 1)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
    }
    
    deinit {
        print("🔥 [Rocket] Deinit RocketAuthorView")
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
        self.translatesAutoresizingMaskIntoConstraints = false
        self.midView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPositionConstraints() {
        self.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -10).isActive = true
        self.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -10).isActive = true
        self.midView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.midView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.midView.centerXAnchor).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: self.midView.centerYAnchor).isActive = true
    }
    
    func setSizeConstraints() {
        let size: CGFloat = 60
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.midView.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.midView.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: size).isActive = true
    }
}
