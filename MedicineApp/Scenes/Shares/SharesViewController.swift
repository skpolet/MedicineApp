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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let civm = ClinicInfoViewModel()
        civm.configureClinicInfo()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
