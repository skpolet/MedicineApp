//
//  CurrentShare.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 02/09/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class CurrentShare: UITableViewCell {

    @IBOutlet var clinicName: UILabel!
    @IBOutlet var imageShare: UIImageView!
    @IBOutlet var dateShare: UILabel!
    @IBOutlet var descriptionShare: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
