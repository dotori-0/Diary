//
//  DiaryImageView.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

class DiaryImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Constants.Color.tintColor.cgColor
        clipsToBounds = true
    }
}
