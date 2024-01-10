//
//  ExerciseInfoView.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/11/24.
//


import UIKit

import SnapKit
import Then

final class ExerciseInfoView: BaseView {
    
    // MARK: - Properties
    private let backButton = UIButton()
    private let exerciseInfoLabel = UILabel()
    private let exercisestatus = UILabel()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
    }
    let exerciseInfotableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.separatorColor = .gray100
        $0.separatorStyle = .singleLine
        $0.sectionHeaderTopPadding = 0
        $0.layer.cornerRadius = 8
        $0.tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        if #available(iOS 15, *) {
            $0.sectionHeaderTopPadding = 1
        }
    }
    
    // MARK: - Override Functions
    override func setHierachy() {
        self.addSubview(backButton)
        self.addSubview(exerciseInfoLabel)
        self.addSubview(exerciseInfotableView)
    }
    override func setUI() {
        backButton.do{
            $0.setTitle(TextLiterals.MyPage.back, for: .normal)
            $0.backgroundColor = .clear
            $0.tintColor = .gray700
        }
        exerciseInfoLabel.do{
            $0.text = TextLiterals.MyPage.exerciseInfo
            $0.textColor = .gray900
            $0.font = .heading6
        }
    }
    override func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(67.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        exerciseInfoLabel.snp.makeConstraints{
            $0.top.equalTo(backButton.snp.top)
            $0.leading.equalTo(backButton.snp.trailing).offset(109.adjusted)
            
        }
        exerciseInfotableView.snp.makeConstraints {
            $0.top.equalTo(exerciseInfoLabel.snp.bottom).offset(40.adjusted)
            $0.leading.trailing.equalToSuperview()        }
    }
    // MARK: - 이 곳은 위의 오버라이드 함수 영역과 구분될 수 있도록 자유로운 마크주석을 달아주세요
    
}
