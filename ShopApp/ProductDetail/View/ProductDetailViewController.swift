//
//  ProductDetailViewController.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 27/01/2024.
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func setPrice(_ price: Int)
    func setDescription(_ description: String)
    func setImages(_ thumbnail: String)
    func showGenericErrorAlert()
}

class ProductDetailViewController: UIViewController, ProductDetailViewProtocol {
    
    var presenter: ProductDetailPresenterProtocol?
    var productID: String
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(productID: String) {
        self.productID = productID
        super.init(nibName: nil, bundle: nil)
        self.presenter = ProductDetailPresenter(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getProductData(productID: productID)
        presenter?.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        
        setupScrollView()
        setupTitleLabel()
        setProductImage()
        setupPriceLabel()
        setupDescriptionLabel()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        
        let topInset = navigationController?.navigationBar.frame.maxY ?? 0
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: topInset), 
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .black
        let maxWidth = view.bounds.width - 50
            titleLabel.preferredMaxLayoutWidth = maxWidth
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25)
        ])
    }
    
    private func setProductImage() {
        scrollView.addSubview(productImage)
        
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            productImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            productImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            productImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    
    private func setupPriceLabel() {
        scrollView.addSubview(priceLabel)
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            priceLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25)
        ])
    }
    
    private func setupDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        
        descriptionLabel.textColor = .gray
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    func setTitle(_ title: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
        }
    }

    func setPrice(_ price: Int) {
        DispatchQueue.main.async {
            self.priceLabel.text = "$ " + String(price)
        }
    }

    func setDescription(_ description: String) {
        DispatchQueue.main.async {
            self.descriptionLabel.text = description
        }
    }

    func setImages(_ thumbnail: String) {
        DispatchQueue.main.async {
            if !thumbnail.isEmpty, let convertedURL = URL(string: thumbnail) {
                let imageURL: URL
                if thumbnail.hasPrefix("http://") {
                    imageURL = URL(string: "https://" + thumbnail.dropFirst(7))!
                } else {
                    imageURL = convertedURL
                }
                
                self.productImage.af.setImage(withURL: imageURL, placeholderImage: UIImage(named: "placeholder"))
            } else {
                self.productImage.image = UIImage(named: "placeholder")
            }
        }
    }
    
    func showGenericErrorAlert() {
        DispatchQueue.main.async {
            AlertManager.showAlert(type: .genericError, in: self)
        }
    }
}
