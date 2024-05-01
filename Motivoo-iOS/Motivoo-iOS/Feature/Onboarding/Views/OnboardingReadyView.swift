//
//  OnboardingReadyViewCell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 4/30/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingReadyView: BaseView {

    // MARK: - UI Component

    private let bgView = UIView()
    private let readyLabel = UILabel()
    private let imageViwe = UIImageView()
    private let introLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Functions

    override func setUI() {
        bgView.do {
            $0.backgroundColor = .white
        }
        readyLabel.do {
            $0.text = TextLiterals.Onboarding.Ready.readyTitle
            $0.font = .heading3
            $0.textColor = .gray900
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        imageViwe.do {
            $0.image = ImageLiterals.img.readyOnboarding
        }
        introLabel.do {
            $0.text = TextLiterals.Onboarding.Ready.readyIntro
            $0.font = .body3
            $0.textColor = .gray800
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
    }

    override func setHierachy() {
        self.addSubviews(bgView)
        bgView.addSubviews(readyLabel, imageViwe, introLabel)
    }

    override func setLayout() {
        bgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        readyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(153.adjusted)
            $0.centerX.equalToSuperview()
        }
        imageViwe.snp.makeConstraints {
            $0.top.equalTo(readyLabel.snp.bottom).offset(40.adjusted)
            $0.size.equalTo(240.adjusted)
            $0.centerX.equalToSuperview()
        }
        introLabel.snp.makeConstraints {
            $0.top.equalTo(imageViwe.snp.bottom).offset(48.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
