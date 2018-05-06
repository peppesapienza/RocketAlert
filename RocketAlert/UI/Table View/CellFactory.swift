//
//  CellRocketFactory.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 22/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

struct CellRocketFactory {
    init(block: RocketBlock, tableView: UITableView, indexPath: IndexPath) {
        self.block = block
        self.tableView = tableView
        self.indexPath = indexPath
    }
    
    fileprivate let block: RocketBlock
    fileprivate weak var tableView: UITableView!
    fileprivate let indexPath: IndexPath
    
    func cell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: block.cellIdentifier, for: indexPath) as! RocketCell
        cell.currentBlock = block
        return cell
    }
    
}
