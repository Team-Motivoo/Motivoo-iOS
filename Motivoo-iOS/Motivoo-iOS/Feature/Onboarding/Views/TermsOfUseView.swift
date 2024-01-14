//
//  TermsOfUseView.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/14/24.
//

import UIKit

import SnapKit
import Then

final class TermsOfUseView: BaseView {

    // MARK: - UI Component

    let checkButton = UIButton()
    let allTermsAllow = UILabel()
    var termsTableView = UITableView()
    let nextButton = MotivooButton(text: TextLiterals.Onboarding.next, buttonStyle: .gray900)

    override init(frame: CGRect) {
        super.init(frame: frame)

        checkButton.accessibilityIdentifier = "allCheckButton"
    }

    // MARK: - Override Functions

    override func setUI() {
        checkButton.do {
            $0.setImage(ImageLiterals.icon.checkbox_default, for: .normal)
            $0.setImage(ImageLiterals.icon.checkbox_active, for: .selected)
        }
        allTermsAllow.do {
            $0.text = TextLiterals.Onboarding.Terms.allTerms
            $0.font = .heading7
            $0.textColor = .gray900
            $0.textAlignment = .left
        }
        termsTableView.do {
            $0.register(TermsOfUseTableViewCell.self, forCellReuseIdentifier: "TermsOfUseTableViewCell")
        }
    }

    override func setHierachy() {
        self.addSubviews(checkButton, allTermsAllow, termsTableView, nextButton)
    }

    override func setLayout() {
        checkButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(36.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.size.equalTo(24.adjusted)
        }
        allTermsAllow.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(36.adjusted)
            $0.height.equalTo(24.adjusted)
            $0.leading.equalTo(checkButton.snp.trailing).offset(8.adjusted)
        }
        termsTableView.snp.makeConstraints {
            $0.top.equalTo(checkButton.snp.bottom).offset(40.adjusted)
            $0.height.equalTo(132.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.trailing.equalToSuperview().inset(22.adjusted)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-44.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
