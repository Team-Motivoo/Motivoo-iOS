//
//  InvitationView.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/12/24.
//

import UIKit

import SnapKit
import Then

final class InvitationView: BaseView {

    // MARK: - UI Component

    private let shareLabel = UILabel()

    private let grayBGView = UIView()
    private let invitationCodeLabel = UILabel()
    let codeLabel = UILabel()
    let copyButton = UIButton()
    let matchingCheckButton = MotivooButton(text: TextLiterals.Onboarding.Invitation.matchingCheck, buttonStyle: .gray900)

    // MARK: - Override Functions

    override func setUI() {
        shareLabel.do {
            $0.text = TextLiterals.Onboarding.Invitation.share
            $0.font = .body1
            $0.textColor = .gray900
            $0.textAlignment = .center
            $0.numberOfLines = 0
            //$0.addLineHeight(lineHeight: 26.6.adjusted)
        }
        grayBGView.do {
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 8
        }
        invitationCodeLabel.do {
            $0.text = TextLiterals.Onboarding.Invitation.invitationCode
            $0.font = .body5
            $0.textColor = .gray600
            $0.textAlignment = .center
        }
        codeLabel.do {
            $0.text = "81dc24gd0"
            $0.font = .heading3
            $0.textColor = .black
            $0.textAlignment = .center
        }
        copyButton.do {
            $0.setTitle(TextLiterals.Onboarding.Invitation.copy, for: .normal)
            $0.titleLabel?.font = .body5
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .blue400
            $0.layer.cornerRadius = 8
        }
    }

    override func setHierachy() {
        self.addSubviews(shareLabel, grayBGView, matchingCheckButton)
        grayBGView.addSubviews(invitationCodeLabel, codeLabel, copyButton)
    }

    override func setLayout() {
        shareLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(60.adjusted)
            $0.centerX.equalToSuperview()
        }
        grayBGView.snp.makeConstraints {
            $0.top.equalTo(shareLabel.snp.bottom).offset(32.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200.adjusted)
            $0.width.equalTo(335.adjusted)
        }
        invitationCodeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22.adjusted)
            $0.centerX.equalToSuperview()
        }
        codeLabel.snp.makeConstraints {
            $0.top.equalTo(invitationCodeLabel.snp.bottom).offset(8.adjusted)
            $0.centerX.equalToSuperview()
        }
        copyButton.snp.makeConstraints {
            $0.top.equalTo(codeLabel.snp.bottom).offset(32.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52.adjusted)
            $0.width.equalTo(220.adjusted)
        }
        matchingCheckButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(78.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
