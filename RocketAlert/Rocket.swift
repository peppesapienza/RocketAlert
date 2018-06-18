//
//  Rocket.swift
//  Rocket
//
//  Created by Giuseppe Sapienza on 01/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

/// A powerful, light and userfriendly Alert View
public class Rocket: UIViewController, RocketAlert {
    
    /**
    Initializes and returns a newly Rocket object with the specified author and block.
     
     - parameters:
        - author: the Author.
        - block: the first block showed by Rocket.
    */
    public required init(author: RocketAuthor, block: RocketBlock) {
        guard let vc = UIApplication.shared.topViewController() else {
            fatalError(RocketAlertError.cantFindRootViewController.localizedDescription)
        }
        Rocket.hasTabBar = vc.hasTabBarController
        self.topVC = vc
        self.block = block
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        self.view.backgroundColor = .clear
        self.view.alpha = 1
        self.mainView = RocketContainerView.init(superView: self.view)
        self.authorView = RocketAuthorView.init(author: author, in: mainView)
        self.tableView = RocketTableView.init(authorView: authorView, in: mainView)
        self.tableController = RocketTableController.init(tableView: self.tableView)
        self.tableController.rocket = self
        self.prepareAnimation()
        NotificationCenter.default.addObserver(self, selector: #selector(Rocket.rotated), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    public var closeButton: RocketCloseButton?
    
    static var hasTabBar: Bool = false
    static var isLandscape: Bool = UIDeviceOrientationIsLandscape(UIDevice.current.orientation)
    
    let block: RocketBlock
    var mainView: RocketContainerView!
    fileprivate var topVC: UIViewController
    fileprivate var authorView: RocketAuthorView!
    fileprivate var tableView: RocketTableView!
    fileprivate var tableController: RocketTableController!
    
    /// Show the Rocket Alert.
    public func show() {
        self.topVC.present(self, animated: false, completion: {
            self.mainView.alpha = 1
            self.mainView.transform = CGAffineTransform.identity
            self.authorView.openAnimation(completionHandler: {
                self.authorView.bounce()
                self.tableView.openAnimation(completionHandler: {
                    self.tableController.show(block: self.block)
                })
            })
        })
    }
    
    /// Dismiss the Rocket Alert.
    public func dismiss() {
        self.tableView.closeAnimation {
            self.authorView.closeAnimation(completionHandler: {
                super.dismiss(animated: false, completion: nil)
            })
        }
    }
    
    fileprivate func prepareAnimation() {
        self.authorView.prepareAnimation()
        self.tableView.prepareAnimation()
        self.mainView.alpha = 0
        self.mainView.transform = CGAffineTransform.init(translationX: self.mainView.frame.width, y: 0)
    }
    
    @objc
    fileprivate func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            Rocket.isLandscape = true
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            Rocket.isLandscape = false
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
        //print("🔥 [Rocket] Deinit Rocket")
    }
    
}

enum RocketAlertError: Error {
    case cantFindRootViewController
}

extension RocketAlertError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cantFindRootViewController: return "😵 [Rocket] I can't find the UIApplication.keyWindow.rootViewController"
        }
    }
}
