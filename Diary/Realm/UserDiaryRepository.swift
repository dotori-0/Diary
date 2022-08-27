//
//  UserDiaryRepository.swift
//  Diary
//
//  Created by SC on 2022/08/27.
//

import Foundation

import RealmSwift

protocol RealmProtocol {
    func fetch() -> Results<UserDiary>
    func sort() -> Results<UserDiary>
    func filter() -> Results<UserDiary>
    func updateFavorite(entry: UserDiary, errorHandler: @escaping () -> ())
    func deleteEntry(_ entry: UserDiary, errorHandler: @escaping () -> ())
    func writeEntry(_ entry: UserDiary, errorHandler: @escaping () -> ())
}


struct UserDiaryRepository: RealmProtocol {
    let localRealm = try! Realm()
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "entryDate", ascending: false)
    }
    
    func sort() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    func filter() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'A'")
    }
    
    func updateFavorite(entry: UserDiary, errorHandler: @escaping () -> ()) {
        do {
            try self.localRealm.write {
                entry.isFavorite.toggle()
            }
        } catch let error {
//            self.showAlertMessage(title: "즐겨찾기 수정에 실패했습니다.")
            errorHandler()
            print(error)
        }
    }
    
    func deleteEntry(_ entry: UserDiary, errorHandler: @escaping () -> ()) {
        do {
            try localRealm.write {
//                print("tasks before: \(self.tasks.count)")
                self.localRealm.delete(entry)               // tasks에서도 지워진다
//                print("tasks after: \(self.tasks.count)")  // 👻 tasks가 바뀌는데도 didSet 실행되지 않는 이유?
            }
        } catch let error {
//            self.showAlertMessage(title: "일기 삭제에 실패했습니다.")
            errorHandler()
            print(error)
        }
    }
    
    func writeEntry(_ entry: UserDiary, errorHandler: @escaping () -> ()) {
        do {
            try localRealm.write {
                localRealm.add(entry)
            }
        } catch let error {
            errorHandler()
            print(error)
        }
        
    }
}
