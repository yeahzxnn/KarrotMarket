//
//  MainTableViewCell.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/06.
//

import Foundation
import UIKit

// MARK: - UITableViewCell 커스텀
class MainTableViewCell: UITableViewCell {
    
    // MARK: - 숫자 -> 콤마찍어서 문자열 반환
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
            return result
    }
    
    
    // MARK: - UIImageView
    func addRadiusToImage(_ image: UIImageView) {
        image.layer.cornerRadius = image.frame.height / 10
    }

    // MARK: - UIButton
    
    // 버튼에 Radius 추가
    func addRadiusToUIButton(_ button: UIButton, size: CGFloat) {
        button.layer.cornerRadius = size
    }
    
    
    
    // MARK: - UIView
    // radius
    func addRadiusToUIView(_ view: UIView, size: CGFloat) {
        view.layer.cornerRadius = size
    }
}

