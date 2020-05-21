//
//  TableViewCell.swift
//  MusicP
//
//  Created by Terry on 2020/05/19.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
