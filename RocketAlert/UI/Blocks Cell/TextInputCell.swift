//
//  InputRocketCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 31/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

class TextInputRocketCell: RocketCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.label = UILabel.init(frame: .zero)
        self.textView = UITextView.init(frame: .zero)
        self.button = UIButton.init(frame: .zero)
        self.label.numberOfLines = 0
        self.textView.isScrollEnabled = true
        self.textView.returnKeyType = .done
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView.addSubview(self.label)
        self.mainView.addSubview(self.textView)
        self.mainView.addSubview(self.button)
        self.textView.delegate = self
        self.button.addTarget(self, action: #selector(TextInputRocketCell.handle_tapOnButton), for: .touchDown)
    }
    
    override var currentBlock: RocketBlock? {
        didSet {
            guard let b = currentBlock as? TextInputRocketBlock else { return }
            self.label.text = b.text
            self.inputHandler = b.handler
            self.setStyle(button: b.buttonStyle, text: b.font)
            self.button.setTitle(b.buttonTitle, for: .normal)
            self.setNeedsUpdateConstraints()
        }
    }
    
    fileprivate let label: UILabel
    fileprivate let textView: UITextView
    fileprivate let button: UIButton
    fileprivate var isTapOnButtonEnabled = true
    fileprivate var inputHandler: InputRocketHandler<String>?
    
    @objc
    fileprivate func handle_tapOnButton(_ sender: UIButton) {
        guard self.isTapOnButtonEnabled else { return }
        self.isTapOnButtonEnabled = false
        let next = self.inputHandler?.action?(self.textView.text)
        self.show(next: next)
    }
    
    fileprivate func setStyle(button buttonStyle: RocketFont?, text textStyle: RocketFont?) {
        self.label.textColor = textStyle?.color
        self.label.font = textStyle?.font
        self.textView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        self.textView.textColor = textStyle?.color
        self.textView.backgroundColor = #colorLiteral(red: 0.9887566138, green: 0.9887566138, blue: 0.9887566138, alpha: 1)
        self.button.titleLabel?.textAlignment = .left
        self.button.contentHorizontalAlignment = .left
        self.button.setTitleColor(buttonStyle?.color, for: .normal)
        self.button.titleLabel?.font = buttonStyle?.font
    }
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setConstraints() {
        super.setConstraints()
        self.label.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 16).isActive = true
        self.label.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -16).isActive = true
        
        self.textView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
        self.textView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 6).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -10).isActive = true
        self.textView.widthAnchor.constraint(equalTo: self.label.widthAnchor, multiplier: 1).isActive = true
        self.textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.button.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -16).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.textView.centerXAnchor).isActive = true
        self.button.widthAnchor.constraint(equalTo: self.textView.widthAnchor).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TextInputRocketCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        
        return true
    }
    
}
