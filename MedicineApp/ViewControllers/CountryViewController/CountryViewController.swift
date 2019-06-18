//
//  CountryViewController.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 07/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit
import CoreLocation

class CountryViewController: UIViewController, Storyboarded, LocationCoordinatble, CLLocationManagerDelegate {

    @IBOutlet var tableView: UITableView!
    weak var coordinator: MainCoordinator?
    var locationList:LocationList?
    
    func currentLocation(city: String?, region: String?) {
        let defaults = UserDefaults.standard
        defaults.set(city, forKey: "City")
        defaults.set(region, forKey: "Region")

        //if(String(describing: defaults.object(forKey: "City")) != nil || String(describing: defaults.object(forKey: "Region")) != nil){
            print("saved \(String(describing: defaults.object(forKey: "City"))) \n \(String(describing: defaults.object(forKey: "Region")))")
            
            let alertController = UIAlertController(title:String(describing: defaults.object(forKey: "City")), message: "Хотите искать клинику в этом регионе?", preferredStyle: .alert)

            alertController.addAction(UIAlertAction.init(title: "Сохранить", style: .default, handler: { (save) in
                
            }))
            alertController.addAction(UIAlertAction.init(title: "Отмена", style: .destructive, handler: { (save) in
                defaults.removeObject(forKey: "City")
                defaults.removeObject(forKey: "Region")
            }))
            self.present(alertController, animated: true, completion: nil)
       // }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationLoader = LocationLoader()
        locationLoader.getLocations { result in
            self.locationList = result
            self.tableView.reloadData()
        }
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let locations = locationList?.location
        print(locations?.count ?? 9999)
        return locations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "locationCell"))!
        
        let locations = locationList?.location
        let location: Location = (locations?[indexPath.row])!
        cell.textLabel?.text = location.title
        
        return cell
    }
}

