//
//  UserDiary.swift
//  Diary
//
//  Created by SC on 2022/08/25.
//

import Foundation
import RealmSwift

class UserDiary: Object {
    @Persisted var title: String       // 제목(필수)
    @Persisted var entryDate = Date()  // 작성 날짜(필수)(선택한 날짜)
    @Persisted var writeDate = Date()  // 등록 날짜(필수)
    @Persisted var contents: String?   // 내용(옵션)
    @Persisted var isFavorite: Bool    // 즐겨찾기(필수)
    @Persisted var photoURL: String?   // 사진 String(옵션)
    
    // PK(필수): 중복 X, 빈 값 X
    // Int, String 등 (보통은 Int 사용하는데 우리가 직접 +1 해야 함)
    // Realm에서 권장하는 것은 UUID, ObjectID
    // UUID: 16 바이트, ObjectId: 12 바이트
    // UUID: 애플에서 앱을 구분해 줄 수 있는 용어로도 있지만 여기서도 그것과 같게 사용이 되는 것은 아니다
    // convenience init: 굳이 초기화를 할 필요가 없는 항목들은 빼고 초기화하는 것이 가능
    convenience init(title: String, entryDate: Date, contents: String?, photoURL: String?) {
        self.init()
        self.title = title
        self.entryDate = entryDate
        self.writeDate = Date.now
        self.contents = contents
        self.isFavorite = false
        self.photoURL = photoURL
    }
}
