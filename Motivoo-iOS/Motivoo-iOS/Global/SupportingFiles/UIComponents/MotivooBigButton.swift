//
//  MotivooBigButton.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class MotivooBigButton: UIButton {

    // MARK: - Properties
    
    private let buttonTitle = UILabel()
    private let buttonSubtitle = UILabel()

    enum ButtonStyle {
        case borderGray100
    }

    // MARK: - Override Actions

    override var isSelected: Bool {
        didSet (isSelected) {
            backgroundColor = isSelected ? .white: .gray100
            self.layer.borderColor = isSelected ? UIColor.gray900.cgColor : UIColor.gray200.cgColor
        }
    }

    // MARK: - Initializer

    init(title: String, subtitle: String, buttonStyle: ButtonStyle) {
        super.init(frame: CGRect())

        switch buttonStyle {
        case .borderGray100:
            self.setTitleColor(.gray800, for: .normal)
            self.backgroundColor = .gray100
            self.layer.borderColor = UIColor.gray200.cgColor
            self.layer.borderWidth = 1.adjusted
        }

        self.addSubviews(buttonTitle, buttonSubtitle)
        setUI(title: title, subtitle: subtitle)
        setLayout()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI(title: String, subtitle: String) {
        self.do {
            $0.layer.cornerRadius = 8
        }
        buttonTitle.do {
            $0.text = title
            $0.font = .body3
            $0.textColor = .gray800
        }
        buttonSubtitle.do {
            $0.text = subtitle
            $0.font = .body6
            $0.textColor = .gray700
        }
    }

    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(80.adjusted)
            $0.width.equalTo(335.adjusted)
        }
        buttonTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.adjusted)
            $0.centerX.equalToSuperview()
        }
        buttonSubtitle.snp.makeConstraints {
            $0.top.equalTo(buttonTitle.snp.bottom).offset(10.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}


