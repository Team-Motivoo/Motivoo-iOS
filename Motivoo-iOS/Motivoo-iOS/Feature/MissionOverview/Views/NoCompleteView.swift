//
//  NoCompleteView.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/14/24.
//

import UIKit

import SnapKit
import Then

final class NoCompleteView: BaseView {
    
    // MARK: - UI Components
    
    let goExerciseButton = UIButton()
    private let sleepIconImageView = UIImageView()
    private let noExerciseMsgLable = UILabel()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    // MARK: - Override Functions
    
    override func setHierachy() {
        self.addSubviews(sleepIconImageView,noExerciseMsgLable, goExerciseButton)
    }
    
    override func setUI() {
        sleepIconImageView.do {
            $0.image = ImageLiterals.icon.noexercise
        }
        noExerciseMsgLable.do {
            $0.text = TextLiterals.NoComplete.goExerciseMessage
            $0.numberOfLines = 2
            $0.font = .body6
            $0.textColor = .gray700
            $0.textAlignment = .center // 가운데 정렬 설정
        }
        goExerciseButton.do {
            $0.titleLabel?.font = .body5
            $0.setTitle(TextLiterals.NoComplete.goTodayExercise, for: .normal)
            $0.backgroundColor = .black
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }
    }
    
    override func setLayout() {
        sleepIconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(225.adjusted)
            $0.width.equalTo(120.adjusted)
            $0.height.equalTo(120.adjusted)
        }
        noExerciseMsgLable.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sleepIconImageView.snp.bottom)
        }
        goExerciseButton.snp.makeConstraints {
            $0.top.equalTo(noExerciseMsgLable.snp.bottom).offset(80.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(220.adjusted)
            $0.height.equalTo(52.adjusted)
        }
    }
    
}
