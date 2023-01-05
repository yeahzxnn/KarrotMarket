//
//  VillageLifeTableViewCell.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/06.
//

import UIKit

class VillageLifeTableViewCell: MainTableViewCell {

    // MARK: - UI연결
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var userNameAndAddress: UILabel!
    
    @IBOutlet weak var categoryUIView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        let newLabelSize = contentLabel.sizeThatFits(CGSize(width: contentLabel.frame.width, height: CGFloat.greatestFiniteMagnitude))
        contentLabel.frame.size = newLabelSize
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func cellUpdate(_ data: VillageLifePost) {
        userNameAndAddress.text = "\(data.writer.nickName) ∙ \(data.writer.address)"
        
        // 카테고리 부분
        addRadiusToUIView(categoryUIView, size: 5)
        categoryLabel.text = data.category.rawValue
        
        // 카테고리가 "동네질문"인 경우 내용의 맨 앞에 주황글씨로 Q. 추가
        if data.category == .동네질문 {
            let text = "Q. \(data.content)"
            let attributeString = NSMutableAttributedString(string: text)
            self.contentLabel.attributedText = attributeString
            // color, bold 속성
            self.contentLabel.bold(targetString: "Q.")
        }else {
            contentLabel.text = data.content
        }
    }
}






// bold속성, color속성 주려고 가져온 extention
extension UILabel {
    func bold(targetString: String) {
        let fontSize = self.font.pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.orange, range: range)
        self.attributedText = attributedString
    }
}
