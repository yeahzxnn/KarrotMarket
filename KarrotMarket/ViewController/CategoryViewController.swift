//
//  CategoryViewController.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//

import Foundation
import UIKit

class CategoryViewController: ViewController {
    
    // 열거형 값 다 가져오기 (protocol사용)
    let categoryList = ProductCategory.allCases
    
    
    // 테이블뷰 연결
    @IBOutlet weak var categoryTableView: UITableView!
    
    
    // 글 작성 View 가져오기 (눌린 버튼으로 값 입력해주기 위함)
    var writingVC: WritingSalesPostViewController?
    
    
    
    // MARK: - TableViewCell 선택된거 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        writingVC?.categoryLabel.text = categoryList[indexPath.row].rawValue
        writingVC?.category = categoryList[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
    }
}


extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.cellUpdate(categoryList[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
