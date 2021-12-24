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

    // MARK: - Properties
    var presenter: DynamicListViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.setupTableView()
        // Do any additional setup after loading the view.
    }
    
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -100).isActive = true

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .blue
        tableView.tableFooterView = UIView()
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
    }


}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getDynamicListCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell
        let row = indexPath.row
        let item = presenter?.getItem(index: row)
        guard let title = item?.title else {
            return cell ?? UITableViewCell()
        }
//        cell?.setCell(title: title, author: author, description: description)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {}

// MARK: - LiveNewsListPresenterToViewProtocol
extension ViewController: DynamicListPresenterToViewProtocol {

    func showItems() {
        tableView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Items", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
