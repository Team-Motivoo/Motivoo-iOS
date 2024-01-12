//
//  OnboardingView2Cell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/12/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingView2Cell: UICollectionViewCell {

    // MARK: - UI Component

    private let bgView = UIView()
    let question2Title = UILabel()
    var buttonStackView = UIStackView()
    let yesButton = MotivooButton(text: TextLiterals.Onboarding.yes, buttonStyle: .borderGray100)
    let noButton = MotivooButton(text: TextLiterals.Onboarding.no, buttonStyle: .borderGray100)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setHierachy()
        setLayout()
        yesButton.isSelected = true
        noButton.isSelected = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Functions

    func setUI() {
        question2Title.do {
            $0.text = TextLiterals.Onboarding.Q2.usuallyExercise
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .left
        }
        buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = 16
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
        yesButton.accessibilityIdentifier = "yes"
        noButton.accessibilityIdentifier = "no"
    }

    func setHierachy() {
        contentView.addSubviews(bgView)
        bgView.addSubviews(question2Title, buttonStackView)
        buttonStackView.addArrangedSubviews(yesButton, noButton)
    }

    func setLayout() {
        bgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(500.adjusted)
        }
        question2Title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33.6.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(question2Title.snp.bottom).offset(64.adjusted)
            $0.height.equalTo(120.adjusted)
            $0.leading.equalToSuperview()
        }
    }
}
