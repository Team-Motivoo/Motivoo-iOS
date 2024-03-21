//
//  MotivooButton.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class MotivooButton: UIButton {

    // MARK: - Properties

    enum ButtonStyle {
        case gray900
        case gray100
        case borderGray100
        case borderGray100Half
    }

    // MARK: - Override Actions

    override var isSelected: Bool {
        didSet (isSelected) {
            backgroundColor = isSelected ? .white: .gray100
            self.layer.borderColor = isSelected ? UIColor.gray900.cgColor : UIColor.gray200.cgColor
        }
    }

    // MARK: - Initializer

    init(text: String, buttonStyle: ButtonStyle) {
        super.init(frame: CGRect())

        switch buttonStyle {
        case .gray900:
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .gray900

        case .gray100:
            self.setTitleColor(.gray900, for: .normal)
            self.backgroundColor = .gray100

        case .borderGray100:
            self.setTitleColor(.gray800, for: .normal)
            self.backgroundColor = .gray100
            self.layer.borderColor = UIColor.gray200.cgColor
            self.layer.borderWidth = 1.adjusted

        case .borderGray100Half:
            self.setTitleColor(.gray800, for: .normal)
            self.backgroundColor = .gray100
            self.layer.borderColor = UIColor.gray200.cgColor
            self.layer.borderWidth = 1.adjusted
        }

        self.do {
            $0.setTitle(text, for: .normal)
            $0.titleLabel?.font = .body5
        }

        setUI()

        if (buttonStyle == .borderGray100Half) {
            self.snp.makeConstraints {
                $0.width.equalTo(162.adjusted)
            }
        }
        else {
            self.snp.makeConstraints {
                $0.width.equalTo(335.adjusted)
            }
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        self.do {
            $0.layer.cornerRadius = 8
            $0.frame.size.height = 52.adjusted
        }
        self.snp.makeConstraints {
            $0.height.equalTo(52.adjusted)
        }
    }
}

