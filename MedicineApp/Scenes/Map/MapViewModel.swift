//
//  MapViewModel.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 15/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import GoogleMaps
import JKBottomSearchView
import SnapKit

class MapViewModel: NSObject, LocationCoordinatble {
    
    lazy var btnSearch = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnPlus = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnMinus = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnTarget = UIButton(type: UIButton.ButtonType.roundedRect)
    var mapView : GMSMapView!
    weak var searchView : JKBottomSearchView?
    
    var coordinats : (long: Double?, lat: Double?)
    var zoom: Float = 15
    
    func currentLocation(longitude: Double?, latitude: Double?) {
        coordinats.long = longitude
        coordinats.lat = latitude
        let camera = GMSCameraPosition.camera(withLatitude: coordinats.lat!, longitude: coordinats.long!, zoom: zoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        
        // таблица с клиниками
        let searchView = JKBottomSearchView()
        configureBottomView(view: searchView)
        
        searchView.dataSource = self
        searchView.delegate = self
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            searchView.toggleExpand(.closed, fast: true)
//        }
        
        
        if let topVC = UIApplication.getTopViewController() {
            topVC.view = mapView
            configureButtonsInMap()
            topVC.view.addSubview(searchView)
        }
        
    }

    func configureMap(){
        
    }
    
    func configureBottomView(view: JKBottomSearchView){
        view.placeholder = "Название клиники"
        view.searchBarStyle = .minimal
        view.tableView.backgroundColor = .clear
        view.contentView.layer.cornerRadius = 10
        view.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        searchView = view
    }
    
    func configureButtonsInMap(){
        configureSearchButton()
        configurePlusButton()
        configureMinusButton()
        //configureCurrentTargetButton()
    }
    
    @objc func searchViewExpand(){
        if (searchView?.currentExpandedState == .closed){
            searchView?.toggleExpand(.fullyCollapsed, fast: true)
        }else{
            searchView?.toggleExpand(.closed, fast: true)
        }
    }
    
    @objc func increaseMap(){
        zoom = zoom + 1
        mapView.animate(toZoom: zoom)
    }
    
    @objc func decreaseMap(){
        zoom = zoom - 1
        mapView.animate(toZoom: zoom)
    }
    
    func configureSearchButton(){
        //let btn: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
        btnSearch.frame = CGRect()
        //btn.setTitle("search", for: UIControl.State.normal)
        btnSearch.setImage(UIImage(named: "loupe"), for: UIControl.State.normal)
        btnSearch.addTarget(self, action: #selector(searchViewExpand), for: .touchUpInside)
        btnSearch.backgroundColor = .white
        btnSearch.tintColor = .black
        btnSearch.layer.cornerRadius = 25
        btnSearch.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnSearch.layer.shadowOpacity = 0.2
        btnSearch.layer.shadowRadius = 0.5
        if let topVC = UIApplication.getTopViewController() {
            topVC.view.addSubview(btnSearch)
            btnSearch.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(50)
                //make.center.equalTo(topVC.view)
                make.bottom.equalTo(topVC.view).offset(-150)
                make.right.equalTo(topVC.view).offset(-20)
            }
        }
    }
    
    func configureCurrentTargetButton(){
        let btn: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
        btn.setTitle("me", for: UIControl.State.normal)
    }
    
    func configurePlusButton(){
        //let btn: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
        btnPlus.frame = CGRect()
        btnPlus.setImage(UIImage(named: "add"), for: UIControl.State.normal)
        btnPlus.addTarget(self, action: #selector(increaseMap), for: .touchUpInside)
        btnPlus.backgroundColor = .white
        btnPlus.tintColor = .black
        btnPlus.layer.cornerRadius = 25
        btnPlus.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnPlus.layer.shadowOpacity = 0.2
        btnPlus.layer.shadowRadius = 0.5
        if let topVC = UIApplication.getTopViewController() {
            topVC.view.addSubview(btnPlus)
            btnPlus.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(50)
                //make.center.equalTo(topVC.view)
                make.top.equalTo(btnSearch).offset(-65)
                make.right.equalTo(topVC.view).offset(-20)
            }
        }
    }
    
    func configureMinusButton(){
        //let btn: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
        btnMinus.frame = CGRect()
        btnMinus.setImage(UIImage(named: "substract"), for: UIControl.State.normal)
        btnMinus.addTarget(self, action: #selector(decreaseMap), for: .touchUpInside)
        btnMinus.backgroundColor = .white
        btnMinus.tintColor = .black
        btnMinus.layer.cornerRadius = 25
        btnMinus.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnMinus.layer.shadowOpacity = 0.2
        btnMinus.layer.shadowRadius = 0.5
        if let topVC = UIApplication.getTopViewController() {
            topVC.view.addSubview(btnMinus)
            btnMinus.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(50)
                //make.center.equalTo(topVC.view)
                make.top.equalTo(btnPlus).offset(-65)
                make.right.equalTo(topVC.view).offset(-20)
            }
        }
    }
}
extension MapViewModel: JKBottomSearchDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension MapViewModel: JKBottomSearchViewDelegate{
    
}
