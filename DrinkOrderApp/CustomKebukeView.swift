//
//  CustomKebukeView.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/17.
//

import UIKit

class CustomKebukeView: UIView {

    var bannerImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = Images.kebukeLogo
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstrants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstrants () {
        self.addSubview(bannerImageView)
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            bannerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            bannerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            bannerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bannerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

#Preview(traits: .fixedLayout(width: 428, height: 100), body: {
    let customKebukeView = CustomKebukeView()
    return customKebukeView
   })
