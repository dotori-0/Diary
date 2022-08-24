//
//  FontSize.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

extension Constants {
    enum FontSize {
//        case title
//        case date
//        case contents
//
//        var size: UIFont {
//            switch self {
//                case .title:
//                    return UIFont.boldSystemFont(ofSize: 15)
//                case .date, .contents:
//                    return UIFont.systemFont(ofSize: 13)
//            }
//        }
        
        static let title = UIFont.boldSystemFont(ofSize: 15)
        static let date = UIFont.systemFont(ofSize: 13)
        static let contents = UIFont.systemFont(ofSize: 13)
    }
}
