//
//  HomeViewController.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

import RealmSwift  // Realm 1. import


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
        fetchRealm()
//        tableView.reloadData()
    }
    
    
    override func setUI() {
        super.setUI()
        print(self, #function)
        
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
}
