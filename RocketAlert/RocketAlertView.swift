//
//  RocketAlertView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 01/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit
public class RocketAlertView: UIViewController, RocketAlert {
    
    public required init(author: RocketAuthor, block: RocketBlock) {
        guard let vc = UIApplication.shared.topViewController() else {
            fatalError(RocketAlertError.cantFindRootViewController.localizedDescription)
        }
        RocketAlertView.hasTabBar = vc.hasTabBarController
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
        NotificationCenter.default.addObserver(self, selector: #selector(RocketAlertView.rotated), name: .UIDeviceOrientationDidChange, object: nil)
        self.prepareAnimation()
    }
    
    static var hasTabBar: Bool = false
    static var isLandscape: Bool = UIDeviceOrientationIsLandscape(UIDevice.current.orientation)
    
    let block: RocketBlock
    var mainView: RocketContainerView!
    fileprivate var topVC: UIViewController
    fileprivate var authorView: RocketAuthorView!
    fileprivate var tableView: RocketTableView!
    fileprivate var tableController: RocketTableController!
    
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
            RocketAlertView.isLandscape = true
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            RocketAlertView.isLandscape = false
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
        print("🔥 [Rocket] Deinit RocketAlertView")
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
