//
//  MissionEmptyView.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 4/3/24.
//

import UIKit

import SnapKit
import Then

final class MissionEmptyView: BaseView {

    // MARK: - UI Components
    private let emptyImageView = UIImageView()
    private let emptyLabel = UILabel()
    let goExerciseButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }

    // MARK: - Override Functions

    override func setHierachy() {
        addSubviews(emptyImageView, emptyLabel, goExerciseButton)
    }

    override func setUI() {
        emptyImageView.do {
            $0.image = ImageLiterals.img.notexerciseRed
        }
        emptyLabel.do {
            $0.text = TextLiterals.MissionOverview.emptyMission
            $0.textColor = .gray700
            $0.textAlignment = .center
            $0.numberOfLines = 2
            $0.font = .body6
        }
        goExerciseButton.do {
            $0.setTitle(TextLiterals.NoComplete.goTodayExercise, for: .normal)
            $0.titleLabel?.font = .body5
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .gray900
        }
    }

    override func setLayout() {
        emptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(178.adjusted)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(120.adjusted)
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        goExerciseButton.snp.makeConstraints {
            $0.top.equalTo(emptyLabel.snp.bottom).offset(80.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(220.adjusted)
            $0.height.equalTo(52.adjusted)
        }
    }
}

