//
//  File5.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//


import Foundation
import UIKit

class NearMeViewController: MainViewController {
    
    
    // MARK: - 인기검색어 관련
    // 인기검색어 모델
//    var popularSearchKeyWordModel = popularSearchKeywordModel()
    // 인기검색어 StackView
    @IBOutlet weak var searchKeywordStackView: UIStackView!
    
    // 인기검색어 버튼들 설정 (테두리 추가, Radius추가)
    func addBorderAndRadius(_ stackView: UIStackView) {
        for index in 0..<stackView.subviews.count {
            guard let eachButton = stackView.subviews[index].subviews[0] as? UIButton else {
                return
            }
            addBorderToUIButton(eachButton, size: 1, color: UIColor.lightGray.cgColor)
            addRadiusToUIButton(eachButton, size: 18)
        }
    }
    
    //인기검색어
    
    @IBOutlet weak var popularKeyWordStackView: UIStackView!
    
    // MARK: - UI 연결
    @IBOutlet weak var searchBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 인기검색어 리스트 버튼들 설정
        addBorderAndRadius(searchKeywordStackView)

        addBorderAndRadius(popularKeyWordStackView)
        // 검색창 Radius설정
        addRadiusToUIView(searchBarView, size: 10)
    }
}
