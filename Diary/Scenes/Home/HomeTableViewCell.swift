//
//  HomeTableViewCell.swift
//  Diary
//
//  Created by SC on 2022/08/24.
//

import UIKit

class HomeTableViewCell: BaseTableViewCell {
    let diaryImageView: DiaryImageView = {
        let view = DiaryImageView(frame: .zero)  // 👻 .null도 확인해 보기
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Color.tintColor
        label.font = Constants.FontSize.title
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Color.tintColor
        label.font = Constants.FontSize.date
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Color.tintColor
        label.font = Constants.FontSize.contents
        return label
    }()
    
//    func makeLabel(type: Constants.FontSize) -> UILabel {
//        let label = UILabel()
//        label.textColor = Constants.Color.tintColor
//        label.font = type.size
//        return label
//    }
    
    //    let stackView: UIStackView = {
    lazy var stackView: UIStackView = {
//        let view = UIStackView()
//        view.arrangedSubviews = [titleLabel, dateLabel, contentsLabel]  // Cannot assign to property: 'arrangedSubviews' is a get-only property
        let view = UIStackView(arrangedSubviews: [titleLabel, dateLabel, contentsLabel])
        view.alignment = .leading
        view.backgroundColor = .systemGray4
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        [diaryImageView, stackView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        let spacing = 16
        
        diaryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(spacing)
//            make.trailingMargin.equalToSuperview().inset(spacing)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(diaryImageView.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(spacing)
            make.leading.equalTo(diaryImageView.snp.trailing).offset(spacing)
            make.height.equalTo(diaryImageView.snp.height)
        }
    }
    
    func showData(entry: UserDiary) {
//        diaryImageView.image = loadimage  // 👻 함수 사용 불가
        titleLabel.text = entry.title
        dateLabel.text = entry.entryDate.formatted()
        contentsLabel.text = entry.contents
    }
}
