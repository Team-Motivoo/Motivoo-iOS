//
//  MissionOverviewView.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/11/24.
//


import UIKit

import SnapKit
import Then

final class MissionOverviewView: BaseView {
    
    // MARK: - UI Components
    private let todayMissionView = UIView()
    private let todayExerciseLabel = UILabel()
    private let todayMissonLabel = UILabel()
    private let noticeView = UIView()
    private let noticeLabel = UILabel()
    private let noticeIcon = UIImageView()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    // MARK: - Override Functions
    
    override func setHierachy() {
        self.addSubviews(todayMissionView,noticeView)
        todayMissionView.addSubviews(todayExerciseLabel,todayMissonLabel)
        noticeView.addSubviews(noticeIcon,noticeLabel)
    }
    
    override func setUI() {
        todayMissionView.do {
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 8
        }
        todayExerciseLabel.do {
            $0.text = TextLiterals.MissionOverview.todayExercise
            $0.textColor = .gray600
            $0.font = .caption1
        }
        todayMissonLabel.do {
            $0.text = "8천걸음 걷고\n스쿼트 10번하기"
            $0.font = .heading3
            $0.textColor = .black
            $0.numberOfLines = 2
        }
        noticeView.do {
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 8
        }
        noticeIcon.do {
            $0.image = ImageLiterals.icon.notice
        }
        noticeLabel.do {
            $0.text = TextLiterals.MissionOverview.alertMessage
            $0.font = .caption2
            $0.textColor = .gray800
        }
    }
    
    override func setLayout() {
        todayMissionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(138.adjusted)
        }
        todayExerciseLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20.adjusted)
        }
        todayMissonLabel.snp.makeConstraints {
            $0.leading.equalTo(todayExerciseLabel.snp.leading)
            $0.top.equalTo(todayExerciseLabel.snp.bottom).offset(8.adjusted)
            $0.bottom.equalToSuperview().inset(20.adjusted)
        }
        noticeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.top.equalTo(todayMissionView.snp.bottom).offset(16.adjusted)
            $0.height.equalTo(48.adjusted)
        }
        noticeIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12.adjusted)
        }
        noticeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(noticeIcon.snp.trailing).offset(8.adjusted)
        }
    }
}
