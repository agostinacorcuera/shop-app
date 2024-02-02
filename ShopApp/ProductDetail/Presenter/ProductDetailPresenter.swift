//
//  ProductDetailPresenter.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 27/01/2024.
//

import Foundation
import UIKit

protocol ProductDetailPresenterProtocol {
    func viewDidLoad()
    func getProductData(productID: String)
}

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    weak var view: ProductDetailViewProtocol?
    var interactor: ProductDetailInteractorProtocol?
    var router: ProductDetailRouterProtocol?
    
    var productDetails: ProductModel?
    var productDescription: ProductDescription?
    
    
        
    init(view: ProductDetailViewProtocol) {
        self.view = view
    }

    
    func viewDidLoad() {

    }
    
    func getProductData(productID: String) {
        interactor?.getDescription(with: productID) { [weak self] productDescription, error in
            guard let self = self else { return }
            if let error = error {
                view?.showGenericErrorAlert()
                print("Error: \(error.localizedDescription)")
                return
            }
            self.productDescription = productDescription
            self.setData()
        }
        
        interactor?.getDetails(with: productID) { [weak self] productDetails, error in
            guard let self = self else { return }
            if let error = error {
                view?.showGenericErrorAlert()
                print("Error al obtener los detalles del producto: \(error.localizedDescription)")
                return
            }
            self.productDetails = productDetails
            self.setData()
        }
    }
  
    private func setData() {
        view?.setTitle(productDetails?.title ?? "")
        view?.setPrice(productDetails?.price ?? 0)
        view?.setDescription(productDescription?.description ?? "")
        view?.setImages(productDetails?.thumbnail ?? "")
    }
    
}
