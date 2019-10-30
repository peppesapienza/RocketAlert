//
//  RocketTableView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 02/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class RocketTableView: UITableView, RocketSubView {
    
    required init(authorView: RocketAuthorView, in container: UIView) {
        self.container = container
        self.authorView = authorView
        super.init(frame: .zero, style: .grouped)
        self.container.addSubview(self)
        
        self.setAutoresizingMask()
        self.setConstraints()
        
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = UITableView.automaticDimension
        self.showsVerticalScrollIndicator = false
        self.sectionFooterHeight = 0
        self.separatorStyle = .none
        self.backgroundColor = .clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(handle_keyboardOpening), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handle_keyboardHiding), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handle_newBlockAdded), name: .rocketBlockAddedEvent, object: nil)
    }
    
    weak var container: UIView!
    fileprivate weak var authorView: UIView!
    
    fileprivate var cellCount: Int = 0
    fileprivate var heightConstraint: NSLayoutConstraint!
    fileprivate var bottomConstraint: NSLayoutConstraint!
    fileprivate var widthConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heightConstraint.constant = contentSize.height
        let width: CGFloat = (UIDevice.current.isPad || Rocket.isLandscape) ? -180 : 0
        let widthIpadLandscape: CGFloat = (UIDevice.current.isPad && Rocket.isLandscape) ? -100 : 0
        widthConstraint.constant = width + widthIpadLandscape
    }
    
    @objc
    fileprivate func handle_keyboardOpening(_ notification: Notification) {
        guard
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let tabBarHeight: CGFloat = Rocket.hasTabBar ? 44 : 0
        print(keyboardHeight, tabBarHeight)
        bottomConstraint.constant = -(keyboardHeight - 30)
        scrollToLastVisibleCell()
    }
    
    @objc
    fileprivate func handle_keyboardHiding(_ sender: Notification) {
        bottomConstraint.constant = -10
    }
    
    @objc
    fileprivate func handle_newBlockAdded(_ sender: Notification) {
        cellCount += 1
        scrollToLastVisibleCell()
    }
    
    fileprivate func scrollToLastVisibleCell() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let indexPath = IndexPath.init(row: self.cellCount-1, section: 0)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: .rocketBlockAddedEvent, object: nil)
        //print("🔥 [Rocket] Deinit RocketTableView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        alpha = 0
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
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setConstraints() {
        widthConstraint = widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.6)
        widthConstraint.isActive = true
        
        topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor, constant: 20).isActive = true
        rightAnchor.constraint(equalTo: authorView.leftAnchor, constant: -6).isActive = true
        
        bottomConstraint = bottomAnchor.constraint(equalTo: authorView.bottomAnchor, constant: 0)
        bottomConstraint.isActive = true
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 44)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
    }
}

