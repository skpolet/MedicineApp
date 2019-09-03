//
//  SharesViewController.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class SharesViewController: UIViewController {
    
    weak var coordinator: SharesCoordinator?

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    let viewModel = SharesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configureTable(table: tableView, type:.allShares)
        viewModel.configureSearchBar(searchBar: searchBar)
        viewModel.getAllShares()
    }


}
