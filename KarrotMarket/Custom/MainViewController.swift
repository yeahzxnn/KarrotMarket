//
//  MainViewController.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/06.
//


import Foundation
import UIKit


// MARK: - UIViewController 커스텀
class MainViewController: UIViewController {
    
    // MARK: - UI Image
    func addRadiusToUIImageView(_ img: UIImageView, size: CGFloat) {
        img.layer.cornerRadius = size
    }
    
    
    
    
    // MARK: - UI View
    func addBorderToUIView(_ to: UIView, size: CGFloat, color: CGColor) {
        to.layer.borderWidth = size
        to.layer.borderColor = color
    }
    
    func addRadiusToUIView(_ view: UIView, size: CGFloat) {
        view.layer.cornerRadius = size
    }
    
    
    
    // MARK: - 숫자 -> 콤마찍어서 문자열 반환
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
            return result
    }
    
    
    // MARK: - UIButton 함수
    // 버튼에 Radius 추가
    func addRadiusToUIButton(_ button: UIButton, size: CGFloat) {
        button.layer.cornerRadius = size
    }
    
    // 버튼에 border, color 추가
    func addBorderToUIButton(_ button: UIButton, size: CGFloat, color: CGColor) {
        button.layer.borderWidth = size
        button.layer.borderColor = color
    }
    
    
    
    
    
    // MARK: - @objc버튼 정의
    // dismiss
    @objc func didTouchedDismissButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

}
