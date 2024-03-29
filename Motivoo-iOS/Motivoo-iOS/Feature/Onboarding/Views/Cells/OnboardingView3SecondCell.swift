//
//  OnboardingView3SecondCell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/19/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingView3SecondCell: UICollectionViewCell {
    private let bgView = UIView()
    let question3Title = UILabel()
    let question3Subtitle = UILabel()
    var buttonStackView = UIStackView()
    let highButton = MotivooBigButton(title: TextLiterals.Onboarding.Q4.highTitle,
                                      subtitle: TextLiterals.Onboarding.Q4.highSubtitle,
                                      buttonStyle: .borderGray100)
    let mediumButton = MotivooBigButton(title: TextLiterals.Onboarding.Q4.middleTitle,
                                        subtitle: TextLiterals.Onboarding.Q4.middleSubtitle,
                                        buttonStyle: .borderGray100)
    let lowButton = MotivooBigButton(title: TextLiterals.Onboarding.Q4.lowTitle,
                                     subtitle: TextLiterals.Onboarding.Q4.lowSubtitle,
                                     buttonStyle: .borderGray100)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setHierachy()
        setLayout()
        highButton.isSelected = true
        mediumButton.isSelected = true
        lowButton.isSelected = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Functions

    func setUI() {
        question3Title.do {
            $0.text = TextLiterals.Onboarding.Q4.exerciseTitle
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.addLineHeight(lineHeight: 33.6.adjusted)
        }
        question3Subtitle.do {
            $0.text = TextLiterals.Onboarding.Q4.exercisePowerSubtitle
            $0.font = .body6
            $0.textColor = .gray600
            $0.textAlignment = .left
        }
        buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = 17
            $0.alignment = .center
        }
        highButton.accessibilityIdentifier = "high2"
        mediumButton.accessibilityIdentifier = "medium2"
        lowButton.accessibilityIdentifier = "low2"
    }

    func setHierachy() {
        contentView.addSubviews(bgView)
        bgView.addSubviews(question3Title, question3Subtitle, buttonStackView)
        buttonStackView.addArrangedSubviews(highButton, mediumButton, lowButton)
    }

    func setLayout() {
        bgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(500.adjusted)
        }
        question3Title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33.6.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        question3Subtitle.snp.makeConstraints {
            $0.top.equalTo(question3Title.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(question3Subtitle.snp.bottom).offset(52.adjusted)
            $0.leading.equalToSuperview()
        }
    }
}
