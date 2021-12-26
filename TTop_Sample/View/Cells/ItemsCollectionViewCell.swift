//
//  ItemsCollectionViewCell.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/4/1400 AP.
//

import Foundation
import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {
    
    var item: Items!{
        didSet{
            self.updateUI()
        }
    }
        
    // MARK: Private
    private var view: ItemView = ItemView()

    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupCell()
    }

    private func setupCell() {
        self.backgroundColor = UIColor.init(hex: "f1f1f1")
        
        for v in [view] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = 10.0
            self.contentView.addSubview(v)
        }
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -10).isActive = true

    }
    
    func updateUI() {
        self.view.item = self.item
    }
    
}
