//
//  RocketViewController.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 18/06/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class RocketViewController: UIViewController {
    
    init(author: RocketAuthor) {
        super.init(nibName: nil, bundle: nil)
        self.authorView = RocketAuthorView.init(author: author, in: self.view)
        self.tableView = RocketTableView.init(authorView: authorView, in: self.view)
        self.modalPresentationStyle = .overCurrentContext
        self.view.backgroundColor = .clear
        self.view.alpha = 1
        self.prepareAnimation()
    }
    
    var rocket: Rocket? {
        didSet {
            self.tableController = RocketTableController.init(tableView: self.tableView)
            self.tableController.rocket = rocket
        }
    }
    
    fileprivate var authorView: RocketAuthorView!
    fileprivate var tableView: RocketTableView!
    fileprivate var tableController: RocketTableController!
    
    
    func show(block: RocketBlock) {
        self.authorView.openAnimation(completionHandler: {
            self.authorView.bounce()
            self.tableView.openAnimation(completionHandler: {
                self.tableController.show(block: block)
            })
        })
    }
    
    func dismiss(completionHandler: @escaping () -> ()) {
        self.tableView.closeAnimation {
            self.authorView.closeAnimation(completionHandler: {
                self.dismiss(animated: false, completion: {
                    self.rocket = nil
                    completionHandler()
                })
            })
        }
    }
    
    fileprivate func prepareAnimation() {
        self.authorView.prepareAnimation()
        self.tableView.prepareAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        //print("🔥 [Rocket] Deinit RocketViewController")
    }

}
