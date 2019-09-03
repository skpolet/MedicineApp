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
import SnapKit

class MapViewController: UIViewController {
    
    var btnSearch: UIButton?
    var btnPlus: UIButton?
    var btnMinus: UIButton?
    var btnTarget: UIButton?
    
    var mapView:GMSMapView?
    
    weak var coordinator: MapCoordinator?
    let viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = SharedLocation.instance
        
        viewModel.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15)
        mapView = GMSMapView.map(withFrame:self.view.frame, camera: camera)
        mapView?.center = self.view.center
        mapView?.isMyLocationEnabled = true
        self.view.addSubview(mapView!)
        viewModel.configuringMap(mapView: mapView!)
        
        let searchView = JKBottomSearchView()
        viewModel.configureSearchView(searchView: searchView)
        
        

        //searchView.dataSource = viewModel
        //searchView.delegate = viewModel
        
//        let locationServices = LocationServices.instance
//        locationServices.delegate = viewModel
        


    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

}
extension MapViewController: MapViewModelDelegate{
    
//    func configureMap(camera: GMSCameraPosition) {
//        mapView?.animate(to: camera)
//    }
    
    func configureSearchView(searchView: JKBottomSearchView) {

        self.mapView?.addSubview(searchView)

    }
    
    func configureSearchButton(button: UIButton){
        self.mapView!.addSubview(button)
        self.btnSearch = button
        button.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.bottom.equalTo(self.mapView!).offset(-150)
            make.right.equalTo(self.mapView!).offset(-20)
        }
    }
    
    func configurePlusButton(button: UIButton){
        self.mapView!.addSubview(button)
        self.btnPlus = button
        button.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.top.equalTo(self.btnSearch!).offset(-65)
            make.right.equalTo(self.view).offset(-20)
        }
    }
    
    func configureMinusButton(button: UIButton){
        self.mapView!.addSubview(button)
        self.btnMinus = button
        button.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.top.equalTo(self.btnPlus!).offset(-65)
            make.right.equalTo(self.view).offset(-20)
        }
    }
    
    func configureTargetButton(button: UIButton) {
        self.mapView!.addSubview(button)
        self.btnTarget = button
        button.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.top.equalTo(self.btnMinus!).offset(-65)
            make.right.equalTo(self.view).offset(-20)
        }
    }
    
    
}
