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
    let question0Title = UILabel()
    let question0Subtitle = UILabel()
    var nameTextField = UITextField()
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
    }

    func setHierachy() {
        contentView.addSubviews(bgView, nextButton)
        bgView.addSubviews(question0Title, question0Subtitle, nameTextField)
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
        if nameTextField.text != nil {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
        nextButton.isEnabled = isButtonEnabled
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
}

