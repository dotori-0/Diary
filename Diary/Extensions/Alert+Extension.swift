//
//  Alert+Extension.swift
//  Diary
//
//  Created by SC on 2022/08/26.
//

import UIKit

extension UIViewController {
    func showAlertMessage(title: String, buttonTitle: String = "확인") {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
