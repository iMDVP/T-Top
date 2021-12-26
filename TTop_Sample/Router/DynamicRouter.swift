//
//  DynamicRouter.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//


import Foundation
import UIKit

class DynamicRouter: DynamicListPresenterToRouterProtocol {
    
    // MARK: - Methods
    
    class func createModule() -> UIViewController {
        let view = ViewController()
        let presenter: DynamicListViewToPresenterProtocol & DynamicListInteractorToPresenterProtocol = DynamicPresenter()
        let interactor: DynamicListPresenterToInteractorProtocol = DynamicInteractor()
        let router: DynamicListPresenterToRouterProtocol = DynamicRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view

    }

}
