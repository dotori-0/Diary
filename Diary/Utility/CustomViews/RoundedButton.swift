//
//  RoundedButton.swift
//  Diary
//
//  Created by SC on 2022/08/28.
//

import UIKit

class RoundedButton: UIButton {
    var title: String
    
//    init() {
//        super.init(frame: .zero)
//    }
    
//    convenience init(title: String) {
//        self.init()
//        self.title = title
//    }
    
    required init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setUI()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    

    
//    init(title: String) {
//        self.title = title
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = Constants.Color.backupButton
        
        configuration = config
    }
}
