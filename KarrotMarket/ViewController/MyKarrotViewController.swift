//
//  MyKarrotSceneController.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//


import UIKit

class MyKarrotViewController: MainViewController {
    
    // 사용중인 유저 닉네임
    var userStringName: String = "해피토스트"
    
    
    // 테이블뷰 연결
    @IBOutlet weak var tableView: UITableView!
    
    // Model연결
    var settingModel = SettingModel()
    
    // 테이블뷰 각 섹션에 cell을 얼마나 넣을건지 알려주는 배열
    let eachSectionCell = [1, 4, 4, 2, 3, 5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInfoTableViewCell")
        tableView.register(UINib(nibName: "UserSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "UserSettingTableViewCell")
    }
}




extension MyDaangnViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 섹션의 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return eachSectionCell.count
    }
    
    
    // 섹션 헤더 높이?
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 10.0
//    }
    
    
    // 각 섹션별로 셀이 몇개 들어가는지?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eachSectionCell[section]
    }
    
    
    // 셀을 어떤걸로 할건지ㅣ?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 매개변수로 들어오는 indexPath에 점연산자를 사용하여 section을 얻을 수 있음
        if indexPath.section == 0 {
            guard let infoCell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as? UserInfoTableViewCell else {
                return UITableViewCell()
            }
            return infoCell
        }else {
            guard let settingCell = tableView.dequeueReusableCell(withIdentifier: "UserSettingTableViewCell", for: indexPath) as? UserSettingTableViewCell else {
                return UITableViewCell()
            }
            settingCell.cellUpdate(settingModel.returnSettingInfoArr(indexPath.section)[indexPath.row])

            settingCell.selectionStyle = .none
            
            return settingCell
        }
    }
    
    // 스택오버플로
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 섹션 1번부터 적용하는 조건문
        if section > 0 {
            // UIView를 하나 생성
            let v = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 10))
            // 배경색 설정
            v.backgroundColor = .systemGray5
            // 내부에 Label을 추가하는 코드
//            let label = UILabel(frame: CGRect(x: 8.0, y: 4.0, width: v.bounds.size.width - 16.0, height: v.bounds.size.height - 8.0))
//            label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            label.text = "Header for Third Section"
//            v.addSubview(label)
            return v
        }
        // nil을 반환하면 Header가 생기지 않음
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // if it's the 3rd section
        if section > 0 {
            return 10
        }
        return 0
    }
}
