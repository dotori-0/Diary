//
//  BackupFileTableViewCell.swift
//  Diary
//
//  Created by SC on 2022/08/28.
//

import UIKit

class BackupFileTableViewCell: UITableViewCell {
    let fileIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "doc")
        view.contentMode = .scaleAspectFit
//        view.backgroundColor = .systemOrange
        view.tintColor = .mainAccent
        return view
    }()
    
    let fileNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let fileSizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray3
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [fileNameLabel, fileSizeLabel])
        view.axis = .vertical
        view.alignment = .leading
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        [fileIconImageView, stackView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        fileIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(fileIconImageView.snp.height)  // ๐ป ํด๋ก์ ์ธ๋ฐ ์ self. ๋ถ์ด์ง ์์๋ ๋๋์ง?
            // ๊ฐ๊ฒ ํ๋๋ฐ ์ ํ๋ฆฐํธํ๋ฉด height๋ 35.0, width๋ 35.5๊ฐ ์ฐํ๋์ง...
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(fileIconImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
//            make.trailing.greaterThanOrEqualTo(contentView).offset(-20)  // ๐ป ์ superview ์ ๋๋์ง..?
            make.trailing.greaterThanOrEqualTo(stackView.superview!).offset(-20)  // ์ ์ด๊ฑด ๋๋์ง
            make.height.equalTo(contentView).multipliedBy(0.6)
        }
    }
}
