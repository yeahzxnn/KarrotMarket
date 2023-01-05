//
//  SalesPostCollectionViewCell.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//

import Foundation
import UIKit

class SalesPostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    
    func cellUpdate(_ data: SalesPost) {
        productImage.image = UIImage(named: data.imageString)
        productImage.layer.cornerRadius = 10
        postTitle.text = data.title
        productPrice.text = data.price == 0 ? "나눔🧡" : DecimalWon(value: data.price!)
    }
    
    
    // MARK: - 숫자 -> 콤마찍어서 문자열 반환
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
            return result
    }
}
