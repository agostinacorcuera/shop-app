//
//  ProductDetailModule.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 28/01/2024.
//

import Foundation
import UIKit

class ProductDetailModule {
    static func build(with productID: String) -> UIViewController {
        
        let view = ProductDetailViewController(productID: productID)
        let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter()
        
        let presenter = ProductDetailPresenter(view: view)
        
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        
        return view
    }
}
