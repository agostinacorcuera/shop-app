//
//  SearchResultCell.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 27/01/2024.
//

import Foundation
import UIKit
import AlamofireImage

class SearchResultCell: UITableViewCell {
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        
    // MARK: - Setup
    
    private func setupViews() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellLabel)
        
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor),
        ])
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        cellLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        let verticalSpacing = NSLayoutConstraint(item: cellImageView, 
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: cellLabel,
                                                 attribute: .centerY,
                                                 multiplier: 1, constant: 0)
        
        contentView.addConstraint(verticalSpacing)
        
        contentView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        contentView.backgroundColor = .white
    }

    
    // MARK: - Configuration
    
    func configure(withImageURL thumbnail: String?, text: String?) {
        if let imageURL = thumbnail, let url = URL(string: imageURL) {
            var convertedURLString = imageURL
            
            if imageURL.hasPrefix("http://") {
                convertedURLString = "https://" + imageURL.dropFirst(7)
            }
            
            if let convertedURL = URL(string: convertedURLString) {
                cellImageView.af.setImage(withURL: convertedURL, placeholderImage: UIImage(named: "placeholder"))
                cellLabel.text = text
            } else {
                cellImageView.image = UIImage(named: "placeholder")
            }
        } else {
            cellImageView.image = UIImage(named: "placeholder")
        }
        
        contentView.invalidateIntrinsicContentSize()
    }

}

