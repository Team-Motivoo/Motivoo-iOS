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

    private let motivooTextLogo = UIImageView()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()

    // MARK: - Override Functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationItem.leftBarButtonItem?.isHidden = true
    }

    override func setUI() {
        motivooTextLogo.do {
            $0.image = ImageLiterals.img.motivooTextLogo
        }
        kakaoLoginButton.do {
            $0.setImage(ImageLiterals.img.kakaoLogin, for: .normal)
        }
        appleLoginButton.do {
            $0.setImage(ImageLiterals.img.appleLogin, for: .normal)
        }
    }

    override func setHierachy() {
        self.view.addSubviews(motivooTextLogo, kakaoLoginButton, appleLoginButton)
        self.view.bringSubviewToFront(self.motivooTextLogo)
    }

    override func setButtonEvent() {
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap), for: .touchUpInside)
    }

    override func setLayout() {
        motivooTextLogo.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(16.adjusted)
            $0.width.equalTo(78.adjusted)
        }
        kakaoLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52.adjusted)
            $0.width.equalTo(335.adjusted)
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-20.adjusted)
        }
        appleLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52.adjusted)
            $0.width.equalTo(335.adjusted)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(44.adjusted)
        }
    }

    // MARK: - Actions

    @objc
    private func kakaoLoginButtonDidTap() {
        let termsOfUseViewController = TermsOfUseViewController()
        self.navigationController?.pushViewController(termsOfUseViewController, animated: true)
    }
}
