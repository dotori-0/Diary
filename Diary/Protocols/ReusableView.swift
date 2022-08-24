//
//  ReusableView.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit


// Test 1. -> 동작 O
//protocol ReusableViewProtocol: AnyObject {
//    static var reuseIdentifier: String { get }
//
//}
//
//extension UIViewController: ReusableViewProtocol {
//    public static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}
//
////extension UICollectionViewCell: ReusableViewProtocol {
////    public static var reuseIdentifier: String {
////        return String(describing: self)
////    }
////}
////
////extension UITableViewCell: ReusableViewProtocol {
////    public static var reuseIdentifier: String {
////        return String(describing: self)
////    }
////}
//
//extension UIView: ReusableViewProtocol {
//    public static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}



// Test 2. -> 동작 O
public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    public static var reuseIdentifier: String {
//        return String(describing: Self.self)
        return String(describing: self)
    }
}

extension UIViewController: ReusableView { }

extension UIView: ReusableView { }
