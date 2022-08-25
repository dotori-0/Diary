//
//  BaseViewController.swift
//  Diary
//
//  Created by SC on 2022/08/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)  // <Diary.HomeViewController: 0x130708ad0> viewDidLoad() 출력됨
        setUI()
        setConstraints()
        setTargets()
    }
    
    func setUI() {
        print(self, #function)  // 출력 안 됨
//        view.backgroundColor = .systemPink  // 동작 X
        view.layer.backgroundColor = UIColor.yellow.cgColor  // 동작 X
    }
    
    func setConstraints() { }
    
    func setTargets() { }
    
//    func showAlertMessage(title: String, buttonTitle: String = "확인") {
//        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
//        let ok = UIAlertAction(title: buttonTitle, style: .cancel)
//        alert.addAction(ok)
//
//        present(alert, animated: true)
//    }
}
