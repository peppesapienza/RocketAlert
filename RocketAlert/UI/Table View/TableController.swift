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
    public static let addedNewRocketBlock = Notification.Name(rawValue: "addedNewRocketBlock")
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
    
    deinit { self.removeObservers() }
    
    weak var rocket: Rocket!
    fileprivate weak var tableView: UITableView!
    fileprivate var blocks: [RocketBlock] = []
    
    func show(block: RocketBlock) {
        self.blocks.append(block)
        let count = self.blocks.count
        self.tableView.addRow(at: count, with: .bottom)
        NotificationCenter.default.post(name: .addedNewRocketBlock, object: [
            "index" : count-1,
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
}




