//
//  WritingSalesPostViewController.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//


import Foundation
import UIKit

class WritingSalesPostViewController: MainViewController {
    
    // MARK: - Header UI연결
    @IBOutlet weak var headerLabel: UILabel!
    var headerText: String?
    
    // MARK: - ViewController 가져오기
    // 홈화면 뷰컨  -> homeVC에 있는 Modal의 값을 추가/변경/삭제 하기 위한 연결
    var homeVC: ViewController?
    
    // salesPostVC -> 글을 수정할 경우 기존 작성되어 있던 글 정보를 불러오기 위한 연결
    var salesPostVC: SalesPostViewController?
    
    
    
    // MARK: - UI 연결
    // 뒤로가기 버튼
    @IBOutlet weak var dismissButton: UIButton!
    
    // 제목
    @IBOutlet weak var titleTextField: UITextField!
    
    // 카테고리
    var category: ProductCategory?
    @IBOutlet weak var categoryLabel: UILabel!
    @IBAction func didTouchedCategoryButton(_ sender: UIButton) {
        guard let categoryVC = storyboard?.instantiateViewController(withIdentifier: "categoryView") as? CategoryViewController else {
            return
        }
            
        categoryVC.writingVC = self
        
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    
    // 가격
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var priceSuggestionButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    
    // 내용
    @IBOutlet weak var contentTextView: UITextView!
    
    
    
    
    // MARK: - 완료 버튼 (글 작성 / Model에 data 추가하기)
    @IBAction func didTouchedWriteButton(_ sender: UIButton) {
        
        // 글 작성하는 유저 정보 가져오기
        guard let userInfoVC = storyboard?.instantiateViewController(withIdentifier: "myKarrotView") as? MyKarrotViewController else {
            return
        }
        let userNickName: String = userInfoVC.userStringName
        
        // header의 text로 현 상태가 글 작성인지 글 수정인지 비교해서 처리
        if self.headerText! == HeaderText.거래추가.rawValue {
            // 글 작성
            homeVC?.tableViewModel.addPost(writer: userNickName, title: titleTextField.text!, content: contentTextView.text!, category: category!, price: Int(priceTextField.text ?? "") ?? nil)
        }else {
            // 글 수정
            tabBarController?.tabBar.isHidden = true
            homeVC?.tableViewModel.modifyPost(identifier: salesPostVC!.receivedData!.identifier, title: titleTextField.text!, content: contentTextView.text!, category: category!, price: Int(priceTextField.text ?? "") ?? nil)
            salesPostVC?.updatePost(homeVC!.tableViewModel.returnPostInfo(salesPostVC!.receivedData!.identifier))
        }
        
        // ---홈화면 테이블뷰 업데이트---
        homeVC?.tableView.reloadData()
        
        // ---뷰 전환---
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dismiss add target
        dismissButton.addTarget(self, action: #selector(didTouchedDismissButton), for: .touchUpInside)
        
        
        // HeaderText 설정
        headerLabel?.text = headerText
        
        // 새로 글 작성하는 경우에만 PlaceHolder 설정
        if headerLabel?.text == "중고거래 글쓰기" {
            // 새로 작성하는 경우
            
            // textView 설정
            contentTextView.textColor = UIColor.lightGray
            contentTextView.text = "삼성동에 올릴 게시글 내용을 작성해주세요.(가품 및 판매금지품목은 게시가 제한될 수 있어요.)"
            contentTextView.delegate = self
            
            // textField 설정
            priceTextField.textColor = UIColor.lightGray
            priceTextField.text = "가격 (선택사항)"
            priceTextField.delegate = self
            
            // 왼쪽 원화, 오른쪽 버튼 설정
            wonLabel.textColor = UIColor.lightGray
            priceSuggestionButton.tintColor = UIColor.lightGray
            priceSuggestionButton.setTitleColor(.lightGray, for: .normal)
            
        }else {
            // 글을 수정하는 경우
            titleTextField.text = salesPostVC?.postTitle.text
            category = salesPostVC?.mainVC?.tableViewModel.returnPostInfo((salesPostVC?.receivedData!.identifier)!).category
            categoryLabel.text = category?.rawValue
            let inModelPrice = salesPostVC?.mainVC?.tableViewModel.returnPostInfo((salesPostVC?.receivedData!.identifier)!).price
            priceTextField.text = inModelPrice == nil ? "" : String(inModelPrice!)
            contentTextView.text = salesPostVC?.postContent.text
        }
    }
}

// TextView
extension WritingSalesPostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "삼성동에 올릴 게시글 내용을 작성해주세요.(가품 및 판매금지품목은 게시가 제한될 수 있어요.)"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension WritingSalesPostViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
            wonLabel.textColor = UIColor.black
            priceSuggestionButton.tintColor = UIColor.black
            priceSuggestionButton.setTitleColor(.black, for: .normal)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.text = "가격 (선택사항)"
            textField.textColor = UIColor.lightGray
            wonLabel.textColor = UIColor.lightGray
            priceSuggestionButton.tintColor = UIColor.lightGray
            priceSuggestionButton.setTitleColor(.lightGray, for: .normal)
        }else {
            print("안비었음")
        }
        
    }
}
