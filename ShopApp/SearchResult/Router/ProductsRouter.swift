//
//  ProductsRouter.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 25/01/2024.
//

import Foundation
import UIKit

protocol SearchResultRouterProtocol: AnyObject {
    func navigateToProductDetail(from viewController: UIViewController, with productID: String)
}

class SearchResultRouter: SearchResultRouterProtocol {
    
    func navigateToProductDetail(from viewController: UIViewController, with productID: String) {
        guard let navigationController = viewController.navigationController else { return }
        
        let view = ProductDetailModule.build(with: productID)
        viewController.navigationController?.pushViewController(view, animated: true)
    }
    
}
