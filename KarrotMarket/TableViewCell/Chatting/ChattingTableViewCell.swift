//
//  ChattingTableViewCell.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/06.
//

import UIKit

class ChattingTableViewCell: MainTableViewCell {
    
    // MARK: - UI연결
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var connectedUser: UILabel!
    
    @IBOutlet weak var addressAndDate: UILabel!
    
    @IBOutlet weak var lastChat: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    
    // MARK: - UI 업데이트
    func cellUpdate(_ data: Chatting) {
        profileImage.image = data.connectedUser.profileImage == nil ? UIImage(named: "userIcon.jpeg") : UIImage(named: data.connectedUser.profileImage!)
        connectedUser.text = data.connectedUser.nickName
        addressAndDate.text = "\(data.connectedUser.address) · \(data.lastChatDate)"
        lastChat.text = data.lastChat
        if data.productImage == nil {
            productImage.isHidden = true
        }else {
            productImage.image = UIImage(named: data.productImage!)
        }
    }
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
