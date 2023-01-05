//
//  UserInfoTableViewCell.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/06.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var loginUserName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
