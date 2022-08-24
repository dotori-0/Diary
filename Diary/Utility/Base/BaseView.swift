//
//  BaseView.swift
//  Diary
//
//  Created by SC on 2022/08/23.
//

import UIKit

class BaseView: UIView {
    // 코드 베이스
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    // xib 베이스, Protocol 기반
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
//        self.backgroundColor = Constants.Color.backgroundColor
//        self.layer.backgroundColor = Constants.Color.backgroundColor.cgColor
//        backgroundColor = .systemBackground
        layer.backgroundColor = UIColor.systemBackground.cgColor
        
    }
    
    func setConstraints() { }
}
