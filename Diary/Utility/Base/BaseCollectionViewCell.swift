//
//  BaseCollectionViewCell.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() { }
    
    func setConstraints() { }
}
