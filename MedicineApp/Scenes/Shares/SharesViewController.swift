//
//  SharesViewController.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit
import SDStateTableView

class SharesViewController: UIViewController {
    
    weak var coordinator: SharesCoordinator?


    @IBOutlet var tableView: SDStateTableView!
    //@IBOutlet var searchBar: UISearchBar!
    lazy   var searchBar:UISearchBar = UISearchBar()
    let viewModel = SharesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.sizeToFit()
        searchBar.placeholder = "Введите название акции"
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        //let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        //self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        viewModel.configureTable(table: tableView, type:.allShares)
        viewModel.configureSharesCoordinator(coordinator: coordinator!)
        viewModel.configureSearchBar(searchBar: searchBar)
        viewModel.getAllShares()
        
    }


}
