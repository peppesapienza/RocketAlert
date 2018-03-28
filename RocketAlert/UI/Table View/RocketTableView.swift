//
//  RocketTableView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 02/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class RocketTableView: UITableView, RocketSubView {
    
    required init(authorView: RocketAuthorView, in container: RocketContainerView) {
        self.container = container
        self.authorView = authorView
        super.init(frame: .zero, style: .plain)
        self.container.addSubview(self)
        
        self.setAutoresizingMask()
        self.setPositionConstraints()
        self.setSizeConstraints()
        
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = UITableViewAutomaticDimension
        
        self.separatorStyle = .none
        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var container: RocketContainerView!
    weak var authorView: UIView!
    var heightConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.heightConstraint.constant = self.contentSize.height
    }

    deinit {
        print("🔥 [Rocket] Deinit RocketTableView")
    }

}

extension RocketTableView: RocketAnimatable {
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
        self.alpha = 0
    }
    
    func openAnimation(completionHandler: (()->())? = nil) {
        let animator = UIViewPropertyAnimator.init(duration: 1, curve: .easeInOut) {
            self.alpha = 1
        }
        
        animator.addCompletion { (_) in
            completionHandler?()
        }
        
        animator.startAnimation()
    }
}


extension RocketTableView: RocketViewLayout {
    func setAutoresizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPositionConstraints() {
        self.rightAnchor.constraint(equalTo: self.authorView.leftAnchor, constant: -6).isActive = true
        self.bottomAnchor.constraint(equalTo: self.authorView.bottomAnchor, constant: -10).isActive = true
    }

    func setSizeConstraints() {
        self.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.6).isActive = true
        self.topAnchor.constraint(greaterThanOrEqualTo: self.container.topAnchor, constant: 20).isActive = true
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: 44)
        self.heightConstraint.isActive = true
    }
}

