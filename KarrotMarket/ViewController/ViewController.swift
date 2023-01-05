//
//  ViewController.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/04.
//

import UIKit
import MaterialComponents.MaterialButtons

class ViewController: MainViewController {

    // 테이블뷰 모델
    var tableViewModel = SalesPostModel()
    
    // 테이블뷰
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View 전환 (상품 정보 페이지로)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let salesVC = storyboard?.instantiateViewController(withIdentifier: "salesPostView") as? SalesPostViewController else {
            return
        }
        salesVC.receivedData = tableViewModel.returnPostInfo(indexPath.row)
        salesVC.mainVC = self
        
        tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.pushViewController(salesVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate 지정
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SalesPostTableViewCell", bundle: nil), forCellReuseIdentifier: "salesCell")
        
        
//        // 테이블뷰 높이 설정
        tableView.rowHeight = tableView.frame.width / 2.7
//        // 테이블뷰 사이즈 예측값을 넣어줄 수 있음
//        tableView.estimatedRowHeight = 150
        
        
        // 플로팅 버튼 불러오기
        setFloatingButton()
    }

    
    
    
    // MARK: - 플러팅 버튼 함수
    func setFloatingButton() {
            let floatingButton = MDCFloatingButton()
            let image = UIImage(systemName: "plus")
            floatingButton.sizeToFit()
            floatingButton.translatesAutoresizingMaskIntoConstraints = false
            floatingButton.setImage(image, for: .normal)
            floatingButton.setImageTintColor(.white, for: .normal)
        floatingButton.backgroundColor = UIColor(red: 255/255, green: 173/255, blue: 57/255, alpha: 1)
            floatingButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
            view.addSubview(floatingButton)
            view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -100))
            view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -20))
        }
    
    
}


// MARK: - Protocol 채택
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "salesCell", for: indexPath) as? SalesPostTableViewCell else {
            return UITableViewCell()
        }
        
        let postData = tableViewModel.returnPostInfo(indexPath.row)
        
        // cell 선택될 때 회색배경 생기는거 없애기
        cell.selectionStyle = .none
        
        // 셀 내용 업데이트
        cell.cellUpdate(postData)
        
        
        return cell
    }
    
    
    
    
    // MARK: - 플로팅 버튼 함수
    @objc func tap(_ sender: Any) {
        guard let writingVC = storyboard?.instantiateViewController(withIdentifier: "writingNavigationController") as? UINavigationController else {
            return
        }
        
        guard let writeVC = writingVC.viewControllers[0] as? WritingSalesPostViewController else {
            return
        }
        writeVC.homeVC = self
        writeVC.headerText = HeaderText.거래추가.rawValue
        
        self.present(writingVC, animated: true, completion: nil)
    }
}
