//
//  TermsOfUseTableViewCell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/14/24.
//

import UIKit

import SnapKit
import Then

final class TermsOfUseTableViewCell: UITableViewCell {

    let checkButton = UIButton()
    lazy var term = UILabel()
    private let essential = UILabel()
    let seeButton = UIButton()

    func setCell(term: String) {
        self.term.text = term
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        setUI()
        setHierachy()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }

    func setUI() {
        checkButton.do {
            $0.setImage(ImageLiterals.icon.checkbox_default, for: .normal)
            $0.setImage(ImageLiterals.icon.checkbox_active, for: .selected)
        }
        term.do {
            $0.text = TextLiterals.Onboarding.Terms.termsOfUse
            $0.font = .body6
            $0.textColor = .gray900
            $0.textAlignment = .left
        }
        essential.do {
            $0.text = TextLiterals.Onboarding.Authorization.essential
            $0.font = .body6
            $0.textColor = .red500
            $0.textAlignment = .left
        }
        let underlineText = NSMutableAttributedString(string: TextLiterals.Onboarding.Terms.see, attributes: [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,  NSAttributedString.Key.font: UIFont.caption2,
            NSAttributedString.Key.foregroundColor: UIColor.gray500
        ])
        seeButton.do {
            $0.setAttributedTitle(underlineText, for: .normal)
        }
    }

    func setHierachy() {
        contentView.addSubviews(checkButton, term, essential, seeButton)
    }

    func setLayout() {
        checkButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(24.adjusted)
        }
        term.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(checkButton.snp.trailing).offset(8.adjusted)
            $0.height.equalTo(24.adjusted)
        }
        essential.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(term.snp.trailing).offset(4.adjusted)
            $0.height.equalTo(24.adjusted)
        }
        seeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
    }
}

