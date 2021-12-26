//
//  DynamicProtocols.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//

import Foundation
import UIKit

protocol DynamicListPresenterToViewProtocol: AnyObject {
    func showItems()
    func showError()
}

protocol DynamicListInteractorToPresenterProtocol: AnyObject {
    func itemsFetched()
    func itemsFetchedFailed()
}

protocol DynamicListPresenterToInteractorProtocol: AnyObject {
    var presenter: DynamicListInteractorToPresenterProtocol? { get set }
    var items: [DynamicModel]? { get }
    
    func fetchItems()
}

protocol DynamicListViewToPresenterProtocol: AnyObject {
    var view: DynamicListPresenterToViewProtocol? { get set }
    var interactor: DynamicListPresenterToInteractorProtocol? { get set }
    var router: DynamicListPresenterToRouterProtocol? { get set }
    
    func updateView()
    func getDynamicListCount() -> Int?
    func getItem(index: Int) -> DynamicModel?
}

protocol DynamicListPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

protocol TableManager {
    func appendBox(count: Int)
    func appendItem(indexPath: IndexPath, count: Int)
}
