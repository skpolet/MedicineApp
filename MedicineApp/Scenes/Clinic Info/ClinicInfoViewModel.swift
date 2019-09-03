//
//  ClinicInfoViewModel.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 06/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ClinicInfoViewModel: NSObject{
    
    var transition: ClinicInfoViewTransition?
    
    var clinic : Clinic?
    let tableView = UITableView()
    var comments : [Comment]?
    var shares : [Share]?
    
    func toggleExpand(state: State) {
        transition?.toggleExpandInfo(state)
        transition?.toggleExpandImage(state)
    }
    
    func configureClinicInfo(){
        if let topVC = UIApplication.getTopViewController() {
            let imageView = ClinicTransitionableView()
            imageView.backgroundColor = .black
            
            let infoView = ClinicTransitionableView()
            infoView.backgroundColor = .white
            
            transition = ClinicInfoViewTransition(imageView: imageView, infoView: infoView)
            imageView.delegate = transition
            infoView.delegate = transition
            
            topVC.view.addSubview(imageView)
            topVC.view.addSubview(infoView)
            
            imageView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(topVC.view)
                //make.bottom.equalTo(self.view).offset(self.maximalYPositionImageView)
                make.right.equalTo(topVC.view)
                make.top.equalTo(topVC.view).offset(topVC.view.frame.height / 1.65)
                //topConstraintImage = make.top.equalTo(topVC.view).offset(view.frame.height / 1.65).constraint
                
                
            }
            
            infoView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(topVC.view)
                make.right.equalTo(topVC.view)
                make.top.equalTo(topVC.view).offset(topVC.view.frame.height / 1.30)
            }
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.bounces = false
            tableView.register(UINib(nibName: "TitleClinicInfo", bundle: nil), forCellReuseIdentifier: "TitleClinicInfo")
            tableView.register(UINib(nibName: "ShareClinicInfo", bundle: nil), forCellReuseIdentifier: "ShareClinicInfo")
            tableView.register(UINib(nibName: "ActionsClinicInfo", bundle: nil), forCellReuseIdentifier: "ActionsClinicInfo")
            tableView.register(UINib(nibName: "WorkTimeClinicInfo", bundle: nil), forCellReuseIdentifier: "WorkTimeClinicInfo")
            tableView.register(UINib(nibName: "ContactsClinicInfo", bundle: nil), forCellReuseIdentifier: "ContactsClinicInfo")
            tableView.register(UINib(nibName: "SocialWebClinicInfo", bundle: nil), forCellReuseIdentifier: "SocialWebClinicInfo")
            tableView.register(UINib(nibName: "ServicesClinicInfo", bundle: nil), forCellReuseIdentifier: "ServicesClinicInfo")

            
            infoView.addSubview(tableView)
            
            tableView.snp.makeConstraints { (make) in
                //make.centerY.centerX.equalToSuperview()
                make.right.equalTo(infoView).offset(0)
                make.bottom.equalTo(infoView).offset(0)
                make.left.equalTo(infoView).offset(0)
                make.top.equalTo(infoView).offset(18)
                make.width.height.equalToSuperview()
            }
            
        }
    }
    
    func configureClinicInfoAboveWindow(){
        if let window :UIWindow = UIApplication.shared.keyWindow {
            let imageView = ClinicTransitionableView()
            imageView.backgroundColor = .red
            
            let infoView = ClinicTransitionableView()
            infoView.backgroundColor = .black
            infoView.alpha = 0.5
            
            transition = ClinicInfoViewTransition(imageView: imageView, infoView: infoView)
            imageView.delegate = transition
            infoView.delegate = transition
            
            window.addSubview(imageView)
            window.addSubview(infoView)
            
            imageView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(window)
                //make.bottom.equalTo(self.view).offset(self.maximalYPositionImageView)
                make.right.equalTo(window)
                make.top.equalTo(window).offset(window.frame.height / 1.65)
                //topConstraintImage = make.top.equalTo(topVC.view).offset(view.frame.height / 1.65).constraint
                
                
            }
            
            infoView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(window)
                //make.bottom.equalTo(self.view).offset(self.maximalYPositionInfoView)
                make.right.equalTo(window)
                make.top.equalTo(window).offset(window.frame.height / 1.30)
                //topConstraintInform = make.top.equalTo(view).offset(view.frame.height / 1.30).constraint
                
            }
        }
    }
}

extension ClinicInfoViewModel: SelectedClinicIdDelegate{
    func clinicId(id: Int) {
        let loader = ClinicsLoader()
        loader.getClinicWithId(id: id) { (clinic) in
            self.clinic = clinic
            print("clinic:\(String(describing: clinic.address))")
            self.tableView.reloadData()
        }
        let commentLoader = CommentLoader()
        commentLoader.getComments(idClinic: id) { (comments) in
            self.comments = comments
        }
        let sharesLoader = SharesLoader()
        sharesLoader.getShareWithId(idClinic: id) { (shares) in
            self.shares = shares
        }
    }
    
}

extension ClinicInfoViewModel: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCounter = 6 + (shares?.count ?? 0)
        
        return rowCounter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleClinicInfo", for: indexPath) as! TitleClinicInfo
            cell.titleClinic.text = clinic?.title
            cell.adressClinic.text = clinic?.address
            cell.ratingClinic.text = "\(clinic?.rating ?? 0)"
            
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "\(comments?.count ?? 0) отзывов", attributes: underlineAttribute)
            
            cell.countComments.attributedText = underlineAttributedString
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShareClinicInfo", for: indexPath) as! ShareClinicInfo
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionsClinicInfo", for: indexPath) as! ActionsClinicInfo
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTimeClinicInfo", for: indexPath) as! WorkTimeClinicInfo
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsClinicInfo", for: indexPath) as! ContactsClinicInfo
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialWebClinicInfo", for: indexPath) as! SocialWebClinicInfo
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesClinicInfo", for: indexPath) as! ServicesClinicInfo
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 45
        case 2:
            return 75
        case 3:
            return 44
        case 4:
            return 70
        case 5:
            return 70
        case 6:
            return 44
            
        default:
            return 0
        }
    }
    

}
