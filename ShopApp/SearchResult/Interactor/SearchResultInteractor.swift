//
//  ProductsInteractor.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 25/01/2024.
//

import Foundation
import PromiseKit

protocol SearchResultInteractorProtocol {
    func performSearch(with text: String, completion: @escaping ([ProductModel]?, Error?) -> Void)
}

struct SearchResultInteractor: SearchResultInteractorProtocol {
    func performSearch(with text: String, completion: @escaping ([ProductModel]?, Error?) -> Void) {
        let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(text)")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "HomeInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            if let decoded = try? JSONDecoder().decode(ProductResponse.self, from: data) {
                completion(decoded.results, nil)
            } else {
                completion(nil, NSError(domain: "HomeInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error decoding data"]))
            }

        }.resume()
    }
}
