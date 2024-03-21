//
//  OnboardingIntro2View.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingIntro2View: BaseView {

    // MARK: - UI Component

    lazy var onboardingProgressView = UIProgressView()

    let bgView = UIView()
    let ageTitle = UILabel()
    let ageSubtitle = UILabel()

    let ageLabel = UILabel()
    let ageTextField = UITextField()
    let ageInputLabel = UILabel()

    let parentOrChildLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        ageInputLabel.isHidden = true
    }

    // MARK: - Override Functions

    override func setUI() {
        onboardingProgressView.do {
            $0.trackTintColor = .gray100  // progress 배경 색상
            $0.progressTintColor = .blue400  // progress 진행 색상
            $0.progress = 0.25
        }
        ageTitle.do {
            $0.text = TextLiterals.Onboarding.Q1.ageTitle
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 2
            $0.addLineHeight(lineHeight: 33.6)
        }
        ageSubtitle.do {
            $0.text = TextLiterals.Onboarding.Q1.ageSubtitle
            $0.font = .body6
            $0.textColor = .gray600
            $0.textAlignment = .left
        }
        ageLabel.do {
            $0.text = TextLiterals.Onboarding.Q1.age
            $0.font = .body6
            $0.textColor = .gray500
            $0.textAlignment = .left
        }
        ageTextField.do {
            $0.placeholder = TextLiterals.Onboarding.Q1.textArea
            $0.textColor = .gray900
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.gray300.cgColor
            $0.layer.borderWidth = 1
            $0.backgroundColor = .gray50
            $0.keyboardType = .numberPad
            $0.addLeftPadding()
        }
        ageInputLabel.do {
            $0.text = TextLiterals.Onboarding.Q1.ageInput
            $0.textColor = .red500
            $0.font = .caption2
            $0.textAlignment = .left
        }
        parentOrChildLabel.do {
            $0.text = TextLiterals.Onboarding.Q1.parentOrChild
            $0.font = .body6
            $0.textColor = .gray500
            $0.textAlignment = .left
        }
    }

    override func setHierachy() {
        self.addSubviews(onboardingProgressView, bgView)
        bgView.addSubviews(ageTitle, ageSubtitle, ageLabel, ageTextField, ageInputLabel, parentOrChildLabel)
    }

    override func setLayout() {
        onboardingProgressView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2.adjusted)
        }
        bgView.snp.makeConstraints {
            $0.top.equalTo(onboardingProgressView.snp.bottom).offset(44.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(238.adjusted)
        }
        ageTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        ageSubtitle.snp.makeConstraints {
            $0.top.equalTo(ageTitle.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
        }
        ageLabel.snp.makeConstraints {
            $0.top.equalTo(ageSubtitle.snp.bottom).offset(44.adjusted)
            $0.leading.equalToSuperview()
        }
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(ageLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
            $0.width.equalTo(328.adjusted)
            $0.height.equalTo(52.adjusted)
        }
        ageInputLabel.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(4.adjusted)
            $0.leading.equalToSuperview()
        }
        parentOrChildLabel.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(28.adjusted)
            $0.leading.equalToSuperview()
        }
    }
}
