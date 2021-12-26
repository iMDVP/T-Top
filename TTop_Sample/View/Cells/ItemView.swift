//
//  ItemView.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/4/1400 AP.
//

import UIKit
import DropDown

class ItemView: UIView {
    
    // MARK: Public
    public var item: Items! {
        didSet{
            self.updateUI()
        }
    }

    let dropDownView = DropDown()

    let dropDownButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showDropDownMenu), for: .touchUpInside)
        return button
    }()

    let valueButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }

    // MARK: Function
    fileprivate func defaultInit() {
        self.backgroundColor = .clear
        self.createLabel()
        self.createButton()
        self.setupDropDown()
    }
    
    fileprivate func createLabel() {
        self.addSubview(dropDownButton)
        NSLayoutConstraint(item: dropDownButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: dropDownButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: dropDownButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.4, constant: 0).isActive = true
        NSLayoutConstraint(item: dropDownButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30).isActive = true
        dropDownButton.configure(fontSize: 11.0, title: "", fontType: .regular, titleColor: .black, backgroundColor: .white, borderColor: .clear)
    }
    fileprivate func createButton() {
        self.addSubview(valueButton)
        NSLayoutConstraint(item: valueButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: valueButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: valueButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.4, constant: 0).isActive = true
        NSLayoutConstraint(item: valueButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30).isActive = true
        valueButton.configure(fontSize: 11.0, title: "", fontType: .regular, titleColor: .black, backgroundColor: .white, borderColor: .clear)
    }
    
    fileprivate func setupDropDown() {
        dropDownView.anchorView = dropDownButton
        dropDownView.cornerRadius = 10
        dropDownView.backgroundColor = .white
        dropDownView.textFont = UIFont(type: FontString.regular, fontSize: 14)
        dropDownView.direction = .bottom
        dropDownView.bottomOffset = CGPoint(x: 0, y: 50)
    }
    
    //MARK: - Objc Functions
    @objc func showDropDownMenu(button: UIButton) {
        self.dropDownView.show()
    }
    
    fileprivate func updateUI() {
        dropDownView.dataSource = [self.item.name!]
        self.dropDownButton.setTitle("\(self.item.name!)", for: .normal)
        self.valueButton.setTitle("\(self.item.capital!)", for: .normal)
    }

}
