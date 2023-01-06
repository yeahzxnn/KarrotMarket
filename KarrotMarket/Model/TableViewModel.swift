//
//  TableViewModel.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//

import Foundation
import UIKit


// MARK: - 로그인 유저 정보
//class

// MARK: - User
class UserModel {
    private var storage: [String: User] = [:]
    
    init() {
        storage = [
            "해피토스트": User(nickName: "해피토스트", address: "양천구", mannerScore: 30.1),
            "레드": User(nickName: "레드", address: "삼성동", mannerScore: 40.3),
            "옐로우": User(nickName: "옐로우", address: "매봉동", mannerScore: 33.3, profileImage: "나이키.jpg"),
            "블루": User(nickName: "블루", address: "노량진", mannerScore: 33.2),
            "팝송덕후": User(nickName: "팝송덕후", address: "개봉동", mannerScore: 43.3),
            "안녕": User(nickName: "안녕", address: "노량진", mannerScore: 50.0),
            "현빈": User(nickName: "현빈", address: "삼성동", mannerScore: 33.3),
            "문상민": User(nickName: "문상민", address: "양천구", mannerScore: 44.4),
            "이재욱": User(nickName: "이재욱", address: "삼성동", mannerScore: 33.3),
            "한소희": User(nickName: "한소희", address: "한남동", mannerScore: 99.9, profileImage: "보스헤드셋.jpg"),
            "고윤정": User(nickName: "고윤정", address: "한남동", mannerScore: 99.9),
            "채형원": User(nickName: "채형원", address: "한남동", mannerScore: 36.6),
        ]
    }
    
    var count: Int {
        return storage.count
    }
    
    
    func returnUserInfo(_ nickName: String) -> User {
        return storage[nickName] ?? User(nickName: "", address: "", mannerScore: 0)
    }
}

// MARK: - SalesPostModel
class SalesPostModel {
    private var storage: [SalesPost] = []
    
    // 저장 데이터

    // 유저정보 넣으려고 가져온 변수
    private let userModel: UserModel = UserModel()
    
    init() {
        storage = [
            SalesPost(writer: userModel.returnUserInfo("한소희"), title: "나이키 덩크로우 네이처 페일코랄 255", content: "크림 구매내역 인증 가능", price: 90000, imageString: "나이키.jpg", category: .기타중고물품, identifier: 0),
            SalesPost(writer: userModel.returnUserInfo("고윤정"), title: "구찌향수", content: "사용한 상태라 싸게 팔아요", price: 10000, imageString: "구찌향수.jpg", category: .디지털기기, identifier: 1),
            SalesPost(writer: userModel.returnUserInfo("이재욱"), title: "HP프린터", content: "외관 사용감이 있으나 기능 이상없고 인쇄 빠릅니다.", price: 2700000, imageString: "프린터.jpg", category: .남성의류, identifier: 2),
            SalesPost(writer: userModel.returnUserInfo("레드"), title: "폴딩 미니밸로 루트코리아 그루 m3", content: "여행다니면서 사용해서 s급입니다", price: 266000, imageString: "폴딩.jpg", category: .디지털기기, identifier: 3),
            SalesPost(writer: userModel.returnUserInfo("블루"), title: "한컴 27인치 커브드 모니터", content: "모니터 닦으면 깨끗합니다. 닦아서 가져갈게요", price: 600000, imageString: "모니터.jpg", category: .가구인테리어, identifier: 4),
            SalesPost(writer: userModel.returnUserInfo("해피토스트"), title: "보스헤드셋", content: "에눌 가능합니다. 연락주세요", price: 300000, imageString: "보스헤드셋.jpg",category: .여성잡화, identifier: 5)
        ]
    }
    
    var count: Int {
        return storage.count
    }
    
    /// 메인화면에서 SalesPost로 데이터를 넘길 때
    /// 메인화면의 tableview index를 가지고 모델에서 데이터를 꺼내오는 함수
    func returnPostInfo(_ index: Int) -> SalesPost {
        return storage[index]
    }
    
    /// UserDefault로 데이터 저장하기 위해 배열을 통째로 리턴하는 함수
    func getStorage() -> [SalesPost] {
        return storage
    }
    
    // 조회수 +1
    func addViewCount(_ identifier: Int) {
        
        let targetIndex = storage.firstIndex(where: {
            $0.identifier == identifier
        })
        storage[targetIndex!].viewCount += 1
    }
    
    // 관심 count 조절
    enum chooseOperator {
        case plus
        case minus
    }
    func calculatInterestCount(_ identifier: Int, choose: chooseOperator) {
        let targetIndex = storage.firstIndex(where: {
            $0.identifier == identifier
        })
        if choose == .plus {
            storage[targetIndex!].interestCount += 1
        }else {
            storage[targetIndex!].interestCount -= 1
        }
    }
    
    // 글 작성
    func addPost(writer: String, title: String, content: String, category: ProductCategory, price: Int? = nil) {

        storage.append(SalesPost(writer: userModel.returnUserInfo(writer), title: title, content: content, price: price, category: category, identifier: storage[storage.count-1].identifier+1))
        
    }
    
    // 글 수정
    func modifyPost(identifier: Int, title: String, content: String, category: ProductCategory, price: Int? = nil) {
        let targetIndex = storage.firstIndex(where: {
            $0.identifier == identifier
        })
        storage[targetIndex!].title = title
        storage[targetIndex!].content = content
        storage[targetIndex!].category = category
        storage[targetIndex!].price = price
    }
    
//    // 글 삭제
    func deletePost(_ identifier: Int) {
        
        let targetIndex = storage.firstIndex(where: {
            $0.identifier == identifier
        })
        storage.remove(at: targetIndex!)
    }
}


// MARK: - 동네생활 글 모델
class VillageLiftPostModel {
    private var storage: [VillageLifePost] = []
    
    
    // 유저정보 넣으려고 가져온 변수
    private let userModel: UserModel = UserModel()
    
    
    init() {
        storage = [
            VillageLifePost(writer: userModel.returnUserInfo("한소희"), content: "같이 퍼스널 브랜딩 하실 분..?", imageString: nil, category: .동네질문, identifier: 0),
            VillageLifePost(writer: userModel.returnUserInfo("레드"), content: "혹시 좌훈 가능한 한의원 아시면 알려주세요!", imageString: "자동차 탄소.jpeg", category: .동네소식, identifier: 1),
            VillageLifePost(writer: userModel.returnUserInfo("블루"), content: "오류동에 있는 숨필라테스 어떤가요?", imageString: nil, category: .교육학원, identifier: 2),
            VillageLifePost(writer: userModel.returnUserInfo("옐로우"), content: "도시락 배달 해먹을만한 데가 있을까요? 점심은 매일 배달도시락으로 먹고 싶어서요", imageString: nil, category: .동네질문, identifier: 3),
            VillageLifePost(writer: userModel.returnUserInfo("이재욱"), content: "드럼 배우고 싶은데 혹시 학원 추천 가능할까요?", imageString: nil, category: .취미생활, identifier: 4),
            VillageLifePost(writer: userModel.returnUserInfo("채형원"), content: "혹시 전등 고칠 줄 아는 분 계신가요?...고쳐주세요ㅠ", imageString: nil, category: .해주세요, identifier: 5),
            VillageLifePost(writer: userModel.returnUserInfo("해피토스트"), content: "고양이 모래 살 수 있는데 아시는 분 있으시나요??", imageString: nil, category: .동네질문, identifier: 6),
            VillageLifePost(writer: userModel.returnUserInfo("한소희"), content: "동네 이비인후과 잘 하는데 아시나요? 독감이 안 낫네요ㅠ", imageString: nil, category: .동네질문, identifier: 7),
            VillageLifePost(writer: userModel.returnUserInfo("고윤정"), content: "등산이 취미인데 혹시 같이 등산하실 분 없으신가요??? 저는 20대이고 여자분이시면 좋겠어요", imageString: nil, category: .취미생활, identifier: 8),
            VillageLifePost(writer: userModel.returnUserInfo("한소희"), content: "차 세차하고 싶은데 혹시 좋은데 아시는 분 있나요?", imageString: nil, category: .동네질문, identifier: 9)
        ]
    }
    
    
    var count: Int {
        return storage.count
    }
    
    
    func returnPostInfo(_ index: Int) -> VillageLifePost {
        return storage[index]
    }
}




class SettingModel {
    private var storage: [Int: [Setting]] = [:]
    
    init() {
        storage = [
            1: [
                Setting(text: "판매내역", imageString: "location.circle"),
                Setting(text: "구매내역", imageString: "scope"),
                Setting(text: "관심목록", imageString: "tag"),
                Setting(text: "당근가계부", imageString: "checklist")
            ],
            2: [
                Setting(text: "동네생활 글/댓글", imageString: "square.and.pencil")
            ],
            3: [
                Setting(text: "비즈프로필 만들기", imageString: "person"),
                Setting(text: "지역광고", imageString: "megaphone"),
                Setting(text: "동네홍보 글", imageString: "newspaper")
            ],
            4: [
                Setting(text: "내 동네 설정", imageString: "location.circle"),
                Setting(text: "동네 인증하기", imageString: "scope"),
                Setting(text: "알람 키워드 알림", imageString: "tag"),
                Setting(text: "자주 묻는 질문", imageString: "newspaper"),
                Setting(text: "친구초대", imageString: "checklist")
            ]
        ]
    }
    
    
    var count: Int {
        return storage.count
    }
    
    
    func returnSettingInfoArr(_ section: Int) -> [Setting] {
        return storage[section] ?? []
    }
}




class ChattingModel {
    private var storage: [Chatting] = []
    

    // 유저정보 넣으려고 가져온 변수
    private let userModel: UserModel = UserModel()
    
    
    init() {
        storage = [
            Chatting(connectedUser: userModel.returnUserInfo("한소희"), productImage: "키보드.jpg", lastChat: "아뇨 괜찮습니다", lastChatDate: "3주 전"),
            Chatting(connectedUser: userModel.returnUserInfo("고윤정"), productImage: nil, lastChat: "입금 확인해주세요", lastChatDate: "2주 전"),
            Chatting(connectedUser: userModel.returnUserInfo("이재욱"), productImage: nil, lastChat: "오 마음에 드세요?", lastChatDate: "1주 전"),
            Chatting(connectedUser: userModel.returnUserInfo("레드"), productImage: nil, lastChat: "아뇨 괜찮습니다", lastChatDate: "3달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("안녕"), productImage: nil, lastChat: "네 알겠습니다!", lastChatDate: "1달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("블루"), productImage: nil, lastChat: "저 검은색 잠바요", lastChatDate: "3달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("해피토스트"), productImage: nil, lastChat: "학생 에눌해주세요ㅠㅠㅠㅠ", lastChatDate: "2달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("문상민"), productImage: nil, lastChat: "아뇨아뇨", lastChatDate: "3달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("옐로우"), productImage: nil, lastChat: "네네~", lastChatDate: "4달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("채형원"), productImage: nil, lastChat: "잘 쓸게요.", lastChatDate: "5달 전")
        ]
    }
    
    
    var count: Int {
        return storage.count
    }
    
    
    func returnChattingInfo(_ index: Int) -> Chatting {
        return storage[index]
    }
}

class popularSearchKeywordModel {
    private var storage: [String] = []
    
    init() {
        storage = [
            "알바",
            "타꼬야끼",
            "피부과",
            "반찬",
            "붕어빵",
            "치과",
            "운동",
            "헤드셋",
        ]
    }
    
    var count: Int {
        return storage.count
    }
    
    func returnChattingInfo(_ index: Int) -> String {
        return storage[index]
    }
}
