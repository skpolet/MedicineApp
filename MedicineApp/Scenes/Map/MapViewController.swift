//
//  MapViewController.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 13/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit
import GoogleMaps
import JKBottomSearchView

class MapViewController: UIViewController, LocationCoordinatble {
    
    @IBOutlet var mapView: UIView!
    var coordinats : (long: Double?, lat: Double?)
    weak var coordinator: MapCoordinator?
    let viewModel = MapViewModel()
    
    func currentLocation(longitude: Double?, latitude: Double?) {
        coordinats.long = longitude
        coordinats.lat = latitude
        let camera = GMSCameraPosition.camera(withLatitude: coordinats.lat!, longitude: coordinats.long!, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // таблица с клиниками
        let searchView = JKBottomSearchView()
        viewModel.configureBottomView(view: searchView)
        
        searchView.dataSource = viewModel
        searchView.delegate = viewModel
        
        view.addSubview(searchView)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.edgesForExtendedLayout = []
        let locationManager = LocationServices.instance
        locationManager.delegate = self
        

    }

}
