//
//  HomeRouter.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 25/01/2024.
//

import Foundation
import UIKit

class HomeRouter {
    
    weak var viewController: UIViewController?
    
    func navigateToSearchResult(from viewController: UIViewController, with products: [ProductModel]) {
        DispatchQueue.main.async {
            guard let navigationController = viewController.navigationController else { return }
            
            let searchResultViewController = SearchResultModule.build(with: products)
            navigationController.pushViewController(searchResultViewController, animated: true)
        }
    }
}

