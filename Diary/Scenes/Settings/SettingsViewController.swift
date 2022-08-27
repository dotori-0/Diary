//
//  SettingsViewController.swift
//  Diary
//
//  Created by SC on 2022/08/27.
//

import UIKit

class SettingsViewController: BaseViewController {
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "설정 화면"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setUI() {
        super.setUI()
        
        view.addSubview(testLabel)
    }
    
    override func setConstraints() {
        testLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
