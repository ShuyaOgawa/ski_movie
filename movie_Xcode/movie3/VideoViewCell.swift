//
//  VideoViewCell.swift
//  movie3
//
//  Created by 小川秀哉 on 2017/09/28.
//  Copyright © 2017年 Digital Circus Inc. All rights reserved.
//

import UIKit

class VideoViewCell: UITableViewCell {
    

    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
