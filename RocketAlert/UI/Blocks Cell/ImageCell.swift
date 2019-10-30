//
//  ImageCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 01/06/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

class ImageRocketCell: TextRocketCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.customImageView = UIImageView.init(frame: .zero)
        self.customImageView.contentMode = .scaleAspectFill
        self.customImageView.clipsToBounds = true
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView.addSubview(self.customImageView)
    }
    
    override var currentBlock: RocketBlock? {
        didSet {
            guard let b = currentBlock as? ImageRocketBlock else { return }
            paddingLeft = b.paddingLeft
            paddingRight = b.paddingRight * -1
            customImageView.image = b.image
            customImageView.layer.cornerRadius = b.imageStyle.cornerRadius(for: self.customImageView)
            setNeedsUpdateConstraints()
        }
    }
    
    fileprivate let customImageView: UIImageView
    fileprivate var paddingLeft: CGFloat = 0
    fileprivate var paddingRight: CGFloat = 0
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        customImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setConstraints() {
        super.setMainViewConstraints()
        label.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16).isActive = true
        label.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10).isActive = true
        customImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        customImageView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: paddingLeft).isActive = true
        customImageView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: paddingRight).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 24).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
