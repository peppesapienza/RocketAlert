//
//  RocketBackgroundView.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 02/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class RocketContainerView: UIView, RocketSubView {
    
    init(superView: UIView) {
        self.container = superView
        super.init(frame: .zero)
        self.backgroundColor = .clear
        superView.addSubview(self)
        self.setAutoresizingMask()
        self.setPositionConstraints()
        self.setSizeConstraints()
    }

    weak var container: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("🔥 [Rocket] Deinit RocketContainerView")
    }
    
}

extension RocketContainerView: RocketViewLayout {
    func setAutoresizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPositionConstraints() {
        self.centerXAnchor.constraint(equalTo: self.container.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: self.container.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    func setSizeConstraints() {
        self.heightAnchor.constraint(equalTo: self.container.safeAreaLayoutGuide.heightAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: self.container.safeAreaLayoutGuide.widthAnchor).isActive = true
    }
    
}
