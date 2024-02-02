//
//  ProductModel.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 28/01/2024.
//

import Foundation
import UIKit

struct ProductModel: Decodable {
    let id: String?
    let title: String?
    let thumbnail: String?
    let price: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case price
    }
}

struct ProductResponse: Decodable {
    let results: [ProductModel]?
}

struct ProductDescription: Decodable {
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description = "plain_text"
    }
}

