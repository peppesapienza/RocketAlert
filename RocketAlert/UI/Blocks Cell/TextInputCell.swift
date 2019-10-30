//
//  InputRocketCell.swift
//  RocketAlert
//
//  Created by Giuseppe Sapienza on 31/03/18.
//  Copyright © 2018 Giuseppe Sapienza. All rights reserved.
//

import Foundation

class TextInputRocketCell: RocketCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
            label.text = b.text
            inputHandler = b.handler
            setStyle(button: b.buttonStyle, text: b.font)
            button.setTitle(b.buttonTitle, for: .normal)
            setNeedsUpdateConstraints()
        }
    }
    
    fileprivate let label: UILabel
    fileprivate let textView: UITextView
    fileprivate let button: UIButton
    fileprivate var isTapOnButtonEnabled = true
    fileprivate var inputHandler: InputRocketHandler<String>?
    
    @objc
    fileprivate func handle_tapOnButton(_ sender: UIButton) {
        guard isTapOnButtonEnabled else { return }
        isTapOnButtonEnabled = false
        let next = inputHandler?.action?(textView.text)
        show(next: next)
    }
    
    fileprivate func setStyle(button buttonStyle: RocketFont?, text textStyle: RocketFont?) {
        label.textColor = textStyle?.color
        label.font = textStyle?.font
        textView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textView.textColor = textStyle?.color
        textView.backgroundColor = #colorLiteral(red: 0.9887566138, green: 0.9887566138, blue: 0.9887566138, alpha: 1)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.setTitleColor(buttonStyle?.color, for: .normal)
        button.titleLabel?.font = buttonStyle?.font
    }
    
    override func setAutoresizingMask() {
        super.setAutoresizingMask()
        label.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setConstraints() {
        super.setConstraints()
        label.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16).isActive = true
        label.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -16).isActive = true
        
        textView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6).isActive = true
        textView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10).isActive = true
        textView.widthAnchor.constraint(equalTo: label.widthAnchor, multiplier: 1).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16).isActive = true
        button.centerXAnchor.constraint(equalTo: textView.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: textView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
