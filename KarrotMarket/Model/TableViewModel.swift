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
            "해피토스트": User(nickName: "해피토스트", address: "양천구", mannerScore: 30.1, profileImage: "프로필3.jpeg"),
            "레드": User(nickName: "레드", address: "삼성동", mannerScore: 40.3),
            "옐로우": User(nickName: "옐로우", address: "매봉동", mannerScore: 33.3, profileImage: "프로필2.jpeg"),
            "블루": User(nickName: "블루", address: "노량진", mannerScore: 33.2, profileImage: "프로필5.jpeg"),
            "팝송덕후": User(nickName: "팝송덕후", address: "개봉동", mannerScore: 43.3, profileImage: "프로필1.jpeg"),
            "안녕": User(nickName: "안녕", address: "노량진", mannerScore: 50.0),
            "현빈": User(nickName: "현빈", address: "삼성동", mannerScore: 33.3),
            "문상민": User(nickName: "문상민", address: "양천구", mannerScore: 44.4),
            "이재욱": User(nickName: "이재욱", address: "삼성동", mannerScore: 33.3),
            "한소희": User(nickName: "한소희", address: "한남동", mannerScore: 99.9, profileImage: "프로필4.jpeg"),
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
            SalesPost(writer: userModel.returnUserInfo("한소희"), title: "나이키 덩크로우 네이처 페일코랄 255", content: "크림 구매내역 인증 가능", price: 90000, imageString: "청소기.jpg", category: .기타중고물품, identifier: 0),
            SalesPost(writer: userModel.returnUserInfo("고윤정"), title: "아이패드 10.5", content: "상태좋아요\n직접보고 구매하세요\n당근페이 거래하면 5처넌 네고 가능해요", price: 300000, imageString: "아이패드.jpg", category: .디지털기기, identifier: 1),
            SalesPost(writer: userModel.returnUserInfo("비움"), title: "바람막이", content: "노스페이스 바람막이\n제작년에 정가 10만원에 구매했어요. 싸게 가져가세요", price: 10000, imageString: "바람막이.jpg", category: .남성의류, identifier: 2),
            SalesPost(writer: userModel.returnUserInfo("노구트"), title: "키보드", content: "청축 기계식 키보드 키감이 매우 훌륭합니다 차각차각한거 좋아하시면 추천 디자인도 감성있어요", price: 50000, imageString: "키보드.jpg", category: .디지털기기, identifier: 3),
            SalesPost(writer: userModel.returnUserInfo("인기제품"), title: "게이밍 의자", content: "사용감있어요. 비대면거래 선호\n거래 후 반품환불 불가능합니다.", price: 30000, imageString: "게이밍의자.jpg", category: .가구인테리어, identifier: 4),
            SalesPost(writer: userModel.returnUserInfo("비움"), title: "캔들워머 미개봉", content: "선물받은거 미개봉입니다.", price: 15000, category: .여성잡화, identifier: 5)
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
            VillageLifePost(writer: userModel.returnUserInfo("에이든"), content: "혹시 언남동 근처에서 가방수선하는곳 아시는분 계실까요? 옷수선뿐이 없어서요..", imageString: nil, category: .동네질문, identifier: 0),
            VillageLifePost(writer: userModel.returnUserInfo("당근마"), content: "좋은정보같아서~ 공유합니다^^ 자동차탄소포인트제라고 최대 10만원까지 환급 가능하다고 해요~ 저는 아침에 신청했어요~^^", imageString: "자동차 탄소.jpeg", category: .동네소식, identifier: 1),
            VillageLifePost(writer: userModel.returnUserInfo("비움"), content: "5세 아이 함께 케이팝 배우실분 연락 주세요 저번에 오마이걸 배웠는데 곧잘 따라하더라구요 다른곡도 하고싶은데 개인강습은 좀 비싸서 같이 그룹으로 할 친구 구하고 있어요!\n\n구갈에 연습실이 있고 시간은 서로 조율하면 될거같아요!!", imageString: nil, category: .교육학원, identifier: 2),
            VillageLifePost(writer: userModel.returnUserInfo("노구트"), content: "초당고에 일진 많이 있나요?", imageString: nil, category: .동네질문, identifier: 3),
            VillageLifePost(writer: userModel.returnUserInfo("인기제품"), content: "칼리바를 배울 수 있는 가까운곳.. 방법이 있을까요?", imageString: nil, category: .취미생활, identifier: 4),
            VillageLifePost(writer: userModel.returnUserInfo("노구트"), content: "베란다에 세탁기 연결하는 수전 온수에 물이 새는데요.. 봐주실분 계신가요ㅠㅠ 밤이라 철물점에도 못하겠고 도와주실분..", imageString: nil, category: .해주세요, identifier: 5),
            VillageLifePost(writer: userModel.returnUserInfo("에이든"), content: "마북동 음쓰 수거일이 월, 수로 알고있는데 혹시 바뀌었나용?", imageString: nil, category: .동네질문, identifier: 6),
            VillageLifePost(writer: userModel.returnUserInfo("비움"), content: "여성 탈모 피부과 좋은 곳 있을까요~~~? 가격 착하고 효과보신곳 있으시면 추천 부탁해용~~", imageString: nil, category: .동네질문, identifier: 7),
            VillageLifePost(writer: userModel.returnUserInfo("에이든"), content: "안녕하십니까.. 기흥구에 사는 40대 후반 직장인 이웃입니다.. 건강을 위해 걷기, 등산을 같이 하실분 계실까 해서 올려봅니다...\n\n용인 주변 산뿐만 아니라, 서울권역 산도 가끔 다닙니다.\n직장인이라 주로, 주말에 다닙니다.\n\n혼자서 다녔지만, 서로 시간될떄 함께 할 분들이 계셨으면 더 좋을듯해서 글 올립니다.", imageString: nil, category: .취미생활, identifier: 8),
            VillageLifePost(writer: userModel.returnUserInfo("당근마"), content: "노터치 자동세차 기흥역 근처에 있나요? 아는곳 있으시면 추천 부탁드려요", imageString: nil, category: .동네질문, identifier: 9)
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
                Setting(text: "내 동네 설정", imageString: "location.circle"),
                Setting(text: "동네 인증하기", imageString: "scope"),
                Setting(text: "키워드 알림", imageString: "tag"),
                Setting(text: "관심 카테고리 설정", imageString: "checklist")
            ],
            2: [
                Setting(text: "모아보기", imageString: "square.grid.2x2"),
                Setting(text: "당근 가계부", imageString: "book.closed"),
                Setting(text: "받은 쿠폰함", imageString: "ticket"),
                Setting(text: "내 단골 가게", imageString: "house")
            ],
            3: [
                Setting(text: "동네생활 글/댓글", imageString: "square.and.pencil"),
                Setting(text: "동네 가게 후기", imageString: "text.bubble")
            ],
            4: [
                Setting(text: "비즈프로필 만들기", imageString: "person"),
                Setting(text: "동네홍보 글", imageString: "newspaper"),
                Setting(text: "지역광고", imageString: "megaphone")
            ],
            5: [
                Setting(text: "친구초대", imageString: "envelope"),
                Setting(text: "당근마켓 공유", imageString: "point.3.connected.trianglepath.dotted"),
                Setting(text: "공지사항", imageString: "mic"),
                Setting(text: "자주 묻는 질문", imageString: "questionmark.circle"),
                Setting(text: "앱 설정", imageString: "gear.circle")
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
            Chatting(connectedUser: userModel.returnUserInfo("노구트"), productImage: "키보드.jpg", lastChat: "네 감사합니다~", lastChatDate: "1주 전"),
            Chatting(connectedUser: userModel.returnUserInfo("리신"), productImage: nil, lastChat: "문자로 보냈습니다.", lastChatDate: "4주 전"),
            Chatting(connectedUser: userModel.returnUserInfo("제이스"), productImage: "청소기.jpg", lastChat: "어디쪽에 계세요?", lastChatDate: "4주 전"),
            Chatting(connectedUser: userModel.returnUserInfo("당근마"), productImage: nil, lastChat: "넵", lastChatDate: "1달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("비움"), productImage: "바람막이.jpg", lastChat: "네 알겠습니다!", lastChatDate: "1달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("인기제품"), productImage: "게이밍의자.jpg", lastChat: "지금 내려갈게요!", lastChatDate: "2달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("문도"), productImage: nil, lastChat: "지금 갑니다.", lastChatDate: "2달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("미달드려"), productImage: nil, lastChat: "달려갑니다.", lastChatDate: "3달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("소나"), productImage: nil, lastChat: "네네~", lastChatDate: "4달 전"),
            Chatting(connectedUser: userModel.returnUserInfo("이즈"), productImage: nil, lastChat: "잘 쓸게요.", lastChatDate: "5달 전")
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
            "헤듣셋",
        ]
    }
    
    var count: Int {
        return storage.count
    }
    
    func returnChattingInfo(_ index: Int) -> String {
        return storage[index]
    }
}
