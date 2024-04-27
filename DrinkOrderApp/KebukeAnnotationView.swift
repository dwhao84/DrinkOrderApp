import UIKit
import MapKit

class KebukeAnnotationView: MKAnnotationView {
    
    static let identifier = "KebukeAnnotationView"
    
    private var kebukeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 60, height: 60)  // Adjusted for better visibility
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        canShowCallout = true
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(kebukeImageView)
        addSubview(storeNameLabel)
        
        NSLayoutConstraint.activate([
            kebukeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            kebukeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            kebukeImageView.widthAnchor.constraint(equalToConstant: 40),
            kebukeImageView.heightAnchor.constraint(equalToConstant: 40),
            
            storeNameLabel.topAnchor.constraint(equalTo: kebukeImageView.bottomAnchor, constant: 5),
            storeNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            storeNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func configure(with image: UIImage?, title: String) {
        kebukeImageView.image = image
        storeNameLabel.text = title
    }
}
