//
//  RocketTableViewManager.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 03/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let showNextBlockEvent = Notification.Name(rawValue: "showNextBlockEvent")
    static let dismissRocketAlertEvent = Notification.Name(rawValue: "dismissRocketAlertEvent")
    public static let rocketBlockAddedEvent = Notification.Name(rawValue: "rocketBlockAddedEvent")
    public static let rocketDismissEvent = Notification.Name(rawValue: "rocketDismissEvent")
}

class RocketTableController: NSObject {
    
    init(tableView: RocketTableView) {
        self.tableView = tableView
        super.init()
        self.addObservers()
        self.registerCells()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    weak var rocket: Rocket!
    fileprivate weak var tableView: UITableView!
    fileprivate var blocks: [RocketBlock] = []
    
    fileprivate var count: Int {
        return self.blocks.count
    }
    
    func show(block: RocketBlock) {
        self.blocks.append(block)
        self.tableView.addRow(at: self.count, with: .bottom)
        NotificationCenter.default.post(name: .rocketBlockAddedEvent, object: nil, userInfo: [
            "index" : self.count-1,
            "block" : block
        ])
    }
    
    @objc
    fileprivate func handle_showNextBlockEvent(_ sender: Notification) {
        guard let block = sender.userInfo?["block"] as? RocketBlock else { return }
        self.show(block: block)
    }
    
    @objc
    fileprivate func handle_dismissRocketAlertEvent(_ sender: Notification) {
        self.rocket.dismiss()
        NotificationCenter.default.post(name: .rocketDismissEvent, object: nil, userInfo: [
            "count" : count,
            "blocks" : self.blocks
        ])
    }
    
    fileprivate func registerCells() {
        self.tableView.register(TextRocketCell.self, forCellReuseIdentifier: "\(TextRocketBlock.self)")
        self.tableView.register(ButtonRocketCell.self, forCellReuseIdentifier: "\(ButtonRocketBlock.self)")
        self.tableView.register(DoubleButtonRocketCell.self, forCellReuseIdentifier: "\(DoubleButtonRocketBlock.self)")
        self.tableView.register(TextInputRocketCell.self, forCellReuseIdentifier: "\(TextInputRocketBlock.self)")
        self.tableView.register(ImageRocketCell.self, forCellReuseIdentifier: "\(ImageRocketBlock.self)")
    }
    
    fileprivate func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RocketTableController.handle_showNextBlockEvent),
                                               name: .showNextBlockEvent,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RocketTableController.handle_dismissRocketAlertEvent),
                                               name: .dismissRocketAlertEvent,
                                               object: nil)
    }
    
    fileprivate func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .showNextBlockEvent, object: nil)
        NotificationCenter.default.removeObserver(self, name: .dismissRocketAlertEvent, object: nil)
    }
    
    deinit {
        self.removeObservers()
        print("🔥 [Rocket] Deinit RocketTableController")
    }
}

extension RocketTableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CellRocketFactory.init(
            block: self.blocks[indexPath.row],
            lastBlockIndex: self.blocks.count-1,
            tableView: tableView,
            indexPath: indexPath).cell()
    }
}

extension RocketTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.fadeIn()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let closeButton = self.rocket.closeButton else { return nil }

        return CloseButtonView.init(
            frame: CGRect.init(
                origin: .zero,
                size: CGSize.init(width: tableView.frame.width, height: 40)),
            closeButton: closeButton)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = self.rocket.closeButton else { return 0 }
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}




