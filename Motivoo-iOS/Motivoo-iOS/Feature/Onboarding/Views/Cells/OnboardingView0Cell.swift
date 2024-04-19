//
//  OnboardingView0Cell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 4/14/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingView0Cell: UICollectionViewCell {

    // MARK: - UI Component

    private let bgView = UIView()
    private let question0Title = UILabel()
    private let question0Subtitle = UILabel()
    var nameTextField = UITextField()
    private let nameRangeLable = UILabel()
    let nextButton = MotivooButton(text: TextLiterals.Onboarding.next, buttonStyle: .gray900)

    var isButtonEnabled: Bool = true {
        didSet {
            if isButtonEnabled {
                self.nextButton.setTitleColor(.white, for: .normal)
                self.nextButton.backgroundColor = .gray900
            } else {
                self.nextButton.setTitleColor(.gray400, for: .normal)
                self.nextButton.backgroundColor = .gray100
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setHierachy()
        setLayout()
        setButtonEvent()
        nameRangeLable.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Functions

    func setUI() {
        question0Title.do {
            $0.text = TextLiterals.Onboarding.Q0.nameQuestion
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .left
        }
        question0Subtitle.do {
            $0.text = TextLiterals.Onboarding.Q0.nickname
            $0.font = .body6
            $0.textColor = .gray500
            $0.textAlignment = .left
        }
        nameTextField.do {
            $0.placeholder = TextLiterals.Onboarding.Q1.textArea
            $0.textColor = .gray900
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.gray300.cgColor
            $0.layer.borderWidth = 1
            $0.backgroundColor = .gray50
            $0.addLeftPadding()
        }
        nameRangeLable.do {
            $0.text = TextLiterals.Onboarding.Q0.nicknameRange
            $0.textColor = .red500
            $0.font = .caption2
            $0.textAlignment = .left
        }
    }

    func setHierachy() {
        contentView.addSubviews(bgView, nextButton)
        bgView.addSubviews(question0Title, question0Subtitle, nameTextField, nameRangeLable)
    }

    func setLayout() {
        bgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(500.adjusted)
        }
        question0Title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33.6.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        question0Subtitle.snp.makeConstraints {
            $0.top.equalTo(question0Title.snp.bottom).offset(44.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(question0Subtitle.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
            $0.width.equalTo(328.adjusted)
            $0.height.equalTo(52.adjusted)
        }
        nameRangeLable.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(4.adjusted)
            $0.leading.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(78.adjusted)
        }
    }

    func setButtonEvent() {
        self.nameTextField.addTarget(self, action:  #selector(textFieldDidChanacge), for: .editingChanged)

        self.nextButton.setTitleColor(.gray400, for: .normal)
        self.nextButton.backgroundColor = .gray100
    }

    @objc
    func textFieldDidChanacge(_ sender: Any?) {
        if let text = nameTextField.text {
            if text.count >= 8 {
                let index = text.index(text.startIndex, offsetBy: 7)
                let fixedText = String(text[text.startIndex...index])
                nameTextField.text = fixedText + " "

                let when = DispatchTime.now() + 0.01
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.nameTextField.text = fixedText
                }
                nameRangeLable.isHidden = false
                nameTextField.layer.borderColor = UIColor.red500.cgColor
            } else {
                if text.count < 1 {
                    isButtonEnabled = false
                } else {
                    isButtonEnabled = true
                }
                nameRangeLable.isHidden = true
                nameTextField.layer.borderColor = UIColor.gray500.cgColor
            }
        }
        nextButton.isEnabled = isButtonEnabled
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
}

