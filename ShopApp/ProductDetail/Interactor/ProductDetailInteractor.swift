//
//  ProductDetailInteractor.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 27/01/2024.
//

import Foundation
import UIKit

import Foundation
import UIKit

protocol ProductDetailInteractorProtocol {
    func getDescription(with itemId: String, completion: @escaping (ProductDescription?, Error?) -> Void)
    func getDetails(with itemId: String, completion: @escaping (ProductModel?, Error?) -> Void)
}
    
class ProductDetailInteractor: ProductDetailInteractorProtocol {
    var presenter: ProductDetailPresenterProtocol?
    var productDescription: ProductDescription?
    var productModel: ProductModel?
    
    // Sesión compartida de URLSession
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func getDescription(with itemId: String, completion: @escaping (ProductDescription?, Error?) -> Void) {
        let url = URL(string: "https://api.mercadolibre.com/items/\(itemId)/description")!
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "ProductDetailInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            if let decoded = try? JSONDecoder().decode(ProductDescription.self, from: data) {
                completion(decoded, nil)
            } else {
                completion(nil, NSError(domain: "ProductDetailInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error decoding data"]))
            }

        }.resume()
    }
    
    func getDetails(with itemId: String, completion: @escaping (ProductModel?, Error?) -> Void) {
        let url = URL(string: "https://api.mercadolibre.com/items/\(itemId)")!
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "ProductDetailInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            if let decoded = try? JSONDecoder().decode(ProductModel.self, from: data) {
                completion(decoded, nil)
            } else {
                completion(nil, NSError(domain: "ProductDetailInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error decoding data"]))
            }

        }.resume()
    }
}
