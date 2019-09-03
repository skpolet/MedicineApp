//
//  TitleClinicInfo.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 21/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class TitleClinicInfo: UITableViewCell {

    @IBOutlet var titleClinic: UILabel!
    @IBOutlet var adressClinic: UILabel!
    @IBOutlet var ratingClinic: UILabel!
    @IBOutlet var countComments: UILabel!
    @IBOutlet var ratingView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ratingView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
