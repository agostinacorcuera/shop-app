//
//  ProductListModule.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 25/01/2024.
//

import Foundation
import UIKit

class SearchResultModule {
    static func build(with products: [ProductModel]) -> UIViewController {
            
            let view = SearchResultViewController()
            let interactor = SearchResultInteractor()
            let router = SearchResultRouter()
            
            let presenter = SearchResultPresenter(view: view, interactor: interactor)
            presenter.interactor = interactor
            presenter.view = view
            presenter.router = router
            
            view.presenter = presenter
            view.updateTableView(withData: products)
            
            return view
        }
}
