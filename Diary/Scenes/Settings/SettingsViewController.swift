//
//  SettingsViewController.swift
//  Diary
//
//  Created by SC on 2022/08/27.
//

import UIKit

class SettingsViewController: BaseViewController {
    let settingsView = SettingsView()
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "설정 화면"
        return label
    }()
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        title = "타이틀"  // Tab Bar Title
    }

    override func setUI() {
        super.setUI()
        print(self, #function)
        settingsView.navigationBar.delegate = self
        settingsView.addSubview(testLabel)
    }
    
    override func setConstraints() {
        testLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}


extension SettingsViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
