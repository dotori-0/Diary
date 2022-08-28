//
//  Alert+Extension.swift
//  Diary
//
//  Created by SC on 2022/08/26.
//

import UIKit

extension UIViewController {
    func showAlertMessage(title: String, message: String? = nil, buttonTitle: String = "확인", handler: ((UIAlertAction) -> Void)? = nil) {
        // handler: @escaping ((UIAlertAction) -> Void)?)
        // Closure is already escaping in optional type argument
        // Remove '@escaping ' 👻
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .cancel, handler: handler)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
