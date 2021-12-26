//
//  DynamicInteractor.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//

import Foundation


class DynamicInteractor: DynamicListPresenterToInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: DynamicListInteractorToPresenterProtocol?
    var items: [DynamicModel]?
    
    // MARK: - Methods
    func fetchItems() {
        self.items = Bundle.main.decode([DynamicModel].self, from: "data.json")
        self.presenter?.itemsFetched()        
    }
    
}



