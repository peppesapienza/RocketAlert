//
//  RocketAlertView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 01/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit
public class RocketAlertView: NSObject, RocketAlert {
    
    public required init(author: RocketAuthor, block: RocketBlock) {
        guard let vc = UIApplication.shared.topViewController() else {
            fatalError(RocketAlertError.cantFindRootViewController.localizedDescription)
        }
        RocketAlertView.hasTabBar = vc.hasTabBarController
        self.superView = vc.view
        self.mainView = RocketContainerView.init(superView: superView)
        self.authorView = RocketAuthorView.init(author: author, in: mainView)
        self.tableView = RocketTableView.init(authorView: authorView, in: mainView)
        self.tableController = RocketTableController.init(tableView: self.tableView)
        self.block = block
        super.init()
        self.tableController.rocket = self
        self.prepareAnimation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var hasTabBar: Bool = false
    
    let block: RocketBlock
    let mainView: RocketContainerView
    private let authorView: RocketAuthorView
    private let tableView: RocketTableView
    private let tableController: RocketTableController
    private weak var superView: UIView!
    
    public func show() {
        self.mainView.alpha = 1
        self.mainView.transform = CGAffineTransform.identity
        self.superView.bringSubview(toFront: self.mainView)
        self.authorView.openAnimation(completionHandler: {
            self.authorView.bounce()
            self.tableView.openAnimation(completionHandler: {
                self.tableController.show(block: self.block)
            })
        })
    }
    
    public func dismiss() {
        self.tableView.closeAnimation {
            self.authorView.closeAnimation(completionHandler: {
                self.mainView.removeFromSuperview()
            })
        }
    }
    
    fileprivate func prepareAnimation() {
        self.authorView.prepareAnimation()
        self.tableView.prepareAnimation()
        self.mainView.alpha = 0
        self.mainView.transform = CGAffineTransform.init(translationX: self.mainView.frame.width, y: 0)
    }

    deinit {
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
