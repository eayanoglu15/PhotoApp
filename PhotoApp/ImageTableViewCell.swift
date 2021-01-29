//
//  ImageTableViewCell.swift
//  PhotoApp
//
//  Created by Ege Melis Ayanoğlu on 29.01.2021.
//  Copyright © 2021 horizon. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
