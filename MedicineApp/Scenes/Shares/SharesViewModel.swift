//
//  SharesViewModel.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 19/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

enum sharesType {
    case allShares
    case currentShare
}

class SharesViewModel: NSObject{
    var shares: [Share]?
    weak var tableView: UITableView?
    weak var searchBar: UISearchBar?
    var sharesType: sharesType?
    
    weak var delegateClinicID : SelectedClinicIdDelegate?
    
    let clinicInfoViewModel = ClinicInfoViewModel()
    
    func configureTable(table:UITableView, type: sharesType){
        tableView = table
        tableView?.delegate = self
        tableView?.dataSource = self
        sharesType = type
        clinicInfoViewModel.configureClinicInfo()
        self.delegateClinicID = clinicInfoViewModel
        if(type == .currentShare){
        tableView?.register(UINib(nibName: "CurrentShare", bundle: nil), forCellReuseIdentifier: "CurrentShare")
        }else{
        tableView?.register(UINib(nibName: "AllShares", bundle: nil), forCellReuseIdentifier: "AllShares")
        }
    }
    
    
    func configureSearchBar(searchBar:UISearchBar){
        self.searchBar = searchBar
        self.searchBar?.delegate = self
    }
    
    func getAllShares(){
        let sharesLoader = SharesLoader()
        sharesLoader.getShares { (shares) in
            self.shares = shares
            self.tableView?.reloadData()
        }
    }
}

extension SharesViewModel: UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shares?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.sharesType == .allShares){
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllShares", for: indexPath) as! AllShares
            cell.clinicName.text = self.shares?[indexPath.row].nameClinic
            cell.titleShare.text = self.shares?[indexPath.row].title
            cell.descriptionShare.text = self.shares?[indexPath.row].description
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentShare", for: indexPath) as! CurrentShare
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        clinicInfoViewModel.toggleExpand(state: .fullyCollapsed)
        self.delegateClinicID?.clinicId(id: (self.shares?[indexPath.row].idClinic)!)
    }
    
}

