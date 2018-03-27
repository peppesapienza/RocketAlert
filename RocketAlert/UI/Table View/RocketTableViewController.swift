//
//  RocketTableViewManager.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 03/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let clickOnBlockEvent = Notification.Name(
        rawValue: "clickOnBlockEvent")
    static let clickOnLastBlockEvent = Notification.Name(
        rawValue: "clickOnLastBlockEvent")
}

class RocketTableViewController: NSObject {
    
    init(tableView: RocketTableView) {
        self.tableView = tableView
        super.init()
        self.tableView.register(TextRocketCell.self, forCellReuseIdentifier: "\(TextRocketBlock.self)")
        self.tableView.register(ButtonRocketCell.self, forCellReuseIdentifier: "\(ButtonRocketCell.self)")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        NotificationCenter.default.addObserver(self,
                                       selector: #selector(RocketTableViewController.handleClickOnBlock),
                                       name: .clickOnBlockEvent,
                                       object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RocketTableViewController.handleClickOnLastBlock),
                                               name: .clickOnLastBlockEvent,
                                               object: nil)
    }
    
    internal weak var rocket: RocketAlertView!
    private weak var tableView: UITableView!
    private var blocks: [RocketBlock] = []
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .clickOnBlockEvent, object: nil)
        NotificationCenter.default.removeObserver(self, name: .clickOnLastBlockEvent, object: nil)
        print("🔥 [Rocket] Deinit RocketTableViewController")
    }
    
    func show(block: RocketBlock) {
        self.blocks.append(block)
        self.tableView.addRow(at: self.blocks.count, with: .bottom)
    }
    
    @objc func handleClickOnBlock(_ sender: Notification) {
        guard let block = sender.userInfo?["block"] as? RocketBlock else { return }
        self.show(block: block)
    }
    
    @objc func handleClickOnLastBlock(_ sender: Notification) {
        self.rocket.dismiss()
    }
    
}

extension RocketTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CellRocketFactory.init(
            block: self.blocks[indexPath.row],
            tableView: tableView,
            indexPath: indexPath
            ).cell()
    }
}

extension RocketTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.fadeIn()
    }
}




