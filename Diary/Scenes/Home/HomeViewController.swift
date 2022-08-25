//
//  HomeViewController.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

import RealmSwift


class HomeViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
       let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 100
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .systemIndigo
    }
    
    override func setUI() {
        print(self, #function)
        
        // 둘 다 적용됨
//        view.layer.backgroundColor = UIColor.yellow.cgColor
//        view.backgroundColor = .systemPink
        view.backgroundColor = Constants.Color.backgroundColor
        
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func addButtonClicked() {
        let vc = WriteViewController()
        transition(vc, transitionStyle: .presentFullScreenNavigation)
    }
    
    @objc func sortButtonClicked() {
        
    }
    
    @objc func filterButtonClicked() {
        
    }
    
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("numberOfRowsInSection")
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("cellForRowAt")
//        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier) as? HomeTableViewCell else {
            print("Cannot find HomeTableViewCell")
            return UITableViewCell()
        }
        
        return cell
    }
}
