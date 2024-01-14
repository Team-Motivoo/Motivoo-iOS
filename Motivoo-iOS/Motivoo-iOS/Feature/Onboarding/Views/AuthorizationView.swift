//
//  AuthorizationView.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/14/24.
//

import UIKit

import SnapKit
import Then

final class AuthorizationView: BaseView {

    // MARK: - UI Component

    private let introLabel = UILabel()
    var authorizatioTableView = UITableView()
    private let divider = UIView()
    private let cautionLabel = UILabel()
    private let infoIcon = UIImageView()
    let allowButton = MotivooButton(text: TextLiterals.Onboarding.Authorization.allow, buttonStyle: .gray900)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: - Override Functions

    override func setUI() {
        introLabel.do {
            $0.text = TextLiterals.Onboarding.Authorization.introlLabel
            $0.font = .body6
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.addLineHeight(lineHeight: 23.6.adjusted)
        }
        authorizatioTableView.do {
            $0.isUserInteractionEnabled = false
            $0.register(AuthorizationTableViewCell.self, forCellReuseIdentifier: AuthorizationTableViewCell.cellIdentifier)
        }
        divider.do {
            $0.backgroundColor = .gray200
        }
        infoIcon.do {
            $0.image = ImageLiterals.icon.info
        }
        cautionLabel.do {
            $0.text = TextLiterals.Onboarding.Authorization.caution
            $0.font = .caption2
            $0.textColor = .gray500
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.addLineHeight(lineHeight: 22.2.adjusted)
        }
    }

    override func setHierachy() {
        self.addSubviews(introLabel, authorizatioTableView, divider, infoIcon, cautionLabel, allowButton)
    }

    override func setLayout() {
        introLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(24.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        authorizatioTableView.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(36.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(234.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(authorizatioTableView.snp.bottom).offset(32.adjusted)
            $0.height.equalTo(1.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        infoIcon.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(24.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        cautionLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(24.adjusted)
            $0.leading.equalTo(infoIcon.snp.trailing).offset(8.adjusted)
        }
        allowButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-44.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}

