//
//  ShopAppUI.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 31/01/2024.
//

import Foundation
import UIKit

class LoadingViewManager {
    
    static func configureLoadingView(in view: UIView) -> UIActivityIndicatorView {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.color = .gray
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingView.isHidden = true
        
        return loadingView
    }
    
    static func showLoadingView(_ loadingView: UIActivityIndicatorView) {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    static func hideLoadingView(_ loadingView: UIActivityIndicatorView) {
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
}
