//
//  CountryViewController.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 07/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit
import CoreLocation

class CountryViewController: UIViewController, Storyboarded, LocationCoordinatble, CLLocationManagerDelegate, Searchable {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    weak var coordinator: MainCoordinator?
    var locationList:LocationList?
    var selectedIndexPath:IndexPath?
    
    func currentLocation(city: String?, region: String?) {
        let defaults = UserDefaults.standard
        defaults.set(city, forKey: "City")
        defaults.set(region, forKey: "Region")

            print("saved \(String(describing: defaults.object(forKey: "City"))) \n \(String(describing: defaults.object(forKey: "Region")))")
            
            let alertController = UIAlertController(title:String(describing: defaults.object(forKey: "City")), message: "Хотите искать клинику в этом регионе?", preferredStyle: .alert)

            alertController.addAction(UIAlertAction.init(title: "Сохранить", style: .default, handler: { (save) in
                self.coordinator?.toHome()
            }))
            alertController.addAction(UIAlertAction.init(title: "Отмена", style: .destructive, handler: { (save) in
                defaults.removeObject(forKey: "City")
                defaults.removeObject(forKey: "Region")
            }))
            self.present(alertController, animated: true, completion: nil)
    }
    
    func found(searchArr: NSArray) {
        print("naideno:\(searchArr)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationLoader = LocationLoader()
        locationLoader.getLocations { result in
            self.locationList = result
            self.tableView.reloadData()
            
            let locations = result.location
            let searchBar  = SearchBar(items: locations! as NSArray, searchType: .countryArray, searchBar: self.searchBar)
            searchBar.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let selected = selectedIndexPath else {
            return
        }
        self.tableView.deselectRow(at: selected, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let locations = locationList?.location
        return locations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "locationCell"))!
        
        let locations = locationList?.location
        let location: Location = (locations?[indexPath.row])!
        cell.textLabel?.text = location.title
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let locations = locationList?.location
        let location: Location = (locations?[indexPath.row])!
        
        let defaults = UserDefaults.standard
        defaults.set(location.title, forKey: "City")
        self.selectedIndexPath = indexPath
        coordinator?.toHome()
    }
}

