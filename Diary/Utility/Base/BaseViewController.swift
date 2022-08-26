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
        print(self, #function)  // ❔ HomeViewController에서 super.setUI() 호출하면, self가 왜 BaseViewController가 아니라 HomeViewController 인지?
        view.backgroundColor = Constants.Color.backgroundColor
//        view.layer.backgroundColor = UIColor.yellow.cgColor
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
