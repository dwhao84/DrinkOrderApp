//
//  ProductCollectionViewCell.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/12.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ProductCollectionViewCell"
    
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureProductImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProductImageView() {
        self.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }
    
    func configure(with image: UIImage?) {
        productImageView.image = image
    }
}

