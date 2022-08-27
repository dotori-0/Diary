//
//  HomeViewController.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

import RealmSwift  // Realm 1. import
import SwiftUI


class HomeViewController: BaseViewController {
    
    let localRealm = try! Realm()  // Realm 2.
    var tasks: Results<UserDiary>! {
        didSet {
            print("Tasks Changed")
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
       let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 100
        view.backgroundColor = .clear
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        return view
    }()  // 즉시 실행 클로저

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면 갱신은 화면 전환 코드 및 생명 주기 실행 점검 필요!
        // present, overCurrentContext, overFullScreen > viewWillAppear X (화면이 사라진다고 생각하지 않고 루트 뷰가 그대로 남아 있기 때문)
        fetchRealm()
//        tableView.reloadData()  // didSet 처리를 했으므로 주석 처리
    }
    
    
    override func setUI() {
        super.setUI()
//        print(self, #function)
        
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        
        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = Constants.Color.backgroundColor
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func fetchRealm() {
        // Realm 3. Realm 데이터를 정렬해 tasks에 담기
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "entryDate", ascending: false)
    }
    
    
    @objc func addButtonClicked() {
        let vc = WriteViewController()
        transition(vc, transitionStyle: .presentFullScreenNavigation)
    }
    
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    
    @objc func filterButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'A'")
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("numberOfRowsInSection")
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("cellForRowAt")
//        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier) as? HomeTableViewCell else {
            print("Cannot find HomeTableViewCell")
            return UITableViewCell()
        }
        
        cell.showData(entry: tasks[indexPath.row])
        
        let fileName = "\(tasks[indexPath.row].objectId).jpg"
        cell.diaryImageView.image = loadImageFromDocuments(fileName: fileName)  // 👻 셀 파일로 작업 옮기기
        
        return cell
    }
    
    // 참고: TableView Editing Mode (데이터 일치시키는 기능이 조금 힘들다)
    // 테이블 뷰 셀 높이가 작을 경우, 이미지가 없을 때, 시스템 이미지가 아닌 경우 어떤지 확인해 보기
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        completionHandler(true)  // 넣어도 됨
        
        let task = self.tasks[indexPath.row]
        print("before:", task.isFavorite)
        
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            
            do {
                try self.localRealm.write {
                    task.isFavorite.toggle()
                }
            } catch let error {
                self.showAlertMessage(title: "즐겨찾기 수정에 실패했습니다.")
                print(error)
            }
            
            self.tableView.reloadData()
        }
        
        print("after:", task.isFavorite)
        
        let symbolName = task.isFavorite ? "heart.fill" : "heart"
        favorite.image = UIImage(systemName: symbolName)
        favorite.backgroundColor = .systemPink
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completion in
//            let task = self.tasks[indexPath.row]
            
//            self.removeImageFromDocuments(fileName: "\(task.objectId).jpg")
            self.removeImageFromDocuments(fileName: "\(self.tasks[indexPath.row].objectId).jpg")
            
            do {
                try self.localRealm.write {
                    print("tasks before: \(self.tasks.count)")
//                    self.localRealm.delete(task)               // tasks에서도 지워진다
                    self.localRealm.delete(self.tasks[indexPath.row])
                    print("tasks after: \(self.tasks.count)")  // 👻 tasks가 바뀌는데도 didSet 실행되지 않는 이유?
                }
            } catch let error{
                self.showAlertMessage(title: "일기 삭제에 실패했습니다.")
                print(error)
            }
            
            self.tableView.reloadData()  // 👻 didSet이 실행이 되지 않아서 리로드를 따로 해 주어야 한다...ㅠㅠ..ㅠ...
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
