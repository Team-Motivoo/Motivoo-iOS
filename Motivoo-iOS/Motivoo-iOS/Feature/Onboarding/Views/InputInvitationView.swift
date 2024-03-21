//
//  InputInvitationView.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/15/24.
//

import UIKit

import SnapKit
import Then

final class InputInvitationView: BaseView {

    // MARK: - UI Component

    private let logoImageView = UIImageView()
    private let inputLabel = UILabel()
    let inputTextField = UITextField()
    let startMotivooButton = MotivooButton(text: TextLiterals.Onboarding.Q3.startMotivoo, buttonStyle: .gray900)
    let wrongLabel = UILabel()

    // MARK: - Override Functions

    override init(frame: CGRect) {
        super.init(frame: frame)

        wrongLabel.isHidden = true
    }

    override func setUI() {
        logoImageView.do {
            $0.image = ImageLiterals.icon.code
        }
        inputLabel.do {
            $0.text = TextLiterals.Onboarding.Invitation.input
            $0.font = .heading4
            $0.textColor = .gray900
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        inputTextField.do {
            $0.backgroundColor = .gray50
            $0.placeholder = TextLiterals.Onboarding.Invitation.inputPalceholder
            $0.layer.borderColor = UIColor.gray300.cgColor
            $0.layer.borderWidth = 1
            $0.textColor = .gray900
            $0.layer.cornerRadius = 8
            $0.addLeftPadding()
            $0.setPlaceholder(color: .gray400)
        }
        wrongLabel.do {
            $0.text = TextLiterals.Onboarding.Invitation.wrongInvitation
            $0.font = .caption2
            $0.textColor = .red500
            $0.textAlignment = .left
        }
    }

    override func setHierachy() {
        self.addSubviews(logoImageView, inputLabel, inputTextField, wrongLabel, startMotivooButton)
    }

    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(32.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(124.adjusted)
            $0.width.equalTo(234.adjusted)
        }
        inputLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(28.adjusted)
            $0.centerX.equalToSuperview()
        }
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(inputLabel.snp.bottom).offset(40.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(52.adjusted)
        }
        wrongLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(8.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
        }
        startMotivooButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(78.adjusted)
        }
    }
}
