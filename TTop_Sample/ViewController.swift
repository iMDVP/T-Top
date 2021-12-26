//
//  ViewController.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tb: UITableView = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()

    let newBoxButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Properties
    var presenter: DynamicListViewToPresenterProtocol?
    var countOfItems: [Int] = Array.init(repeating: 1, count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hex: "f1f1f1")
        self.setupTableView()
        self.createButton()
        presenter?.updateView()
        // Do any additional setup after loading the view.
    }
    
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: -150).isActive = true

        tableView.clipsToBounds = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        tableView.register(TableListViewCell.self, forCellReuseIdentifier: "TableListViewCell")
    }

    fileprivate func createButton() {
        self.view.addSubview(newBoxButton)
        NSLayoutConstraint(item: newBoxButton, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -5).isActive = true
        NSLayoutConstraint(item: newBoxButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: newBoxButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint(item: newBoxButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0, constant: 50).isActive = true
        newBoxButton.configure(fontSize: 14.0, title: "افزودن باکس جدید", fontType: .regular, titleColor: .white, backgroundColor: .red, borderColor: .clear)
        newBoxButton.addTarget(self, action: #selector(self.addNewBox), for: .touchUpInside)
    }

    @objc func addNewBox() {
        guard let count = presenter?.getDynamicListCount() else { return }
        if Constant.countOfBox < count {
            Constant.countOfBox += 1
            self.presenter?.view?.showItems()
        }else {
            self.presenter?.view?.showError()
        }
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.getDynamicListCount() else { return 0}
        if Constant.countOfBox < count {
            return Constant.countOfBox
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableListViewCell", for: indexPath) as? TableListViewCell
        let row = indexPath.row
        let object = presenter?.getItem(index: row)
        cell?.object = object
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200.0 + CGFloat(self.countOfItems[indexPath.row]-1) * 50.0
    }
}

// MARK: - LiveNewsListPresenterToViewProtocol
extension ViewController: DynamicListPresenterToViewProtocol {

    func showItems() {
        tableView.reloadData()
        DispatchQueue.main.async {
            let index = IndexPath(row: Constant.countOfBox - 1, section: 0)
            self.tableView.scrollToRow(at: index, at: .bottom, animated: true)
        }
             
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "List has been finished", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: TableManager {

    func appendBox(count: Int) {
        //
    }
    
    func appendItem(indexPath: IndexPath, count: Int) {
        self.countOfItems[indexPath.row] = count
        self.presenter?.updateView()
        print(indexPath,count)

    }
}

