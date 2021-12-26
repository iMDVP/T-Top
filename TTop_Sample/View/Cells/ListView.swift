//
//  ListView.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/4/1400 AP.
//

import UIKit

class ListView: UIView {
    
    // MARK: Public
    public var object: DynamicModel! {
        didSet{
            self.updateUI()
        }
    }
    
    public var items: [Items] = [] {
        didSet{
            self.updateCollectionView()
        }
    }

    let titleLable: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let newRecordButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var indexPath: IndexPath? = nil
    var delegate: TableManager?
    fileprivate var spacing: CGFloat = CGFloat(8)
    fileprivate var collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: self.spacing, left: self.spacing, bottom: 0, right: self.spacing)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = self.spacing
        layout.scrollDirection = .vertical
        return layout
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
        self.createCollectionView()
    }
    
    fileprivate func createLabel() {
        self.addSubview(titleLable)
        NSLayoutConstraint(item: titleLable, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: titleLable, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10).isActive = true
        titleLable.configure(text: "", fontSize: 16.0, textColor: .black, fontType: .bold)
    }
    fileprivate func createButton() {
        self.addSubview(newRecordButton)
        NSLayoutConstraint(item: newRecordButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -5).isActive = true
        NSLayoutConstraint(item: newRecordButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: newRecordButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: newRecordButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30).isActive = true
        newRecordButton.configure(fontSize: 11.0, title: "سطر جدید", fontType: .regular, titleColor: .white, backgroundColor: .systemGreen, borderColor: .clear)
        newRecordButton.addTarget(self, action: #selector(self.addNewItem), for: .touchUpInside)
    }
    fileprivate func createCollectionView() {
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.collectionView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        self.collectionView.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
                
        NSLayoutConstraint(item: self.collectionView, attribute: .top, relatedBy: .equal, toItem: self.titleLable, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .bottom, relatedBy: .equal, toItem: self.newRecordButton, attribute: .top, multiplier: 1, constant: -20).isActive = true
    }

    
    fileprivate func updateUI() {
        self.titleLable.text = self.object.title
    }
    
    fileprivate func updateCollectionView() {
        self.collectionView.reloadData()
    }

    @objc func addNewItem() {
        guard let indexp = self.indexPath else {
            return
        }
        let totalCount = self.items.count
        let count = Constant.countOfItem[indexp.row]
        if count < totalCount {
            Constant.countOfItem[indexp.row] = count + 1
            self.delegate?.appendItem(indexPath: indexp, count: count + 1)
            self.updateCollectionView()
        }else {
//            self.presenter?.view?.showError()
        }

        
        

        
//        self.updateCollectionView()

    }
}

extension ListView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let indexp = self.indexPath else {
            return 0
        }
        let count = self.items.count
        if Constant.countOfItem[indexp.row] < count {
            return Constant.countOfItem[indexp.row]
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemsCollectionViewCell
        
        cell.item = self.items[indexPath.row]
        return cell
    }
}

extension ListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthCell: CGFloat = (self.collectionView.frame.width ) - CGFloat(self.spacing)
        let heightCell: CGFloat = 60.0
        
        return CGSize(width: widthCell, height: heightCell)
    }
}


extension UITableView {
    func indexPathForCellWithSubview(cellSubview: UIView) -> NSIndexPath? {
        let cellFrame = convert(cellSubview.bounds, from: cellSubview)
        let cellCenter = CGPoint(x: cellFrame.midX, y: cellFrame.midY)
        return indexPathForRow(at: cellCenter) as NSIndexPath?
    }
}

extension UICollectionView {
    func indexPathForCellWithSubview(cellSubview: UIView) -> NSIndexPath? {
        let cellFrame = convert(cellSubview.bounds, from: cellSubview)
        let cellCenter = CGPoint(x: cellFrame.midX, y: cellFrame.midY)
        return indexPathForItem(at: cellCenter) as NSIndexPath?
    }
}
