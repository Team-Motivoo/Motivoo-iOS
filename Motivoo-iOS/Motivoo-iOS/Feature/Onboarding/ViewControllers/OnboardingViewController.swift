//
//  OnboardingViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingViewController: BaseViewController {

    private let onboardingIntro1View = OnboardingIntro1View()
    private let onboardingIntro2View = OnboardingIntro2View()

    var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled {
                onboardingIntro1View.nextButton.setTitleColor(.white, for: .normal)
                onboardingIntro1View.nextButton.backgroundColor = .gray900
            } else {
                onboardingIntro1View.nextButton.setTitleColor(.gray400, for: .normal)
                onboardingIntro1View.nextButton.backgroundColor = .gray100
            }
        }
    }

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingIntro1View.nextButton.isEnabled = false
        onboardingIntro1View.parentButton.isSelected = true
        onboardingIntro1View.childButton.isSelected = true
        onboardingIntro2View.alpha = 0
    }

    // MARK: - Override Functions

    override func setButtonEvent() {
        onboardingIntro1View.parentButton.addTarget(self, action: #selector(parentButtonButtonDidTap), for: .touchUpInside)
        onboardingIntro1View.childButton.addTarget(self, action: #selector(childButtonButtonDidTap), for: .touchUpInside)
        onboardingIntro1View.nextButton.addTarget(self, action: #selector(changeViewAnimation), for: .touchUpInside)
        onboardingIntro2View.ageTextField.addTarget(self, action:  #selector(textFieldDidChanacge), for: .editingChanged)
    }

    override func setHierachy() {
        self.view.addSubviews(onboardingIntro1View, onboardingIntro2View)
    }

    override func setLayout() {
        onboardingIntro1View.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        onboardingIntro2View.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(330)
        }
    }

    // MARK: - Actions

    @objc
    private func parentButtonButtonDidTap() {
        if (onboardingIntro1View.parentButton.isSelected) {
            if (!onboardingIntro1View.childButton.isSelected) {
                onboardingIntro1View.childButton.isSelected = true
            }
            onboardingIntro1View.parentButton.isSelected = false
        } else {
            onboardingIntro1View.parentButton.isSelected = true
        }
        buttonEnabledCheck()
    }

    @objc
    private func childButtonButtonDidTap() {
        if (onboardingIntro1View.childButton.isSelected) {
            if (!onboardingIntro1View.parentButton.isSelected) {
                onboardingIntro1View.parentButton.isSelected = true
            }
            onboardingIntro1View.childButton.isSelected = false
        } else {
            onboardingIntro1View.childButton.isSelected = true
        }
        buttonEnabledCheck()
    }

    @objc
    func textFieldDidChanacge(_ sender: Any?) {
        if let text = onboardingIntro2View.ageTextField.text {
            let age: Int = Int(text) ?? 0
            if (age >= 14 && age <= 99) {
                onboardingIntro2View.ageTextField.layer.borderColor = UIColor.blue500.cgColor
                onboardingIntro2View.ageTextField.textColor = .blue500
                onboardingIntro2View.ageInputLabel.isHidden = true
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               options: [.curveEaseInOut]) { [self] in
                    onboardingIntro1View.buttonStackView.transform = CGAffineTransform(translationX: 0, y: 102)
                    onboardingIntro2View.parentOrChildLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                }
                isButtonEnabled = true
            } else {
                onboardingIntro2View.ageTextField.layer.borderColor = UIColor.pink.cgColor
                onboardingIntro2View.ageTextField.textColor = .gray900
                onboardingIntro2View.ageInputLabel.isHidden = false
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               options: [.curveEaseInOut]) { [self] in
                    onboardingIntro1View.buttonStackView.transform = CGAffineTransform(translationX: 0, y: 124)
                    onboardingIntro2View.parentOrChildLabel.transform = CGAffineTransform(translationX: 0, y: 22)
                }
                isButtonEnabled = false
            }
            onboardingIntro1View.nextButton.isEnabled = isButtonEnabled
            // age에는 변환된 Int 값 또는 nil이 저장됩니다.
        }
    }

    // MARK: - Actions

    @objc 
    func changeViewAnimation() {
        onboardingIntro1View.introTitle.isHidden = true
        onboardingIntro1View.introSubtitle.isHidden = true

        UIView.animate(withDuration: 0.4,
                       delay: 0.2,
                       options: [.curveEaseInOut]) { [self] in
            onboardingIntro2View.alpha = 1
            onboardingIntro2View.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.curveEaseInOut]) { [self] in
            onboardingIntro1View.buttonStackView.transform = CGAffineTransform(translationX: 0, y: 102)
            onboardingIntro1View.buttonStackView.alpha = 1
        }
        isButtonEnabled = false
        onboardingIntro1View.nextButton.isEnabled = isButtonEnabled
    }

    func buttonEnabledCheck() {
        if (!onboardingIntro1View.parentButton.isSelected || !onboardingIntro1View.childButton.isSelected) {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
        onboardingIntro1View.nextButton.isEnabled = isButtonEnabled
    }
}
