//
//  OnboardingView4Cell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/12/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingView4Cell: UICollectionViewCell {
    private let bgView = UIView()
    let question4Title = UILabel()
    var buttonStackView = UIStackView()
    let day1Button = MotivooButton(text: TextLiterals.Onboarding.Q3.one, buttonStyle: .borderGray100)
    let day2Button = MotivooButton(text: TextLiterals.Onboarding.Q3.two, buttonStyle: .borderGray100)
    let day3Button = MotivooButton(text: TextLiterals.Onboarding.Q3.three, buttonStyle: .borderGray100)
    let day5Button = MotivooButton(text: TextLiterals.Onboarding.Q3.five, buttonStyle: .borderGray100)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setHierachy()
        setLayout()
        day1Button.isSelected = true
        day2Button.isSelected = true
        day3Button.isSelected = true
        day5Button.isSelected = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Functions

    func setUI() {
        question4Title.do {
            $0.text = TextLiterals.Onboarding.Q3.howManyExercise
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
            $0.distribution = .fillEqually
        }
        day1Button.accessibilityIdentifier = "1day"
        day2Button.accessibilityIdentifier = "2day"
        day3Button.accessibilityIdentifier = "3day"
        day5Button.accessibilityIdentifier = "5day"
    }

    func setHierachy() {
        contentView.addSubviews(bgView)
        bgView.addSubviews(question4Title, buttonStackView)
        buttonStackView.addArrangedSubviews(day1Button, day2Button, day3Button, day5Button)
    }

    func setLayout() {
        bgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(500.adjusted)
        }
        question4Title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33.6.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(question4Title.snp.bottom).offset(52.adjusted)
            $0.leading.equalToSuperview()
        }
    }
}
