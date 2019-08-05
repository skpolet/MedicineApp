//
//  MapViewController.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 13/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit


class MapViewController: UIViewController {
    

    weak var coordinator: MapCoordinator?
    let viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationManager = LocationServices.instance
        locationManager.delegate = viewModel
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
