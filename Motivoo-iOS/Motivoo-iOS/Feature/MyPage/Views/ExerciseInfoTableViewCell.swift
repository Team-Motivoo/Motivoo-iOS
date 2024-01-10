//
//  ExerciseInfoTableViewCell.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/8/24.
//

import UIKit

import SnapKit
import Then

class ExerciseInfoTableViewCell: UITableViewCell {
        
    private let exerciseInfoLabel = UILabel()
    private let exerciseImage = UIImageView()
    private let arrowIconImageView = UIImageView()
    private let checkExerciseInfoLabel = UILabel()
    private let stackView = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setHierachy()
        setLayout()
        setUI()
    }
    func setUI(){
        exerciseInfoLabel.do{
            $0.text = TextLiterals.MyPage.exerciseInfo
            $0.textColor = .gray900
            $0.font = .heading6
        }
        exerciseImage.do{
            $0.image = ImageLiterals.icon.home
            $0.contentMode = .scaleAspectFill
        }
        arrowIconImageView.do{
            $0.image = ImageLiterals.icon.rightArrow
        }
        checkExerciseInfoLabel.do{
            $0.text = TextLiterals.MyPage.checkExerciseInfo
            $0.textColor = .gray500
            $0.font = .caption2
        }
        stackView.do{
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 1.adjusted
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierachy() {
        contentView.addSubview(stackView)
        contentView.addSubview(exerciseImage)
        stackView.addArrangedSubviews(exerciseInfoLabel,
                                   checkExerciseInfoLabel)
        contentView.addSubview(arrowIconImageView)
    }
    func setLayout() {
        exerciseImage.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.width.equalTo(40.adjusted)
            $0.height.equalTo(40.adjusted)
        }
        stackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(exerciseImage.snp.trailing).offset(12.adjusted)
        }
        arrowIconImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
    }
}


