//
//  HomePresenter.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 25/01/2024.
//

import Foundation
import UIKit

protocol HomePresenterProtocol {
    func searchButtonTapped(with text: String)
    func navigateToSearchResult(with products: [ProductModel])
}

class HomePresenter: HomePresenterProtocol {

    weak var view: HomeViewController?
    var interactor: HomeInteractor?
    var router: HomeRouter?
    
    var products: [ProductModel]

    init(view: HomeViewController, interactor: HomeInteractor, router: HomeRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.products = []
    }

    func searchButtonTapped(with text: String) {
        view?.showLoadingView()
        interactor?.performSearch(with: text) { [weak self] (products, error) in
            if let error = error {
                self?.view?.hideLoadingView()
                self?.view?.showGenericErrorAlert()
                print("Error al realizar la búsqueda: \(error.localizedDescription)")
            } else {
                self?.view?.hideLoadingView()
                self?.navigateToSearchResult(with: products ?? [])
                
            }
        }
    }
    
    func navigateToSearchResult(with products: [ProductModel]) {
        router?.navigateToSearchResult(from: view!, with: products)
    }
}


