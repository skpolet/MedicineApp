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

class MapViewModel: NSObject {

    func configureBottomView(view: JKBottomSearchView){
        view.placeholder = "Название клиники"
        view.searchBarStyle = .minimal
        view.tableView.backgroundColor = .clear
        view.contentView.layer.cornerRadius = 10
        view.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
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
