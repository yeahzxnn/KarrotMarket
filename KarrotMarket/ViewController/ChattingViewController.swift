//
//  ChattingViewController.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//

import Foundation
import UIKit

class ChattingViewController: MainViewController {
    
    // 채팅 테이블뷰 모델
    var tableViewModel = ChattingModel()
    
    // 테이블뷰 연결
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = tableView.frame.width / 4.5
        
        tableView.register(UINib(nibName: "ChattingTableViewCell", bundle: nil), forCellReuseIdentifier: "ChattingTableViewCell")
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewCell", for: indexPath) as? ChattingTableViewCell else {
            return UITableViewCell()
        }
        cell.cellUpdate(tableViewModel.returnChattingInfo(indexPath.row))
        cell.selectionStyle = .none
        
        return cell
    }
    
}

