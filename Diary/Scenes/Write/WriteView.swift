//
//  WriteView.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

class WriteView: BaseView {
    let imageView: DiaryImageView = {
        let view = DiaryImageView(frame: .zero)
        return view
    }()
    
    let addPhotoButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.image = UIImage(systemName: "photo")
        configuration.baseBackgroundColor = .systemPink
        button.configuration = configuration
        
        return button
    }()
    
    let titleTextField: RoundedTextField = {
        let view = RoundedTextField()
        view.placeholder = "제목을 입력해 주세요"
        return view
    }()
    
    let dateTextField: RoundedTextField = {
        let view = RoundedTextField()
        view.placeholder = "날짜를 입력해 주세요"
        return view
    }()
    
    let contentsTextView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = Constants.Color.tintColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        [imageView, addPhotoButton, titleTextField, dateTextField, contentsTextView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        let spacing = 20
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(imageView.snp.width).multipliedBy(0.9)
            make.top.equalTo(safeAreaLayoutGuide).offset(spacing)
        }
        
        addPhotoButton.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.height).multipliedBy(0.2)
            make.width.equalTo(addPhotoButton.snp.height)
            make.trailingMargin.bottom.equalTo(imageView).inset(16)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(imageView)
            make.height.equalTo(imageView).multipliedBy(0.12)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(12)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.width.equalTo(imageView)
            make.height.equalTo(imageView).multipliedBy(0.12)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.width.equalTo(imageView)
            make.centerX.equalToSuperview()
            make.top.equalTo(dateTextField.snp.bottom).offset(12)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-spacing)
        }
    }
}
