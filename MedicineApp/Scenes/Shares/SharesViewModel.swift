//
//  SharesViewModel.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 19/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit
import SDStateTableView

enum sharesType {
    case allShares
    case currentShare
}

class SharesViewModel: NSObject{
    var shares: [Share]?
    weak var tableView: SDStateTableView?
    weak var searchBar: UISearchBar?
    var sharesType: sharesType?
    
    weak var delegateClinicID : SelectedClinicIdDelegate?
    
    let clinicInfoViewModel = ClinicInfoViewModel()
    
    func configureSharesCoordinator(coordinator:SharesCoordinator){
        clinicInfoViewModel.configureSharesCoordinator(coordinator: coordinator)
    }
    
    func configureTable(table:SDStateTableView, type: sharesType){
        tableView = table
        tableView?.delegate = self
        tableView?.dataSource = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: Notification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        //Reach().monitorReachabilityChanges()
        
        


        
        
        sharesType = type
        clinicInfoViewModel.configureClinicInfoAboveWindow()
        self.delegateClinicID = clinicInfoViewModel
        if(type == .currentShare){
        tableView?.register(UINib(nibName: "CurrentShare", bundle: nil), forCellReuseIdentifier: "CurrentShare")
        }else{
        tableView?.register(UINib(nibName: "AllShares", bundle: nil), forCellReuseIdentifier: "AllShares")
        }
    }
    
    func setupTableStatus(status: ReachabilityStatus){
        switch status {
        case .unknown, .offline:
            tableView?.setState(.withButton(errorImage: UIImage(named: "no_internet"), title: "Нет интернет соединения",
                                            message: "По неизвестным причинам интернет соединение отсутствует, пожалуйста попробуйте позже",
                                            buttonTitle: "Попробовать снова",
                                            buttonConfig: { (button) in
                                                // You can configure the button here
                                                
            },
                                            retryAction: {
                                                self.getAllShares()
                                                //self.tableView?.setState(.loading(message: "Loading data..."))
            }))
        case .online(.wwan), .online(.wiFi):
            if(shares?.count ?? 0 > 0){
                self.tableView?.reloadData()
                self.tableView?.setState(.dataAvailable)
            }
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        let status = Reach().connectionStatus()
            setupTableStatus(status: status)
    }
    
    
    func configureSearchBar(searchBar:UISearchBar){
        self.searchBar = searchBar
        self.searchBar?.delegate = self
    }
    
    func getAllShares(){
        //self.tableView?.setState(.loading(message: "Loading data..."))
        let sharesLoader = SharesLoader()
        sharesLoader.getShares { (shares, status) in
            self.shares = shares
            self.setupTableStatus(status: status)
        }
    }
}

extension SharesViewModel: UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (tableView as! SDStateTableView).currentState {
        case .dataAvailable:
            tableView.separatorStyle = .singleLine
            return self.shares?.count ?? 0
        default:
            tableView.separatorStyle = .none
            return 0
        }
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
        clinicInfoViewModel.toggleExpand(state: .middle)
        self.delegateClinicID?.clinicId(id: (self.shares?[indexPath.row].idClinic)!)
    }
    
}

