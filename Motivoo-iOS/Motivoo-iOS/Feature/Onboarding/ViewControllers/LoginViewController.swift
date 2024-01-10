//
//  LoginViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/4/24.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: BaseViewController {
    
    // MARK: - UI Component

    private let kakaoLoginButton = UIButton()

    private let appleLoginButton = UIButton()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Override Functions

    override func setUI() {
        kakaoLoginButton.do {
            $0.setImage(ImageLiterals.img.kakaoLogin, for: .normal)
        }
        appleLoginButton.do {
            $0.setImage(ImageLiterals.img.appleLogin, for: .normal)
        }
    }

    override func setHierachy() {
        self.view.addSubviews(kakaoLoginButton, appleLoginButton)
    }

    override func setButtonEvent() {
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap), for: .touchUpInside)
    }

    override func setLayout() {
        kakaoLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(53.adjusted)
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-20.adjusted)
        }
        appleLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjusted)
            $0.height.equalTo(53.adjusted)
            $0.bottom.equalToSuperview().inset(91.adjusted)
        }
    }

    // MARK: - Actions

    @objc
    private func kakaoLoginButtonDidTap() {
        let nextVC = StartViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
