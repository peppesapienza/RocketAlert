//
//  CellRocketFactory.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 22/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

struct CellRocketFactory {
    init(block: RocketBlock, lastBlockIndex: Int, tableView: UITableView, indexPath: IndexPath) {
        self.block = block
        self.lastBlockIndex = lastBlockIndex
        self.tableView = tableView
        self.indexPath = indexPath
    }
    
    fileprivate let block: RocketBlock
    fileprivate let lastBlockIndex: Int
    fileprivate weak var tableView: UITableView!
    fileprivate let indexPath: IndexPath
    
    func cell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: block.cellIdentifier, for: indexPath) as! RocketCell
        cell.isUserInteractionEnabled = lastBlockIndex == indexPath.row
        cell.currentBlock = block
        return cell
    }
    
}
