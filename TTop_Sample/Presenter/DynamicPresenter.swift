//
//  DynamicPresenter.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//

import Foundation

class DynamicPresenter: DynamicListViewToPresenterProtocol {
    
    // MARK: - Properties
    weak var view: DynamicListPresenterToViewProtocol?
    var interactor: DynamicListPresenterToInteractorProtocol?
    var router: DynamicListPresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView() {
        interactor?.fetchItems()
    }
    
    func getDynamicListCount() -> Int? {
        return interactor?.items?.count
    }
    
    func getItem(index: Int) -> DynamicModel? {
        return interactor?.items?[index]
    }
}

// MARK: - LiveNewsListInteractorToPresenterProtocol
extension DynamicPresenter: DynamicListInteractorToPresenterProtocol {
    
    func itemsFetched() {
        view?.showItems()
    }
    
    func itemsFetchedFailed() {
        view?.showError()
    }
}

