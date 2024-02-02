//
//  ProductsPresenter.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 25/01/2024.
//

import Foundation
import UIKit

protocol SearchResultPresenterProtocol {
    func searchButtonTapped(with text: String)
    func didSelectRow(withProduct productID: String, at indexPath: IndexPath)
}

class SearchResultPresenter: SearchResultPresenterProtocol {
    weak var view: SearchResultViewProtocol?
    var interactor: SearchResultInteractorProtocol?
    var router: SearchResultRouterProtocol?
    
    var products: [ProductModel]

    init(view: SearchResultViewProtocol, interactor: SearchResultInteractorProtocol) {
        self.view = view
        self.interactor = interactor
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
                self?.reloadTableView(with: products ?? [])
            }
        }
    }
    
    func reloadTableView(with products: [ProductModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoadingView()
            self?.view?.updateTableView(withData: products)
        }
    }

    func didSelectRow(withProduct productID: String, at indexPath: IndexPath) {
        router?.navigateToProductDetail(from: view as! UIViewController, with: productID)
    }
}
