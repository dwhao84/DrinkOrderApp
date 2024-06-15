//
//  EmptyStateView.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/6/15.
//

import UIKit

class EmptyStateView: UIView {

    private let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: Images.doc)
        imageView.tintColor = Colors.kebukeBrown
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let emptyStateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "尚未有任何資料"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = Colors.kebukeBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    // MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    func setupUI () {
        self.backgroundColor = Colors.kebukeLightBlue
        configStackView()
    }

    func configStackView () {
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(emptyStateLabel)
        
        // Constraint stackView
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

#Preview(traits: .fixedLayout(width: 428, height: 820), body: {
    let emptyStateView = EmptyStateView()
    return emptyStateView
})
