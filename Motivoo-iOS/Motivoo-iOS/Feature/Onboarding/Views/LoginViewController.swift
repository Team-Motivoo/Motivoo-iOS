//
//  LoginViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/4/24.
//

import UIKit

import SnapKit
import Then
import KakaoSDKUser

final class LoginViewController: BaseViewController {
    
    // MARK: - UI Component

    private let kakaoLoginButton = UIButton().then {
        $0.setImage(ImageLiterals.img.kakaoLogin, for: .normal)
    }

    private let appleLoginButton = UIButton().then {
        $0.setImage(ImageLiterals.img.appleLogin, for: .normal)
    }

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Override Functions

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
        print("kakaoLoginButtonDidTap")
        if (UserApi.isKakaoTalkLoginAvailable()) {
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    let StartViewController = StartViewController()
                    self.navigationController?.pushViewController(StartViewController, animated: true)
                    _ = oauthToken
                    // 로그인 관련 메소드 추가
                }
            }
        } else {
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공 /n ===oauthToken: \(String(describing: oauthToken))")
                     let StartViewController = StartViewController()
                     self.navigationController?.pushViewController(StartViewController, animated: true)
                    _ = oauthToken
                    // 관련 메소드 추가
                }
            }
        }
    }
}
