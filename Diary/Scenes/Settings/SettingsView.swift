//
//  SettingsView.swift
//  Diary
//
//  Created by SC on 2022/08/28.
//

import UIKit

class SettingsView: BaseView {
    
    // MARK: - Properties
    
    var navigationBar = UINavigationBar()
    
    let cloudImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "icloud.and.arrow.up")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemMint
        return view
    }()
    
    let backupInfoLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.Strings.backupInfo
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .yellow
        return label
    }()
    
    let backupButton: RoundedButton = {
        return RoundedButton(title: "백업하기")
    }()
    
    let bringBackupFileButton: RoundedButton = {
        return RoundedButton(title: "복원할 백업 파일 가져오기")
    }()
    
    let restoreInfoLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.Strings.restoreInfo
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .systemGreen
        return label
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    
    // MARK: - Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        super.setUI()
        [cloudImageView, backupInfoLabel, backupButton, bringBackupFileButton, restoreInfoLabel, tableView].forEach {
            addSubview($0)
        }
        
        // 네비게이션 컨트롤러 없이 네비바 넣기 - status bar 높이 구하기 실패..
        let screenWidth = UIScreen.main.bounds.width
//        let statusBarManager = UIStatusBarManager
//        let statusBarHeight = statusBarManager.statusBarFrame.height
//        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height
//        print(statusBarHeight)  // nil
//        let statusBarHeight =  window?.safeAreaLayoutGuide.layoutFrame.height
//        print(statusBarHeight)  // nil
        
//        guard view.window != nil else {
//            print("Cannot find window")  // 여기서 Cannot find window가 찍힌다...ㅠㅠ.ㅠ
//            return
//        }
//        guard view.window?.windowScene != nil else {
//            print("Cannot find windowScene")
//            return
//        }
//        guard view.window?.windowScene?.statusBarManager != nil else {
//            print("Cannot find statusBarManager")
//            return
//        }
        
//        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight!, width: screenWidth, height: 44))
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: screenWidth, height: 44))
//        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "설정")
        navigationBar.setItems([navigationItem], animated: true)
        
//        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemMint
        
        addSubview(navigationBar)
//        navigationController?.title = "네비 컨트롤러"
//        title = "타이틀"
    }
    
    override func setConstraints() {
        cloudImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(36)
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalTo(cloudImageView.snp.width)
        }
        
        backupInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(cloudImageView.snp.trailing).offset(20)
            make.centerY.equalTo(cloudImageView)
//            make.trailing.greaterThanOrEqualToSuperview().offset(20)  // X
//            make.trailing.greaterThanOrEqualToSuperview().inset(-20)  // X
//            make.trailing.greaterThanOrEqualTo(superview.snp.trailing - 20)  // X
            make.trailing.equalToSuperview().offset(-20)  // O
        }
        
        backupButton.snp.makeConstraints { make in
            make.top.equalTo(backupInfoLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(44)
        }
        
        bringBackupFileButton.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(44)
        }
        
        restoreInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(bringBackupFileButton.snp.bottom).offset(8)
            make.width.equalTo(bringBackupFileButton).inset(12)
            make.centerX.equalTo(bringBackupFileButton)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(restoreInfoLabel.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
