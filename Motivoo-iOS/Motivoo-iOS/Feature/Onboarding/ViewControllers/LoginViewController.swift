//
//  LoginViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/4/24.
//

import UIKit

import AuthenticationServices
import SnapKit
import Then
import KakaoSDKUser

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
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTap), for: .touchUpInside)
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
        print("kakaoLoginButtonDidTap")
        if (UserApi.isKakaoTalkLoginAvailable()) {
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    let startViewController = StartViewController()
                    self.navigationController?.pushViewController(startViewController, animated: true)
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

    @objc
    private func appleLoginButtonDidTap() {
        print("appleLoginButtonDidTap")
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }

        // 이메일
        if let email = credential.email {
            print("이메일 : \(email)")
        }
        else {
            // credential.identityToken은 jwt로 되어있고, 해당 토큰을 decode 후 email에 접근해야한다.
            if let tokenString = String(data: credential.identityToken ?? Data(), encoding: .utf8) {
                let email2 = JWTDecode.decode(jwtToken: tokenString)["email"] as? String ?? ""
                print("이메일 - \(email2)")
            }
        }

        // 이름
        if let fullName = credential.fullName {
            print("이름 : \(fullName.familyName ?? "")\(fullName.givenName ?? "")")
        }

        let startViewController = StartViewController()
        self.navigationController?.pushViewController(startViewController, animated: true)
    }

    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("apple login failed")
    }
}
