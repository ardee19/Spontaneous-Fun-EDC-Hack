//
//  ContestCell.swift
//  Spontaneous Fun
//
//  Created by i am awesome on 6/10/16.
//  Copyright © 2016 Super Awesome. All rights reserved.
//

import UIKit

class ContestCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var countdown: UILabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
