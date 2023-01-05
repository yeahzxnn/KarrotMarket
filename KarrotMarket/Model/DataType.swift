//
//  DataType.swift
//  KarrotMarket
//
//  Created by 신예진 on 2023/01/05.
//

// MARK: - 사용자 타입
struct User {
    var nickName: String
    var address: String
    var mannerScore: Float
    var profileImage: String?
}

// MARK: - 판매 게시글 타입
struct SalesPost {
    let writer: User
    var title: String
    var content: String
    var price: Int?
    var imageString: String = "기본이미지.jpeg"
    var category: ProductCategory
    var chattingCount: Int = 0
    var interestCount: Int = 0
    var viewCount: Int = 0
    var identifier: Int
}

// MARK: - 상품 카테고리
enum ProductCategory: String, CaseIterable {
    case 디지털기기 = "디지털기기"
    case 생활가전 = "생활가전"
    case 가구인테리어 = "가구/인테리어"
    case 유아동 = "유아동"
    case 생활가공식품 = "생활/가공식품"
    case 유아도서 = "유아도서"
    case 여성잡화 = "여성잡화"
    case 여성의류 = "여성의류"
    case 남성잡화 = "남성잡화"
    case 남성의류 = "남성의류"
    case 도서티켓음반 = "도서/티켓/음반"
    case 반려동물용품 = "반려동물용품"
    case 식물 = "식물"
    case 삽니다 = "삽니다"
    case 스포츠레저 = "스포츠/레저"
    case 뷰티미용 = "뷰티/미용"
    case 게임취미 = "게임/취미"
    case 기타중고물품 = "기타 중고물품"
}

// MARK: - 글쓰기 View Header Text
enum HeaderText: String {
    case 거래추가 = "중고거래 글쓰기"
    case 거래수정 = "중고거래 글 수정하기"
    case 동네추가 = "동네생활 글쓰기"
    case 동네수정 = "동네생활 글 수정하기"
}

// MARK: - 동네생활 글 타입
struct VillageLifePost {
    let writer: User
    var content: String
    var imageString: String?
    var category: VLCategory
    var identifier: Int
}

// MARK: - 동네생활 글 카테고리
enum VLCategory: String {
    case 동네질문 = "동네질문"
    case 동네맛집 = "동네맛집"
    case 동네소식 = "동네소식"
    case 취미생활 = "취미생활"
    case 분실실종센터 = "분실/실종센터"
    case 동네사건사고 = "동네사건사고"
    case 해주세요 = "해주세요"
    case 인테리어 = "인테리어"
    case 교육학원 = "교육/학원"
    case 동네사진전 = "동네사진전"
    case 출산육아 = "출산/육아"
}

// MARK: - 나의당근View 설정 타입
struct Setting {
    let text: String
    let imageString: String
}

// MARK: - Chatting 타입
struct Chatting {
    let connectedUser: User
    let productImage: String?
    var lastChat: String
    var lastChatDate: String
}
