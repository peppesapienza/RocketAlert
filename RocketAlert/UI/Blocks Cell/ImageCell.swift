//
//  ImageCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 01/06/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

class ImageRocketCell: TextRocketCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.customImageView = UIImageView.init(frame: .zero)
        self.customImageView.contentMode = .scaleAspectFill
        self.customImageView.clipsToBounds = true
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView.addSubview(self.customImageView)
    }
    
    override var currentBlock: RocketBlock? {
        didSet {
            guard let b = currentBlock as? ImageRocketBlock else { return }
            self.paddingLeft = b.paddingLeft
            self.paddingRight = b.paddingRight * -1
            self.customImageView.image = b.image
            self.customImageView.layer.cornerRadius = b.imageStyle.cornerRadius(for: self.customImageView)
            self.setNeedsUpdateConstraints()
        }
    }
    
    fileprivate let customImageView: UIImageView
    fileprivate var paddingLeft: CGFloat = 0
    fileprivate var paddingRight: CGFloat = 0
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        self.customImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setConstraints() {
        super.setMainViewConstraints()
        self.label.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 10).isActive = true
        self.label.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -10).isActive = true
        self.customImageView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 10).isActive = true
        self.customImageView.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: self.paddingLeft).isActive = true
        self.customImageView.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: self.paddingRight).isActive = true
        self.customImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        self.customImageView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -24).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
