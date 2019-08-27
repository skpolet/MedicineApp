//
//  Clinics.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 21/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class AllClinics: UITableViewCell {

    @IBOutlet var titleClinic: UILabel!
    @IBOutlet var adresClinic: UILabel!
    @IBOutlet var ratingClinic: UILabel!
    @IBOutlet var distanceClinic: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
