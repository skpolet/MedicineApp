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
    //func configureMap(camera: GMSCameraPosition)
    func configureSearchView(searchView: JKBottomSearchView)
    func configureSearchButton(button: UIButton)
    func configurePlusButton(button: UIButton)
    func configureMinusButton(button: UIButton)
    func configureTargetButton(button: UIButton)
}

protocol SelectedClinicIdDelegate: class {
    func clinicId(id: Int)
}

class MapViewModel: NSObject, LocationCoordinatble {
    
    weak var delegate : MapViewModelDelegate?
    weak var delegateClinicID : SelectedClinicIdDelegate?
    
    lazy var btnSearch = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnPlus = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnMinus = UIButton(type: UIButton.ButtonType.roundedRect)
    lazy var btnTarget = UIButton(type: UIButton.ButtonType.roundedRect)
    weak var mapView : GMSMapView!
    weak var searchView : JKBottomSearchView?
    let clinicInfoViewModel = ClinicInfoViewModel()
    let clinicsLoader = ClinicsLoader()
    var allClinics: [Clinic]?
    var allClinicsMap: [Clinic]?
    var allClinicsSearchArray: [Clinic]?
    var allMarkers: [GMSMarker]  = []
    var savedLastMarker : GMSMarker?
    var clinic : Clinic?
    
    var coordinats : (long: Double?, lat: Double?)
    var zoom: Float = 15
    var isSerchViewOpened: Bool = true
    var isInfoClinicViewOpened: Bool = true
    
//    func currentLocation(longitude: Double?, latitude: Double?) {
//        //if(coordinats.lat == nil && coordinats.long == nil){
//        coordinats.long = longitude
//        coordinats.lat = latitude
//
//    }
    
    @objc func closeClinicInfo(_ notification: NSNotification) {
        
        if(isInfoClinicViewOpened == true){
            
            guard let lastMarker = savedLastMarker else {
                return
            }
        self.getCurrentClinic(marker: lastMarker) { (clinics) in
            lastMarker.icon = clinics.highlight == 1 ? UIImage(named: "EliteNotSelected") : UIImage(named: "NotSelected")
            self.isInfoClinicViewOpened = false
            self.mapView.selectedMarker = nil
        }
        }
        
    }

    func configuringMap(mapView: GMSMapView){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeClinicInfo(_:)), name: NSNotification.Name(rawValue: "closeClinicInfo"), object: nil)

        self.mapView = mapView
        self.mapView.delegate = self
        
        clinicInfoViewModel.configureClinicInfo()
        
        for gesture in self.mapView.gestureRecognizers! {
            mapView.removeGestureRecognizer(gesture)
        }

        
        
        self.delegateClinicID = clinicInfoViewModel
        let location = SharedLocation.instance
        //if let long = location.longitude, let lat = location.latitude{
            
//            let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: zoom)
//            delegate?.configureMap(camera: camera)
            configureButtonsInMap()
        
            /////
            
            clinicsLoader.getClinics(radius: 1000, longitude: location.longitude, latitude: location.latitude) { (clinics) in
                self.allClinics = clinics
                self.allClinicsSearchArray = clinics
                self.searchView?.delegate = self
                self.searchView?.dataSource = self
            }
        //}

    }
    func configureSearchView(searchView: JKBottomSearchView){
        self.searchView = searchView
        self.searchView?.placeholder = "Название клиники"
        self.searchView?.searchBarStyle = .minimal
        self.searchView?.enablesReturnKeyAutomatically = true
        self.searchView?.showsCancelButton = true
        self.searchView?.slowExpandingTime = 0.25
        
        self.searchView?.tableView.backgroundColor = .clear
        self.searchView?.contentView.layer.cornerRadius = 10
        self.searchView?.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.searchView?.tableView.register(UINib(nibName: "AllClinics", bundle: nil), forCellReuseIdentifier: "AllClinics")
        delegate?.configureSearchView(searchView: self.searchView!)
        
        //self.searchView?.delegate = self
        //print("delegate.: \(String(describing: self.searchView?.searchBar.delegate))")
    }
    
    func configureButtonsInMap(){
        delegate?.configureSearchButton(button: configureSearchButton())
        delegate?.configurePlusButton(button: configurePlusButton())
        delegate?.configureMinusButton(button: configureMinusButton())
        delegate?.configureTargetButton(button: configureCurrentTargetButton())
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
        let zoom = mapView.camera.zoom + 1
        mapView.animate(toZoom: zoom)
    }
    
    @objc func decreaseMap(){
        let zoom = mapView.camera.zoom - 1
        mapView.animate(toZoom: zoom)
    }
    
    @objc func personTargetMap(){
        let sharedLocation = SharedLocation.instance
        let location = CLLocationCoordinate2D(latitude: sharedLocation.latitude, longitude: sharedLocation.longitude)
        mapView.animate(toLocation: location)

    }
    
    func configureSearchButton() -> UIButton{
        //let btn: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
        btnSearch.frame = CGRect()
        //btn.setTitle("search", for: UIControl.State.normal)
        btnSearch.setImage(UIImage(named: "loupe"), for: UIControl.State.normal)
        btnSearch.addTarget(self, action: #selector(searchViewExpand), for: .touchUpInside)
        btnSearch.backgroundColor = .white
        btnSearch.tintColor = .black
        btnSearch.alpha = 0.8
        btnSearch.layer.cornerRadius = 25
        btnSearch.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnSearch.layer.shadowOpacity = 0.2
        btnSearch.layer.shadowRadius = 0.5

        return btnSearch
    }
    
    func configureCurrentTargetButton() ->UIButton{
        btnTarget.frame = CGRect()
        btnTarget.setImage(UIImage(named: "navigation"), for: UIControl.State.normal)
        btnTarget.addTarget(self, action: #selector(personTargetMap), for: .touchUpInside)
        btnTarget.backgroundColor = .white
        btnTarget.tintColor = .black
        btnTarget.alpha = 0.8
        btnTarget.layer.cornerRadius = 25
        btnTarget.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnTarget.layer.shadowOpacity = 0.2
        btnTarget.layer.shadowRadius = 0.5
        
        return btnTarget
    }
    
    func configurePlusButton() ->UIButton{
        btnPlus.frame = CGRect()
        btnPlus.setImage(UIImage(named: "add"), for: UIControl.State.normal)
        btnPlus.addTarget(self, action: #selector(increaseMap), for: .touchUpInside)
        btnPlus.backgroundColor = .white
        btnPlus.tintColor = .black
        btnPlus.alpha = 0.8
        btnPlus.layer.cornerRadius = 25
        btnPlus.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnPlus.layer.shadowOpacity = 0.2
        btnPlus.layer.shadowRadius = 0.5

        return btnPlus
    }
    
    func configureMinusButton() ->UIButton{
        btnMinus.frame = CGRect()
        btnMinus.setImage(UIImage(named: "substract"), for: UIControl.State.normal)
        btnMinus.addTarget(self, action: #selector(decreaseMap), for: .touchUpInside)
        btnMinus.backgroundColor = .white
        btnMinus.tintColor = .black
        btnMinus.alpha = 0.8
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
            self.getCurrentClinic(marker: marker) { (clinic) in
                marker.icon = clinic.highlight == 1 ? UIImage(named: "EliteSelected") : UIImage(named: "Selected")
                self.isInfoClinicViewOpened = true
                self.savedLastMarker = marker
                self.delegateClinicID?.clinicId(id: clinic.id!)
            }
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
            //marker.icon = UIImage(named: "Selected")
            self.getCurrentClinic(marker: marker) { (clinic) in
                marker.icon = clinic.highlight == 1 ? UIImage(named: "EliteSelected") : UIImage(named: "Selected")
                self.isInfoClinicViewOpened = true
                self.savedLastMarker = marker
                self.delegateClinicID?.clinicId(id: clinic.id!)
            }
            
        }
    }
    
    func getCurrentClinic(marker: GMSMarker, completion: @escaping (_ result: Clinic)->()){
        let clinicsFilter = self.allClinics?.filter { $0.latitude == marker.position.latitude && $0.longitude ==  marker.position.longitude}

        if let clinics = clinicsFilter{
            if(clinics.count > 0){
                completion(clinics[0])
            }
        }
    }
}
extension MapViewModel: JKBottomSearchDataSource, JKBottomSearchViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allClinicsSearchArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllClinics", for: indexPath) as! AllClinics
        let clinic  = self.allClinicsSearchArray?[indexPath.row]
        cell.titleClinic.text = clinic?.title
        cell.adresClinic.text = clinic?.address
        cell.ratingClinic.text = "\(clinic?.rating ?? 0)"
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
        if let clinic  = self.allClinicsSearchArray?[indexPath.row]{
        let camera = GMSCameraPosition.camera(withLatitude: clinic.latitude!, longitude: clinic.longitude!, zoom: zoom)
            self.mapView.animate(to: camera)
            self.findMarkerWithLocation(location: camera.target)
            tableView.deselectRow(at: indexPath, animated: true)
            self.searchView?.searchBarTextField.resignFirstResponder()
        }
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //guard !searchText.isEmpty  else { allClinicsSearchArray = allClinics; return }
//        print("begin1243")
//
//        allClinics = allClinics?.filter({ clinic -> Bool in
//            return clinic.title!.lowercased().contains(searchText.lowercased())
//        })
//        self.searchView?.tableView.reloadData()
//    }
    
    // MARK : SearchBar Controlelr Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchView?.toggleExpand(.fullyExpanded)
        filterContentForSearchText (searchText)
    }
    
    func searchBarIsEmpty() -> Bool {
        return (self.searchView?.searchBarTextField.text?.isEmpty)!
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        allClinicsSearchArray = allClinics?.filter({ clinic -> Bool in
            return clinic.title!.lowercased().contains(searchText.lowercased())
        })

        if(allClinicsSearchArray?.count == 0){
            allClinicsSearchArray = allClinics
        }
        self.searchView?.tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return !searchBarIsEmpty()
    }
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}

extension MapViewModel: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        self.getCurrentClinic(marker: marker) { (clinic) in
            marker.icon = clinic.highlight == 1 ? UIImage(named: "EliteSelected") : UIImage(named: "Selected")
            self.isInfoClinicViewOpened = true
            self.savedLastMarker = marker
            self.delegateClinicID?.clinicId(id: clinic.id!)
        }
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
                marker.icon =  clinic.highlight == 1 ? UIImage(named: "EliteNotSelected")  : UIImage(named: "NotSelected")
                marker.snippet = clinic.title
                
                self.appendInRange(position: position, marker: marker, range: 1000)
            }
            self.allClinicsMap = clinics
            print("allMarkers : \(self.allMarkers.count)")
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        
        
        self.getCurrentClinic(marker: marker) { (clinics) in
            marker.icon = clinics.highlight == 1 ? UIImage(named: "EliteNotSelected") : UIImage(named: "NotSelected")
        }
        
        clinicInfoViewModel.toggleExpand(state: .closed)
            
    }
}

