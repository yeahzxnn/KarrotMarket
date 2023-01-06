//
//  SalesPostViewController.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//

import Foundation
import UIKit

class SalesPostViewController: MainViewController {
    
    // MARK: - Alert 구현
    @IBAction func didTouchedAlertButton(_ sender: UIButton) {
        // 사용자 아이디와 글 작성자를 비교하여 서로 다른 알람이 나오도록 하자
        
        // 1. 사용자 아이디 가져오기
        guard let userInfoVC = storyboard?.instantiateViewController(withIdentifier: "myKarrotView") as? MyKarrotViewController else {
            return
        }
        let userNickName: String = userInfoVC.userStringName
        
        // 2. 사용자와 글 작성자 비교하기
        if userNickName == nickName.text! {
            // 사용자와 글 작성자가 같을 때
            showPostSettingAlert()
        }else {
            // 사용자와 글 작성자가 다를 때
            showNomalAlert()
        }
    }
    
    // 수정/삭제 가능한 알림창
    func showPostSettingAlert() {
        // alert controller 생성
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 게시글 수정
        let modify = UIAlertAction(title: "게시글 수정", style: .default, handler: { (action) in
            
            guard let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "writingNavigationController") as? UINavigationController else {
                return
            }
            
            guard let writingVC = navigationVC.viewControllers[0] as? WritingSalesPostViewController else {
                return
            }
            
            // header설정
            writingVC.headerText = HeaderText.거래수정.rawValue
            
            // self 넘겨줌 -> 현재 글 상태 정보를 접근하여 writingPostVC의 정보를 업데이트 하려고
            writingVC.salesPostVC = self
            
            // 홈화면 View 넘겨주기
            writingVC.homeVC = self.mainVC
            
            self.present(navigationVC, animated: true, completion: nil)
            
        })
        
        // 끌어올리기
        let pullUp = UIAlertAction(title: "끌어올리기", style: .default, handler: { (action) in
            print("끌어올리기 버튼 눌림")
        })
        
        // 숨기기
        let hide = UIAlertAction(title: "숨기기", style: .default, handler: { (action) in
            print("숨기기 버튼 눌림")
        })
        
        // 삭제
        let delete = UIAlertAction(title: "삭제", style: .destructive, handler: { (action) in
            self.mainVC?.tableViewModel.deletePost(self.receivedData!.identifier)
            self.mainVC?.tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        })
        
        // 취소
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: { (action) in
            print("취소 버튼 눌림")
        })
        
        // alert에 버튼들 추가
        alert.addAction(modify)
        alert.addAction(pullUp)
        alert.addAction(hide)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func showNomalAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let report = UIAlertAction(title: "신고", style: .default, handler: { (action) in
            print("신고 버튼 눌림")
        })
        
        let block = UIAlertAction(title: "이 사용자의 글 보지 않기", style: .default, handler: { (action) in
            print("차단 버튼 눌림")
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: { (action) in
            print("취소 버튼 눌림")
        })
        
        alert.addAction(report)
        alert.addAction(block)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 뒤로가기 버튼
    @IBAction func didTouchedPopButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UI 연결
    // 채팅거는 버튼
    @IBOutlet weak var toChattingButton: UIButton!
    
    // 상품 이미지
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var imageUIView: UIView!
    
    // 사용자 이름과 주소
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var address: UILabel!
    
    // 매너온도 관련
    @IBOutlet weak var mannerScore: UILabel!
    @IBOutlet weak var mannerFace: UIImageView!
    @IBOutlet weak var temperature: UIImageView!
    @IBOutlet weak var mannerEnergy: UIImageView!
    
    // 제목 / 카테고리 / 내용 / 가격
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postCategory: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var postPrice: UILabel!
    
    // 관심 / 조회
    @IBOutlet weak var chattingInterestingChecking: UILabel!
    
    // 프로필 이미지
    @IBOutlet weak var profileImage: UIImageView!
    
    
    // 관심버튼 (하트)
    @IBOutlet weak var heartImage: UIImageView!
    var interested: Bool = false
    @IBAction func didTouchedHeartButton(_ sender: Any) {
        if interested == false {
            heartImage.tintColor = UIColor.systemOrange
            heartImage.image = UIImage(systemName: "heart.fill")
            mainVC?.tableViewModel.calculatInterestCount(receivedData!.identifier, choose: .plus)
            mainVC?.tableView.reloadData()
            updatePost(mainVC!.tableViewModel.returnPostInfo(receivedData!.identifier))
            interested = true
        }else {
            heartImage.tintColor = UIColor.darkGray
            heartImage.image = UIImage(systemName: "heart")
            mainVC?.tableViewModel.calculatInterestCount(receivedData!.identifier, choose: .minus)
            mainVC?.tableView.reloadData()
            updatePost(mainVC!.tableViewModel.returnPostInfo(receivedData!.identifier))
            interested = false
        }
    }
    
    // "이 글과 함께 봤어요" 스택뷰 이미지
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    // 스택뷰 이미지에 Radius 추가
    func addRadius() {
        addRadiusToUIImageView(image1, size: 10)
        addRadiusToUIImageView(image2, size: 10)
        addRadiusToUIImageView(image3, size: 10)
        addRadiusToUIImageView(image4, size: 10)
    }
    

    // MARK: - UI 업데이트 함수
    func updatePost(_ data: SalesPost) {
        // 상품 이미지
        if data.imageString == "보스헤드셋.jpg" {
            imageUIView.isHidden = true
        }else {
            productImage.image = UIImage(named: data.imageString)
        }
        
        // 유저 닉네임, 주소, 프로필 이미지
        nickName.text = data.writer.nickName
        address.text = data.writer.address
        profileImage.image = data.writer.profileImage == nil ? UIImage(named: "userIcon.jpeg") : UIImage(named: data.writer.profileImage!)
        
        // 매너온도
        if data.writer.mannerScore >= 40 {
            mannerScore.text = String(data.writer.mannerScore)
            mannerScore.textColor = UIColor(red: 255/255, green: 173/255, blue: 57/255, alpha: 1)
            setMannerImage("노란")
        }else {
            mannerScore.text = String(data.writer.mannerScore)
            mannerScore.textColor = UIColor(red: 15/255, green: 96/255, blue: 163/255, alpha: 1)
            setMannerImage("파란")
        }
        
        // 글 정보 (제목, 카테고리, 내용, 가격)
        postTitle.text = data.title
        postCategory.text = data.category.rawValue
        postContent.text = data.content
        postPrice.text = data.price == nil ? "" : data.price == 0 ? "나눔🧡" : DecimalWon(value: data.price!)
        
        // 채팅 관심 조회수 업데이트
        chattingInterestingChecking.text = "채팅 \(data.chattingCount) ∙ 관심 \(data.interestCount) ∙ 조회 \(data.viewCount+1)"
    }
    
    // 온도 이미지 업데이트 함수
    func setMannerImage(_ color: String) {
        mannerFace.image = UIImage(named: "\(color)얼굴.jpeg")
        temperature.image = UIImage(named: "\(color)온도.png")
        mannerEnergy.image = UIImage(named: "\(color)에너지.png")
    }
    
    // MARK: - 글 정보 & 홈화면VC 가져오기
    var receivedData: SalesPost?
    var mainVC: ViewController?
    
    // MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 버튼에 Radius
        addRadiusToUIButton(toChattingButton, size: 10)
        
        // 조회수 +1
        mainVC?.tableViewModel.addViewCount(receivedData!.identifier)
        
        
        // UI 업데이트
        //updatePost(receivedData!)
        
        // 이미지에 radius 추가
        addRadius()
        
    }
    
}
