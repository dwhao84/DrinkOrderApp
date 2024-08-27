//
//  StoreLocationViewController.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/26.
//

import UIKit
import MapKit
import CoreLocation

class StoreLocationViewController: UIViewController {
    
    var stores: [Store] = []
    
    let locationMgr: CLLocationManager = CLLocationManager()
    var currentCoordinates: CLLocation?
    var selectedAnnotation: MKAnnotation?
    var coordinates: CLLocationCoordinate2D?
    
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
    
    let navigateBtn: UIButton = {
        let navigateBtn: UIButton = UIButton(type: .system)
        var config                         = UIButton.Configuration.plain()
        config.background.backgroundColor  = Colors.kebukeLightBlue
        config.baseForegroundColor         = Colors.white
        config.image                       = Images.locationFill
        config.background.imageContentMode = .scaleToFill
        config.buttonSize                  = UIButton.Configuration.Size.medium
        config.cornerStyle = .capsule
        navigateBtn.configuration = config
        navigateBtn.configurationUpdateHandler = { navigateBtn in
            navigateBtn.alpha = navigateBtn.isHighlighted ? 0.6 : 1
        }
        return navigateBtn
    } ()
    
    let routeBtn: UIButton = {
        let btn: UIButton = UIButton(type: .system)
        var config                         = UIButton.Configuration.plain()
        config.background.backgroundColor  = Colors.kebukeBrown
        config.baseForegroundColor         = Colors.white
        config.image                       = Images.route
        config.background.imageContentMode = .scaleAspectFit
        config.buttonSize                  = UIButton.Configuration.Size.medium
        config.cornerStyle = .capsule
        btn.configuration = config
        btn.configurationUpdateHandler = { btn in
            btn.alpha = btn.isHighlighted ? 0.6 : 1
        }
        return btn
    } ()
    
    // MARK: - Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Into the StoreLocationVC")
        
        setupUI()
        decodeTheStoresData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Set UI:
    func setupUI () {
        setupLocationManager()
        setupMapView()
        addConstraints()
        addTargets()
    }
    
    func addTargets () {
        navigateBtn.addTarget(self, action: #selector(navigationBtnTapped), for: .touchUpInside)
        routeBtn.addTarget(self, action: #selector(routeBtnDidTap), for: .touchUpInside)
    }
    
    @objc func navigationBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: navigationBtnTapped, get your current location.")
        setupLocationManager()
    }
    
    @objc func routeBtnDidTap(_ sender: UIButton) {
        print("DEBUG PRINT: RouteBtn")
        performNavigation()
    }
    
    func performNavigation() {
        // Create a placemark and map item for the destination
        let targetPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: coordinates!.latitude, longitude: coordinates!.longitude))
        let storeName = selectedAnnotation?.title
        
        let targetItem = MKMapItem(placemark: targetPlacemark)
        targetItem.name = storeName!
        
        // Get the current user location as a map item
        let userMapItem = MKMapItem.forCurrentLocation()
        
        // Build the routes from userMapItem to targetItem
        let routes = [userMapItem, targetItem]
        
        // Open the maps application with the directions
        MKMapItem.openMaps(with: routes, launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
    }
    
    // MARK: Get your current location.
    func setupLocationManager () {
        locationMgr.delegate = self
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest
        locationMgr.requestAlwaysAuthorization()
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.requestLocation()
        mapView.showsUserLocation = true
        currentCoordinates = locationMgr.location
        print(currentCoordinates!)
    }
    
    // MARK: - Set up Map View:
    func setupMapView () {
        mapView.delegate = self
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.0330, longitude:  121.5654), latitudinalMeters: 500, longitudinalMeters: 1500)
        mapView.setRegion(region, animated: true)
        mapView.register(KebukeAnnotationView.self, forAnnotationViewWithReuseIdentifier: KebukeAnnotationView.identifier)
        // Set the mapView property of scaleView
        scaleView.mapView = mapView
    }
    
    // MARK: - add Constraints
    func addConstraints() {
        self.view.addSubview(mapView)
        self.view.addSubview(scaleView)
        self.view.addSubview(navigateBtn)
        self.view.addSubview(routeBtn)
        
        // Disable autoresizing masks for all views to use Auto Layout
        mapView.translatesAutoresizingMaskIntoConstraints = false
        scaleView.translatesAutoresizingMaskIntoConstraints = false
        navigateBtn.translatesAutoresizingMaskIntoConstraints = false
        routeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // MapView constraints
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // ScaleView constraints
        NSLayoutConstraint.activate([
            scaleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -35),
            scaleView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -35)
        ])
        
        // Navigation Button constraints
        NSLayoutConstraint.activate([
            navigateBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            navigateBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            navigateBtn.widthAnchor.constraint(equalToConstant: 70),
            navigateBtn.heightAnchor.constraint(equalTo: navigateBtn.widthAnchor)
        ])
        
        // Route Button constraints - adjusted to be above the navigation button
        NSLayoutConstraint.activate([
            routeBtn.bottomAnchor.constraint(equalTo: navigateBtn.topAnchor, constant: -10), // 10 points space between buttons
            routeBtn.centerXAnchor.constraint(equalTo: navigateBtn.centerXAnchor), // Align centers
            routeBtn.widthAnchor.constraint(equalToConstant: 70),
            routeBtn.heightAnchor.constraint(equalTo: routeBtn.widthAnchor),
        ])
    }


    
    // MARK: - decode The Stores Data
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

// MARK: - Extension:
extension StoreLocationViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let kebukeAnnotation = annotation as? KebukeAnnotation else {
            return nil
        }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: KebukeAnnotationView.identifier, for: kebukeAnnotation) as? KebukeAnnotationView
        annotationView?.annotation = kebukeAnnotation
        annotationView?.configure(with: kebukeAnnotation.image, title: kebukeAnnotation.title ?? "")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }

        selectedAnnotation = annotation
        coordinates = annotation.coordinate
        print("DEBUG PRINT: GET location name: \(selectedAnnotation?.title! ?? ""), lat: \(coordinates!.latitude), long: \(coordinates!.longitude)")
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        // 帶有動畫的更新地圖視圖以顯示新的區域
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG PRINT: didFailWithError \(error.localizedDescription)")
    }
}

#Preview {
    let storeLocationViewController = StoreLocationViewController()
    return storeLocationViewController
}
