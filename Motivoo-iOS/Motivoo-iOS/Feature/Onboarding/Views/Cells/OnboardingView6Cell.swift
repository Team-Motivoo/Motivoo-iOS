//
//  OnboardingView6Cell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/12/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingView6Cell: UICollectionViewCell {
    private let bgView = UIView()
    let question6Title = UILabel()
    let question6Subtitle = UILabel()
    var buttonStackView = UIStackView()
    var stackView1 = UIStackView()
    var stackView2 = UIStackView()
    var stackView3 = UIStackView()
    let neckButton = MotivooButton(text: TextLiterals.Onboarding.Q3.neck, buttonStyle: .borderGray100Half)
    let shoulderButton = MotivooButton(text: TextLiterals.Onboarding.Q3.shoulder, buttonStyle: .borderGray100Half)
    let waistButton = MotivooButton(text: TextLiterals.Onboarding.Q3.waist, buttonStyle: .borderGray100Half)
    let kneeButton = MotivooButton(text: TextLiterals.Onboarding.Q3.knee, buttonStyle: .borderGray100Half)
    let wristButton = MotivooButton(text: TextLiterals.Onboarding.Q3.wrist, buttonStyle: .borderGray100Half)
    let ankleButton = MotivooButton(text: TextLiterals.Onboarding.Q3.ankle, buttonStyle: .borderGray100Half)
    let startMotivooButton = MotivooButton(text: TextLiterals.Onboarding.Q3.startMotivoo, buttonStyle: .gray900)

    var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled {
                startMotivooButton.setTitleColor(.white, for: .normal)
                startMotivooButton.backgroundColor = .gray900
            } else {
                startMotivooButton.setTitleColor(.gray400, for: .normal)
                startMotivooButton.backgroundColor = .gray100
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierachy()
        setLayout()
        neckButton.isSelected = true
        shoulderButton.isSelected = true
        waistButton.isSelected = true
        kneeButton.isSelected = true
        wristButton.isSelected = true
        ankleButton.isSelected = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Functions

    func setUI() {
        question6Title.do {
            $0.text = TextLiterals.Onboarding.Q3.usuallyWorryExercise
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.addLineHeight(lineHeight: 33.6.adjusted)
        }
        question6Subtitle.do {
            $0.text = TextLiterals.Onboarding.Q3.choiceMaxThree
            $0.font = .body6
            $0.textColor = .gray600
            $0.textAlignment = .left
        }
        buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = 16
            $0.alignment = .center
        }
        stackView1.do {
            $0.axis = .horizontal
            $0.spacing = 12
            $0.alignment = .fill
        }
        stackView2.do {
            $0.axis = .horizontal
            $0.spacing = 12
            $0.alignment = .fill
        }
        stackView3.do {
            $0.axis = .horizontal
            $0.spacing = 12
            $0.alignment = .fill
        }
        neckButton.accessibilityIdentifier = "목"
        shoulderButton.accessibilityIdentifier = "어깨"
        waistButton.accessibilityIdentifier = "허리"
        kneeButton.accessibilityIdentifier = "무릎"
        wristButton.accessibilityIdentifier = "손목"
        ankleButton.accessibilityIdentifier = "발목"
    }

    func setHierachy() {
        contentView.addSubviews(bgView, startMotivooButton)
        bgView.addSubviews(question6Title, question6Subtitle, buttonStackView)
        buttonStackView.addArrangedSubviews(stackView1, stackView2, stackView3)
        stackView1.addArrangedSubviews(neckButton, shoulderButton)
        stackView2.addArrangedSubviews(waistButton, kneeButton)
        stackView3.addArrangedSubviews(wristButton, ankleButton)

    }

    func setLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(500.adjusted)
        }
        question6Title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33.6.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        question6Subtitle.snp.makeConstraints {
            $0.top.equalTo(question6Title.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(question6Subtitle.snp.bottom).offset(52.adjusted)
            $0.leading.equalToSuperview()
        }
        startMotivooButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(78.adjusted)
        }
    }
}
