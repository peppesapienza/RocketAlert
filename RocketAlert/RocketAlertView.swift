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
        do {
            self.superView = try TopViewFinder.init(in: UIApplication.shared.topViewController()).view
            self.mainView = RocketContainerView.init(superView: superView)
            self.authorView = RocketAuthorView.init(author: author, in: mainView)
            self.tableView = RocketTableView.init(authorView: authorView, in: mainView)
            self.tableController = RocketTableViewController.init(tableView: self.tableView)
            self.block = block
            self.authorView.prepareAnimation()
            self.tableView.prepareAnimation()
            self.mainView.alpha = 0
            self.mainView.transform = CGAffineTransform.init(translationX: self.mainView.frame.width, y: 0)
        } catch {
            fatalError(error.localizedDescription)
        }
        super.init()
        self.tableController.rocket = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal let block: RocketBlock
    internal let mainView: RocketContainerView
    private let authorView: RocketAuthorView
    private let tableView: RocketTableView
    private let tableController: RocketTableViewController
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

    deinit {
        print("🔥 [Rocket] Deinit RocketAlertView")
    }
    
}
