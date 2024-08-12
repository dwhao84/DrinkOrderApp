//
//  StoreLocationViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/26.
//

import UIKit
import MapKit

class StoreLocationViewController: UIViewController {
    
    var stores: [Store] = []
    
    let mapView: MKMapView = {
        let mapView: MKMapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    } ()
    
    let scaleView: MKScaleView = {
        let scaleView: MKScaleView = MKScaleView()
        scaleView.scaleVisibility = .visible
        scaleView.legendAlignment = .trailing
        scaleView.translatesAutoresizingMaskIntoConstraints = false
        return scaleView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Into the StoreLocationVC")
        
        setupUI()
        decodeTheStoresData()
    }
    
    func setupUI () {
//        self.tabBarController?.tabBar.isHidden = true
        setupMapView()
        addConstraints()
    }
    
    func setupMapView () {
        mapView.delegate = self
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.0330, longitude:  121.5654), latitudinalMeters: 500, longitudinalMeters: 1500)
        mapView.setRegion(region, animated: true)
        mapView.register(KebukeAnnotationView.self, forAnnotationViewWithReuseIdentifier: KebukeAnnotationView.identifier)
        // Set the mapView property of scaleView
        scaleView.mapView = mapView
    }
    
    func addConstraints () {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(scaleView)
        NSLayoutConstraint.activate([
            scaleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            scaleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35)
        ])
    }
    
    func decodeTheStoresData () {
        guard let url = Bundle.main.url(forResource: "KebukeStoreJson", withExtension: "json") else {
            print("Unable to find the data.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            stores = try decoder.decode([Store].self, from: data)
            
            // Add stores annotation's data into the mapView.
            for store in stores {
                let coordinate = CLLocationCoordinate2D(latitude: store.latitude, longitude: store.longitude)
                let annotation = KebukeAnnotation(coordinate: coordinate, title: store.name, image: Images.mapIcon)
                mapView.addAnnotation(annotation)
                print("DEBUG PRINT: Store: \(store.name), Latitude: \(store.latitude), Longitude: \(store.longitude)")
            }
        } catch {
            print("DEBUG PRINT: \(error.localizedDescription)")
        }
    }
}

extension StoreLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let kebukeAnnotation = annotation as? KebukeAnnotation else {
            return nil
        }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: KebukeAnnotationView.identifier, for: kebukeAnnotation) as? KebukeAnnotationView
        annotationView?.annotation = kebukeAnnotation
        annotationView?.configure(with: kebukeAnnotation.image, title: kebukeAnnotation.title ?? "")
        
        return annotationView
    }
}




#Preview {
    let storeLocationViewController = StoreLocationViewController()
    return storeLocationViewController
}
