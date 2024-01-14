//
//  AuthorizationTableViewCell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/14/24.
//

import UIKit

import SnapKit
import Then

class AuthorizationTableViewCell: UITableViewCell {

    lazy var iconImageView = UIImageView()
    lazy var title = UILabel()
    private let essential = UILabel()
    lazy var subtitle = UILabel()

    func setCell(icon: UIImage, title: String, subtitle: String) {
        self.iconImageView.image = icon
        self.title.text = title
        self.subtitle.text = subtitle
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
        setHierachy()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }

    func setUI() {
        iconImageView.do {
            $0.image = ImageLiterals.img.fitnessCircle
        }
        title.do {
            $0.text = TextLiterals.Onboarding.Authorization.action
            $0.font = .heading7
            $0.textColor = .gray900
            $0.textAlignment = .left
        }
        essential.do {
            $0.text = TextLiterals.Onboarding.Authorization.essential
            $0.font = .body6
            $0.textColor = .pink
            $0.textAlignment = .left
        }
        subtitle.do {
            $0.text = TextLiterals.Onboarding.Authorization.actionLabel
            $0.font = .caption2
            $0.textColor = .gray700
            $0.textAlignment = .left
        }
    }

    func setHierachy() {
        contentView.addSubviews(iconImageView, title, essential, subtitle)
    }

    func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(44.adjusted)
        }
        title.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10.adjusted)
        }
        essential.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(title.snp.trailing).offset(2.adjusted)
        }
        subtitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(4.adjusted)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10.adjusted)
        }
    }
}
