//
//  OnboardingView1Cell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingView1Cell: UICollectionViewCell {

    //MARK: - Properties

    lazy var ageInfo: Int = 0
    var buttonClickCount: Int = 0
    var moveBool: Bool = false {
        willSet (moveBool) {
            if moveBool { //true
                UIView.animate(withDuration: 0.4,
                               delay: 0,
                               options: [.curveEaseInOut]) { [self] in
                    var frame = buttonStackView.frame
                    frame.origin.y = 286.adjusted
                    buttonStackView.frame = frame
                    onboardingIntro2View.parentOrChildLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            } else {
                UIView.animate(withDuration: 0.4,
                               delay: 0,
                               options: [.curveEaseInOut]) { [self] in
                    var frame = buttonStackView.frame
                    frame.origin.y = 308.adjusted
                    buttonStackView.frame = frame
                    onboardingIntro2View.parentOrChildLabel.transform = CGAffineTransform(translationX: 0, y: 22.adjusted)
                }
            }
        }
    }

    // MARK: - UI Component

    private let bgView = UIView()
    let introTitle = UILabel()
    let introSubtitle = UILabel()
    var buttonStackView = UIStackView()
    let parentButton = MotivooButton(text: TextLiterals.Onboarding.Q1.patent, buttonStyle: .borderGray100Half)
    let childButton = MotivooButton(text: TextLiterals.Onboarding.Q1.child, buttonStyle: .borderGray100Half)
    let nextButton = MotivooButton(text: TextLiterals.Onboarding.next, buttonStyle: .gray900)

    private let onboardingIntro2View = OnboardingIntro2View()

    var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled {
                nextButton.setTitleColor(.white, for: .normal)
                nextButton.backgroundColor = .gray900
            } else {
                nextButton.setTitleColor(.gray400, for: .normal)
                nextButton.backgroundColor = .gray100
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setHierachy()
        setLayout()
        setButtonEvent()
        parentButton.isSelected = true
        childButton.isSelected = true
        onboardingIntro2View.isHidden = true
        buttonEnabledCheck()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc
    private func parentButtonDidTap() {
        if (parentButton.isSelected) {
            if (!childButton.isSelected) {
                childButton.isSelected = true
            }
            parentButton.isSelected = false
        } else {
            parentButton.isSelected = true
        }
        if buttonClickCount == 0 {
            changeViewAnimation()
            buttonClickCount += 1
        }
    }

    @objc
    private func childButtonDidTap() {
        if (childButton.isSelected) {
            if (!parentButton.isSelected) {
                parentButton.isSelected = true
            }
            childButton.isSelected = false
        } else {
            childButton.isSelected = true
        }
        if buttonClickCount == 0 {
            changeViewAnimation()
            buttonClickCount += 1
        }
    }

    // MARK: - Override Functions

    func setUI() {
        introTitle.do {
            $0.text = TextLiterals.Onboarding.Q1.parentTitle
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.addLineHeight(lineHeight: 33.6.adjusted)
        }
        introSubtitle.do {
            $0.text = TextLiterals.Onboarding.Q1.parentSubtitle
            $0.font = .body6
            $0.textColor = .gray600
            $0.textAlignment = .left
        }
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 11
            $0.alignment = .fill
        }
    }

    func setHierachy() {
        contentView.addSubviews(bgView, nextButton, onboardingIntro2View)
        bgView.addSubviews(introTitle, introSubtitle, buttonStackView)
        buttonStackView.addArrangedSubviews(parentButton, childButton)
    }

    func setLayout() {
        bgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(500.adjusted)
        }
        introTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33.6.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        introSubtitle.snp.makeConstraints {
            $0.top.equalTo(introTitle.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(introSubtitle.snp.bottom).offset(44.adjusted)
        }
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(78.adjusted)
        }
        onboardingIntro2View.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(285.adjusted)
        }
    }

    func setButtonEvent() {
        parentButton.addTarget(self, action: #selector(parentButtonDidTap), for: .touchUpInside)
        childButton.addTarget(self, action: #selector(childButtonDidTap), for: .touchUpInside)
        onboardingIntro2View.ageTextField.addTarget(self, action:  #selector(textFieldDidChanacge), for: .editingChanged)
    }

    @objc
    func changeViewAnimation() {
        introTitle.isHidden = true
        introSubtitle.isHidden = true
        onboardingIntro2View.isHidden = false
        onboardingIntro2View.alpha = 0.3

        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       options: [.curveEaseInOut]) { [self] in
            onboardingIntro2View.alpha = 1
            onboardingIntro2View.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseInOut]) { [self] in
            var frame = buttonStackView.frame
            frame.origin.y = 286.adjusted
            buttonStackView.frame = frame
        }
        isButtonEnabled = false
        nextButton.isEnabled = isButtonEnabled
    }

    @objc
    func textFieldDidChanacge(_ sender: Any?) {
        if let text = onboardingIntro2View.ageTextField.text {
            let age: Int = Int(text) ?? 0
            self.ageInfo = age
            // age에는 변환된 Int 값 또는 0이 저장됩니다.
            if (age >= 14 && age <= 99) {
                moveBool = true
                onboardingIntro2View.ageTextField.layer.borderColor = UIColor.gray500.cgColor
                onboardingIntro2View.ageInputLabel.isHidden = true
                isButtonEnabled = true
            } else {
                moveBool = false
                onboardingIntro2View.ageTextField.layer.borderColor = UIColor.red500.cgColor
                onboardingIntro2View.ageInputLabel.isHidden = false
                isButtonEnabled = false
            }
            nextButton.isEnabled = isButtonEnabled
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }

    func buttonEnabledCheck() {
        if (!parentButton.isSelected || !childButton.isSelected) {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
        nextButton.isEnabled = isButtonEnabled
    }
}
