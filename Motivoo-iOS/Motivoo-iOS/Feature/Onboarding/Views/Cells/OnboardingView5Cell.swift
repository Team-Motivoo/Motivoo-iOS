//
//  OnboardingView5Cell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/12/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingView5Cell: UICollectionViewCell {
    private let bgView = UIView()
    let question5Title = UILabel()
    var buttonStackView = UIStackView()
    let minutes30Button = MotivooButton(text: TextLiterals.Onboarding.Q3.thirtyMinutes, buttonStyle: .borderGray100)
    let oneHourButton = MotivooButton(text: TextLiterals.Onboarding.Q3.oneHour, buttonStyle: .borderGray100)
    let twoHourButton = MotivooButton(text: TextLiterals.Onboarding.Q3.twoHour, buttonStyle: .borderGray100)
    let twoHoueOverButton = MotivooButton(text: TextLiterals.Onboarding.Q3.twoHourOver, buttonStyle: .borderGray100)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierachy()
        setLayout()
        minutes30Button.isSelected = true
        oneHourButton.isSelected = true
        twoHourButton.isSelected = true
        twoHoueOverButton.isSelected = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Functions

    func setUI() {
        question5Title.do {
            $0.text = TextLiterals.Onboarding.Q3.howLongExercise
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.addLineHeight(lineHeight: 33.6.adjusted)
        }
        buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = 16
            $0.alignment = .center
        }
        minutes30Button.accessibilityIdentifier = "thirtyMinutes"
        oneHourButton.accessibilityIdentifier = "oneHour"
        twoHourButton.accessibilityIdentifier = "twoHour"
        twoHoueOverButton.accessibilityIdentifier = "twoHourOver"
    }

    func setHierachy() {
        contentView.addSubviews(bgView)
        bgView.addSubviews(question5Title, buttonStackView)
        buttonStackView.addArrangedSubviews(minutes30Button, oneHourButton, twoHourButton, twoHoueOverButton)
    }

    func setLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(400.adjusted)
        }
        question5Title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33.6.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(question5Title.snp.bottom).offset(52.adjusted)
            $0.leading.equalToSuperview()
        }
    }
}
