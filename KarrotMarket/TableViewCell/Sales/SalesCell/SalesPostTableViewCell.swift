//
//  SalesPostTableViewCell.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/06.
//


import UIKit

class SalesPostTableViewCell: TableViewCell {
    
    // MARK: - UI연결
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellAddress: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    
    @IBOutlet weak var chattingView: UIView!
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var chattingLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    
    // ViewDidLoad와 같은 역할 (초기화 작업을 함)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 이미지에 Radius 추가
        addRadiusToImage(cellImage)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // Post정보를 가져와서 Cell 내용 업데이트
    func cellUpdate(_ data: SalesPost) {
        cellImage.image = UIImage(named: data.imageString)
        cellTitle.text = data.title
        cellAddress.text = data.writer.address
        guard let price = data.price else {
            cellPrice.text = ""
            return
        }
        if price == 0 {
            cellPrice.text = "나눔🧡"
        }else {
            cellPrice.text = DecimalWon(value: price)
        }
        chattingLabel.text = String(data.chattingCount)
        heartLabel.text = String(data.interestCount)
    }
    
}
