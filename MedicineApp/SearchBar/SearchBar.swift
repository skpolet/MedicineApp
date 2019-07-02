//
//  SearchBar.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

enum searchType {
    case countryArray
    case clinicsArray
    case diseasesArray
}

protocol Searchable {
    func found(searchArr: NSArray)
}

class SearchBar: NSObject {

    let searchType : searchType
    var items : NSArray
    var delegateSearch:Searchable?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(items:NSArray, searchType:searchType, searchBar:UISearchBar){
        
        self.items = items
        self.searchType = searchType
        super.init()
        searchBar.delegate = self
        print("searchBar.delegate\(String(describing: searchBar))")
    }
}

extension SearchBar: UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if(self.searchType == .countryArray){
            if(searchText.count > 0){
                let resultPredicate = NSPredicate(format: "title contains[c] %@", searchText)
                if let sortedDta = items.filtered(using: resultPredicate) as? NSArray {
                    
                    //enter code here.
                    
                    print(sortedDta)
                }
            }else{
                self.delegateSearch?.found(searchArr:self.items)
            }
        }
        if(self.searchType == .clinicsArray){
            if(searchText.count > 0){
                
            }else{
                self.delegateSearch?.found(searchArr:self.items)
            }
        }
        if(self.searchType == .diseasesArray){
            if(searchText.count > 0){
                
            }else{
                self.delegateSearch?.found(searchArr:self.items)
            }
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.delegateSearch?.found(searchArr:self.items)
        searchBar.showsCancelButton = true
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
