//
//  VillageLifeViewController.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//


import Foundation
import UIKit
import MaterialComponents.MaterialButtons

class VillageLifeViewController: ViewController {
    
    var tableViewModel = VillageLiftPostModel()
    
    // MARK: - TableView 연결
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryNib = UINib(nibName: "VLCategoryTableViewCell", bundle: nil)
        let cellNib = UINib(nibName: "VillageLifeTableViewCell", bundle: nil)
        
        tableView.register(categoryNib, forCellReuseIdentifier: "VLCategoryTableViewCell")
        tableView.register(cellNib, forCellReuseIdentifier: "VillageLifeTableViewCell")
        
        // 동적 높이 조절
        tableView.estimatedRowHeight = tableView.frame.width / 10
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setFloatingButton()
    }
    
    // MARK: - 플러팅 버튼 함수
    func setFloatingButton() {
        let floatingButton = MDCFloatingButton()
        let image = UIImage(systemName: "applepencil")
//        let image = UIImage(named: "공감하기.jpeg")
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

extension VillageLifeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VLCategoryTableViewCell", for: indexPath) as? VLCategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        }else {
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: "VillageLifeTableViewCell", for: indexPath) as? VillageLifeTableViewCell else {
                return UITableViewCell()
            }
            postCell.cellUpdate(tableViewModel.returnPostInfo(indexPath.row))
            postCell.selectionStyle = .none
            return postCell
        }
    }
    
    // MARK: - 플로팅 버튼 함수
    @objc func tap(_ sender: Any) {
        print("동네생활 글쓰기 버튼 눌림")
    }
}
