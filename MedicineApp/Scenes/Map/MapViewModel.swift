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

protocol MapViewModelDelegate: class {
    func configureMap(camera: GMSCameraPosition)
    func configureSearchView(searchView: JKBottomSearchView)
    func configureSearchButton(button: UIButton)
    func configurePlusButton(button: UIButton)
    func configureMinusButton(button: UIButton)
}

class MapViewModel: NSObject, LocationCoordinatble {
    
    weak var delegate : MapViewModelDelegate?
    
    lazy var btnSearch = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnPlus = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnMinus = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnTarget = UIButton(type: UIButton.ButtonType.roundedRect)
    weak var mapView : GMSMapView!
    weak var searchView : JKBottomSearchView?
    let clinicInfoViewModel = ClinicInfoViewModel()
    let clinicsLoader = ClinicsLoader()
    var allClinics: [Clinics]?
    var allClinicsMap: [Clinics]?
    var allMarkers: [GMSMarker]  = []
    
    var coordinats : (long: Double?, lat: Double?)
    var zoom: Float = 15
    var isSerchViewOpened: Bool = true
    
//    func currentLocation(longitude: Double?, latitude: Double?) {
//        //if(coordinats.lat == nil && coordinats.long == nil){
//        coordinats.long = longitude
//        coordinats.lat = latitude
//
//    }

    func configuringMap(mapView: GMSMapView){

        self.mapView = mapView
        self.mapView.delegate = self
        
        clinicInfoViewModel.configureClinicInfo()
        

        
        
        let location = SharedLocation.instance
        //if let long = location.longitude, let lat = location.latitude{
            
//            let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: zoom)
//            delegate?.configureMap(camera: camera)
            configureButtonsInMap()
        
            /////
            
            clinicsLoader.getClinics(radius: 1000, longitude: location.longitude, latitude: location.latitude) { (clinics) in
                self.allClinics = clinics
                print("all\(clinics)")
                self.searchView?.delegate = self
                self.searchView?.dataSource = self
            }
        //}

    }
    func configureSearchView(searchView: JKBottomSearchView){
        self.searchView = searchView
        self.searchView?.placeholder = "Название клиники"
        self.searchView?.searchBarStyle = .minimal
        self.searchView?.tableView.backgroundColor = .clear
        self.searchView?.contentView.layer.cornerRadius = 10
        self.searchView?.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.searchView?.tableView.register(UINib(nibName: "AllClinics", bundle: nil), forCellReuseIdentifier: "AllClinics")
        delegate?.configureSearchView(searchView: self.searchView!)
    }
    
    func configureButtonsInMap(){
        delegate?.configureSearchButton(button: configureSearchButton())
        delegate?.configurePlusButton(button: configurePlusButton())
        delegate?.configureMinusButton(button: configureMinusButton())
        //configureCurrentTargetButton()
    }
    
    @objc func searchViewExpand(){
        if (searchView?.currentExpandedState == .closed){
            searchView?.toggleExpand(.fullyCollapsed, fast: true)
            isSerchViewOpened = true
        }else{
            searchView?.toggleExpand(.closed, fast: true)
            isSerchViewOpened = false
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
    
    func configureSearchButton() -> UIButton{
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

        return btnSearch
    }
    
    func configureCurrentTargetButton(){
        let btn: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
        btn.setTitle("me", for: UIControl.State.normal)
    }
    
    func configurePlusButton() ->UIButton{
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

        return btnPlus
    }
    
    func configureMinusButton() ->UIButton{
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

        return btnMinus
    }
    
    func convertDistance(distance: Int) ->(distanceInt: Int,distanceStr: String){
    
        if distance > 1000{
            return (distance/1000,"км")
        }else{
            return (distance,"м")
        }
    }
    
    func removeOutOfRange(position: CLLocationCoordinate2D, range: CLLocationDistance){
        
        for marker in self.allMarkers{
            let distance = GMSGeometryDistance(CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude), position)
            
            if(distance > range){
                let indexOfMarker = self.allMarkers.firstIndex(of: marker)
                self.allMarkers.remove(at: indexOfMarker!)
                marker.map = nil
            }
        }
    }
    
    func appendInRange(position: GMSCameraPosition, marker: GMSMarker , range: CLLocationDistance){
        let distance = GMSGeometryDistance(CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude), position.target)
        
        
        let markerInMap = self.allMarkers.filter { ($0.position.latitude == marker.position.latitude && $0.position.longitude ==  marker.position.longitude) && distance < range }
        if markerInMap.isEmpty {
            marker.map = self.mapView
            self.allMarkers.append(marker)
        }
        if(Double(round(10000*position.target.latitude)/10000) == Double(round(10000*marker.position.latitude)/10000) && Double(round(10000*position.target.longitude)/10000) == Double(round(10000*marker.position.longitude)/10000)){
            
            self.mapView.selectedMarker = marker
            marker.icon = UIImage(named: "Vector")
        }
    }
    
    func findMarker(marker: GMSMarker) ->GMSMarker{
        let indexOfMarker = self.allMarkers.firstIndex(of: marker)
        return self.allMarkers[indexOfMarker!]
    }
    
    func findMarkerWithLocation(location: CLLocationCoordinate2D){
        let markerInMap = self.allMarkers.filter { ($0.position.latitude == location.latitude && $0.position.longitude ==  location.longitude) }
        if markerInMap.count > 0{
            let marker = findMarker(marker: markerInMap[0])
            self.mapView.selectedMarker = marker
            marker.icon = UIImage(named: "Vector")
            
        }
    }
}
extension MapViewModel: JKBottomSearchDataSource, JKBottomSearchViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allClinics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllClinics", for: indexPath) as! AllClinics
        let clinic  = self.allClinics?[indexPath.row]
        cell.titleClinic.text = clinic?.title
        cell.adresClinic.text = clinic?.address
        cell.ratingClinic.text = clinic?.rating
        let distance = self.convertDistance(distance: clinic?.distance ?? 0)
        cell.distanceClinic.text = "\(distance.distanceInt)\(distance.distanceStr)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchView?.toggleExpand(.closed, fast: true)
        clinicInfoViewModel.toggleExpand(state: .fullyCollapsed)
        if let clinic  = self.allClinics?[indexPath.row]{
        let camera = GMSCameraPosition.camera(withLatitude: clinic.latitude!, longitude: clinic.longitude!, zoom: zoom)
            self.mapView.animate(to: camera)
            self.findMarkerWithLocation(location: camera.target)
        }
    }
    
}

extension MapViewModel: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        marker.icon = UIImage(named: "Vector")
        if(isSerchViewOpened == true){
            searchView?.toggleExpand(.closed, fast: true)
            clinicInfoViewModel.toggleExpand(state: .fullyCollapsed)
        }else{
            clinicInfoViewModel.toggleExpand(state: .fullyCollapsed)
        }
        return false
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        self.removeOutOfRange(position: position.target, range: 1000)
        
        clinicsLoader.getClinics(radius: 1, longitude: position.target.longitude, latitude: position.target.latitude) { (clinics) in

            for clinic in clinics{
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: clinic.latitude!, longitude: clinic.longitude!)
                marker.appearAnimation = GMSMarkerAnimation.pop
                marker.title = clinic.address
                marker.icon = UIImage(named: "Ellipse")
                marker.snippet = clinic.title

                self.appendInRange(position: position, marker: marker, range: 1000)
            }
            self.allClinicsMap = clinics
            print("allMarkers : \(self.allMarkers.count)")
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        marker.icon = UIImage(named: "Ellipse")
        clinicInfoViewModel.toggleExpand(state: .closed)
    }
}

