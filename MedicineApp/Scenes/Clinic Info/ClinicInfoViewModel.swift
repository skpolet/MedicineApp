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
    
    var radiusConnerImage: CGFloat = 15.0
    var radiusConnerInfo: CGFloat = 15.0
    
    var clinic : Clinic?
    let tableView = UITableView()
    var comments : [Comment]?
    var shares : [Share]?
    weak var coordinatorMap: MapCoordinator?
    weak var coordinatorShares: SharesCoordinator?
    var closeButton = UIButton(type: .custom)
    
    let imageView = ClinicTransitionableView()
    let infoView = ClinicTransitionableView()
    
    let imageSubview = UIImageView()
    
    let rateVC = RateClinicBuilder()
    
    func toggleExpand(state: State) {
        transition?.toggleExpandInfo(state)
        transition?.toggleExpandImage(state)
    }
    
    func configureSharesCoordinator(coordinator: SharesCoordinator){
        self.coordinatorShares = coordinator
    }
    
    @objc func closeInfo(){
        self.toggleExpand(state: .closed)
    }
    
    func configureClinicInfo(){
        if let topVC = UIApplication.getTopViewController() {
            //let imageView = ClinicTransitionableView()
            imageView.backgroundColor = .clear
            infoView.backgroundColor = .white
            
            transition = ClinicInfoViewTransition(imageView: imageView, infoView: infoView)
            imageView.delegate = transition
            infoView.delegate = transition
            
            transition?.delegate = self
            
            infoView.layer.cornerRadius = 15
            imageView.layer.cornerRadius = 15
            imageSubview.layer.cornerRadius = 15
            tableView.layer.cornerRadius = 15
            imageSubview.layer.masksToBounds = true

            
            closeButton.frame = CGRect()
            let img = UIImage(named: "down-chevron")?.withRenderingMode(.alwaysTemplate)
            closeButton.setImage(img, for: .normal)
            closeButton.tintColor = .white
            closeButton.addTarget(self, action: #selector(closeInfo), for: .touchUpInside)
            imageSubview.addSubview(closeButton)
            
            topVC.view.addSubview(imageView)
            topVC.view.addSubview(infoView)
            
            imageView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(topVC.view)
                make.height.equalTo(transition!.heightImage)
                make.right.equalTo(topVC.view)
                make.top.equalTo(topVC.view).offset(topVC.view.frame.height / 1.65)
            }
            
            closeButton.snp.makeConstraints({ (make) in
                make.width.equalTo(35)
                make.height.equalTo(20)
                make.left.equalTo(10)
                make.top.equalTo(10)
            })
            
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
            tableView.register(UINib(nibName: "AddCommentClinicInfo", bundle: nil), forCellReuseIdentifier: "AddCommentClinicInfo")

            
            infoView.addSubview(tableView)
            
            tableView.snp.makeConstraints { (make) in
                make.right.equalTo(infoView).offset(0)
                make.bottom.equalTo(infoView).offset(0)
                make.left.equalTo(infoView).offset(0)
                make.top.equalTo(infoView).offset(18)
                make.width.height.equalToSuperview()
            }
            
            imageView.addSubview(imageSubview)
            
            imageSubview.snp.makeConstraints { (make) in
                make.right.equalTo(imageView).offset(0)
                make.bottom.equalTo(imageView).offset(0)
                make.left.equalTo(imageView).offset(0)
                make.top.equalTo(imageView).offset(0)
                make.width.height.equalToSuperview()
            }
            
        }
    }
    
    func configureClinicInfoAboveWindow(){
        if let window :UIWindow = UIApplication.shared.keyWindow {
            //let imageView = ClinicTransitionableView()
            imageView.backgroundColor = .clear
            
            //let infoView = ClinicTransitionableView()
            infoView.backgroundColor = .white
            //infoView.alpha = 0.5
            
            transition = ClinicInfoViewTransition(imageView: imageView, infoView: infoView)
            imageView.delegate = transition
            infoView.delegate = transition
            
            transition?.delegate = self
            
            window.addSubview(imageView)
            window.addSubview(infoView)
            
            closeButton.frame = CGRect()
            let img = UIImage(named: "down-chevron")?.withRenderingMode(.alwaysTemplate)
            closeButton.setImage(img, for: .normal)
            closeButton.tintColor = .white
            closeButton.addTarget(self, action: #selector(closeInfo), for: .touchUpInside)
            imageSubview.addSubview(closeButton)
            
            closeButton.snp.makeConstraints({ (make) in
                make.width.equalTo(35)
                make.height.equalTo(20)
                make.left.equalTo(10)
                make.top.equalTo(10)
            })
            
            imageView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(window)
                make.height.equalTo(transition!.heightImage)
                //make.bottom.equalTo(self.view).offset(self.maximalYPositionImageView)
                make.right.equalTo(window)
                make.top.equalTo(window).offset(window.frame.height / 1.65)
                //topConstraintImage = make.top.equalTo(topVC.view).offset(view.frame.height / 1.65).constraint
                
                
            }
            
            infoView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(window)
                make.right.equalTo(window)
                make.top.equalTo(window).offset(window.frame.height / 1.30)
            }
            infoView.layer.cornerRadius = 15
            imageView.layer.cornerRadius = 15
            imageSubview.layer.cornerRadius = 15
            tableView.layer.cornerRadius = 15
            imageSubview.layer.masksToBounds = true
            //imageView.alpha = 1
            
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
            tableView.register(UINib(nibName: "AddCommentClinicInfo", bundle: nil), forCellReuseIdentifier: "AddCommentClinicInfo")
            
            
            infoView.addSubview(tableView)
            
            tableView.snp.makeConstraints { (make) in
                make.right.equalTo(infoView).offset(0)
                make.bottom.equalTo(infoView).offset(0)
                make.left.equalTo(infoView).offset(0)
                make.top.equalTo(infoView).offset(18)
                make.width.height.equalToSuperview()
            }
            
            imageView.addSubview(imageSubview)
            
            imageSubview.snp.makeConstraints { (make) in
                make.right.equalTo(imageView).offset(0)
                make.bottom.equalTo(imageView).offset(0)
                make.left.equalTo(imageView).offset(0)
                make.top.equalTo(imageView).offset(0)
                make.width.height.equalToSuperview()
            }
            
            
        }
    }
}

extension ClinicInfoViewModel: ClinicInfoViewTransitionDelegate{

    
    func translations(destinationInfo: CGFloat, destinationImage: CGFloat) {
        
        
        radiusConnerInfo = destinationInfo * 0.1
        radiusConnerImage = destinationImage * 0.1
        
        if(radiusConnerInfo <= 15){
            self.infoView.layer.cornerRadius = radiusConnerInfo
            self.tableView.layer.cornerRadius = radiusConnerInfo
        }
        if(radiusConnerImage <= 15){
            self.imageView.layer.cornerRadius = radiusConnerImage
            self.imageSubview.layer.cornerRadius = radiusConnerImage
        }

    }
    
    
}

extension ClinicInfoViewModel: SelectedClinicIdDelegate{
    func mapCoordinator(coordinator: MapCoordinator) {
        self.coordinatorMap = coordinator
    }
    
    func clinicId(id: Int) {
        let loader = ClinicsLoader()
        loader.getClinicWithId(id: id) { (clinic, status) in
            self.clinic = clinic
            self.tableView.reloadData()
        }
        loader.getImageForClinic(id: id) { (imageData, status) in
            if((imageData.error) == nil){
                print("imageData.data : \(String(describing: imageData.error))")
                self.imageSubview.backgroundColor = .clear
            self.imageSubview.image = UIImage(data: imageData.data!)
            }else{
            self.imageSubview.backgroundColor = .black
            self.imageSubview.image = nil
            }
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
    
    @objc func trackSelected(sender: UIButton){
        print("sender.tag")
        
        let alert = UIAlertController(title: "Геолокация отключена", message: "Пожалуйста разрешите этому приложению использовать геолокацию", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Настройки", style: UIAlertAction.Style.default, handler: { (action) in
            if let url = URL(string:UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }))
        //delegate?.showAlert(alert: alert)
        
        if((coordinatorShares) != nil){
            self.toggleExpand(state: .closed)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.coordinatorShares?.shares.vc?.tabBarController?.selectedIndex = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let mapcoord = self.coordinatorShares?.childCoordinators[0] as! MapCoordinator
                    
                    mapcoord.mapVC.vc?.viewModel.newTrack(clinic: self.clinic!)
                }
            }
        }
    }
    
    @objc func mapSelected(sender: UIButton){
        
        print("coordinators : \(String(describing: coordinatorMap)) and \(String(describing: coordinatorShares))")
        if((coordinatorMap) != nil){
            
        }
        if((coordinatorShares) != nil){
            self.toggleExpand(state: .closed)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.coordinatorShares?.shares.vc?.tabBarController?.selectedIndex = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let mapcoord = self.coordinatorShares?.childCoordinators[0] as! MapCoordinator
                        //as! TitleClinicInfo
                    //print("current coordinator: \(String(describing: ))")
                    //searchView?.toggleExpand(.closed, fast: true)
                    //mapcoord.mapVC.vc?.viewModel.clinicInfoViewModel.toggleExpand(state: .fullyCollapsed)
                    print("clinic: \(String(describing: self.clinic?.address))")
                    mapcoord.mapVC.vc?.viewModel.openClinicWithClinic(clinic: self.clinic!)
                }
            }
        }
    }
    
    @objc func rateSelected(sender: UIButton){
        print("sender.tag")
        
    }
    
    @objc func callSelected(sender: UIButton){
        print("sender.tag")
    }
    
    @objc func addCommentSelected(sender: UIButton){
        print("sender.tag")
        
        if((coordinatorMap) != nil){
            self.coordinatorMap?.navigationController.pushViewController(rateVC.vc!, animated: true)
        }
        if((coordinatorShares) != nil){
            self.toggleExpand(state: .closed)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.coordinatorShares?.navigationController.pushViewController(self.rateVC.vc!, animated: true)
            }
        }
    }
    
}

extension ClinicInfoViewModel: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCounter = 8 + (shares?.count ?? 0)
        
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
            cell.rateButton.addTarget(self, action: #selector(rateSelected), for: .touchUpInside)
            cell.trackButton.addTarget(self, action: #selector(trackSelected), for: .touchUpInside)
            cell.mapButton.addTarget(self, action: #selector(mapSelected), for: .touchUpInside)
            cell.callButton.addTarget(self, action: #selector(callSelected), for: .touchUpInside)
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
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentClinicInfo", for: indexPath) as! AddCommentClinicInfo
            
            cell.addComment.addTarget(self, action: #selector(addCommentSelected), for: .touchUpInside)
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
//            let shareVC = SharesBuilder(type: .onceShare)
//            if let topVC = UIApplication.getTopViewController() {
//                topVC.navigationController?.pushViewController(shareVC.vc!, animated: true)
//            }
            self.coordinatorMap?.toOnce()
            
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
            
        default:
            break
        }
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
        case 7:
            return 105
        default:
            return 0
        }
    }
    

}
