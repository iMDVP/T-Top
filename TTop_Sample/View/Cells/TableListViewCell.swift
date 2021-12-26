//
//  TableListViewCell.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//

import Foundation
import UIKit

class TableListViewCell: UITableViewCell {
    
    var object: DynamicModel!{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.updateUI()
            }
        }
    }
    
    // MARK: Private
    private var view: ListView = ListView()
    var delegate: TableManager?
    // MARK: Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        view.delegate = self
        
    }
    
    func updateUI() {
        if let indexP = self.indexPath.flatMap({ $0 }) {
            self.view.indexPath = indexP
            self.view.object = self.object
            self.view.items = self.object.items ?? []
        }
    }
    
}
extension TableListViewCell: TableManager {
    func appendBox(count: Int) {
        //
    }
    
    func appendItem(indexPath: IndexPath, count: Int) {
        self.delegate?.appendItem(indexPath: indexPath, count: count)
//        if let indexP = self.indexPath.flatMap({ $0 }) {
//            let c = Constant.countOfItem[indexP.row]
//            if c < self.object.items?.count ?? 0 {
//                Constant.countOfItem[indexP.row] = c + 1
//                self.delegate?.appendItem(indexPath: indexP, count: c+1)
//
//            }
//        }
        
        
    }
}
