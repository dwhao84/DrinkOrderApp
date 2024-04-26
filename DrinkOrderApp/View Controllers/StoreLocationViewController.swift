//
//  StoreLocationViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/26.
//

import UIKit
import MapKit

class StoreLocationViewController: UIViewController {

    var mapView: MKMapView = {
        let mapView: MKMapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    } ()
    
    var scaleView: MKScaleView = {
        let scaleView: MKScaleView = MKScaleView()
        scaleView.scaleVisibility = .adaptive
        scaleView.legendAlignment = .trailing
        scaleView.translatesAutoresizingMaskIntoConstraints = false
        return scaleView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addConstraints()
    }
    
    func setupMapView () {
        mapView.delegate = self
        mapView.region = CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
    }
    
    func addConstraints () {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}

extension StoreLocationViewController: MKMapViewDelegate {
    
}

#Preview {
    let storeLocationViewController = StoreLocationViewController()
    return storeLocationViewController
}
