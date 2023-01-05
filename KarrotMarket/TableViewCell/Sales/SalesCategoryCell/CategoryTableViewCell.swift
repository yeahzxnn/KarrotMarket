//
//  CategoryTableViewCell.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/06.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    // UI 연결
    @IBOutlet weak var categoryName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func cellUpdate(_ category: ProductCategory) {
        categoryName.text = category.rawValue
    }
}
