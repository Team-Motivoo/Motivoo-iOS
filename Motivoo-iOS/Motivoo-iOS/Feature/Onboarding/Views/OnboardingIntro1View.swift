//
//  OnboardingIntro1View.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingIntro1View: BaseView {

    // MARK: - UI Component

    lazy var onboardingProgressView = UIProgressView()

    let bgView = UIView()
    let introTitle = UILabel()
    let introSubtitle = UILabel()
    var buttonStackView = UIStackView()
    let parentButton = TitleBoxButton()
    let childButton = TitleBoxButton()
    let nextButton = UIButton()

    // MARK: - Override Functions

    override func setUI() {
        onboardingProgressView.do {
            $0.trackTintColor = .gray100  // progress 배경 색상
            $0.progressTintColor = .blue400  // progress 진행 색상
            $0.progress = 0.25
        }
        introTitle.do {
            $0.text = TextLiterals.Onboarding.Q1.ParentTitle
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 2
            $0.addLineHeight(lineHeight: 33.6)
        }
        introSubtitle.do {
            $0.text = TextLiterals.Onboarding.Q1.ParentSubtitle
            $0.font = .body6
            $0.textColor = .gray600
            $0.textAlignment = .left
        }
        parentButton.do {
            $0.setTitle(TextLiterals.Onboarding.Q1.Parent, for: .normal)
            $0.frame.size.width = 162
        }
        childButton.do {
            $0.setTitle(TextLiterals.Onboarding.Q1.Child, for: .normal)
            $0.frame.size.width = 162
        }
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 11
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        nextButton.do {
            $0.setTitle(TextLiterals.Onboarding.Next, for: .normal)
            $0.setTitleColor(.gray400, for: .normal)
            $0.titleLabel?.font = .body5
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 8
        }
    }

    override func setHierachy() {
        self.addSubviews(onboardingProgressView, bgView, nextButton)
        bgView.addSubviews(introTitle, introSubtitle, buttonStackView)
        buttonStackView.addArrangedSubviews(parentButton, childButton)
    }

    override func setLayout() {
        onboardingProgressView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(62.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2.adjusted)
        }
        bgView.snp.makeConstraints {
            $0.top.equalTo(onboardingProgressView.snp.bottom).offset(44.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(196.adjusted)
        }
        introTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        introSubtitle.snp.makeConstraints {
            $0.top.equalTo(introTitle.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(introSubtitle.snp.bottom).offset(44.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52.adjusted)
        }
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(52.adjusted)
            $0.bottom.equalToSuperview().inset(78.adjusted)
        }
    }
    
}
