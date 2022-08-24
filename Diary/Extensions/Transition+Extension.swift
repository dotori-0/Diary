//
//  Transition+Extension.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

extension UIViewController {
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFullScreenNavigation
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle) {
        switch transitionStyle {
            case .present:
                present(viewController, animated: true)
            case .presentNavigation:
                let nav = UINavigationController(rootViewController: viewController)
                present(nav, animated: true)
            case .presentFullScreenNavigation:
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            case .push:
                navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
