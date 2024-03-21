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

    //MARK: - Properties

    var accesstoken: String = ""
    var loginPlatform: String = ""

    // MARK: - UI Component

    private let motivooTextLogo = UIImageView()
    private let sloganLabel = UILabel()
    private let imageView = UIImageView()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    private let loginRetryLabel = UILabel()

    // MARK: - Override Functions

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginRetryLabel.isHidden = true
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationController?.isNavigationBarHidden = true
    }

    override func setUI() {
        motivooTextLogo.do {
            $0.image = ImageLiterals.img.motivooTextLogo
        }
        sloganLabel.do {
            $0.text = TextLiterals.Onboarding.slogan
            $0.font = .heading4
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.addLineHeight(lineHeight: 28.adjusted)
        }
        imageView.do {
            $0.image = ImageLiterals.img.login
        }
        kakaoLoginButton.do {
            $0.setImage(ImageLiterals.img.kakaoLogin, for: .normal)
        }
        appleLoginButton.do {
            $0.setImage(ImageLiterals.img.appleLogin, for: .normal)
        }
        loginRetryLabel.do {
            $0.text = TextLiterals.Onboarding.loginRetry
            $0.font = .caption1
            $0.textColor = .pink
            $0.textAlignment = .center
        }
    }

    override func setHierachy() {
        self.view.addSubviews(motivooTextLogo, sloganLabel, imageView, kakaoLoginButton, appleLoginButton, loginRetryLabel)
    }

    override func setButtonEvent() {
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap), for: .touchUpInside)
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTap), for: .touchUpInside)
    }

    override func setLayout() {
        motivooTextLogo.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(16.adjusted)
            $0.width.equalTo(78.adjusted)
        }
        sloganLabel.snp.makeConstraints {
            $0.top.equalTo(motivooTextLogo.snp.bottom).offset(24.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(sloganLabel.snp.bottom).offset(20.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(348.adjusted)
            $0.width.equalTo(335.adjusted)
        }
        kakaoLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52.adjusted)
            $0.width.equalTo(335.adjusted)
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-12.adjusted)
        }
        appleLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52.adjusted)
            $0.width.equalTo(335.adjusted)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(44.adjusted)
        }
        loginRetryLabel.snp.makeConstraints {
            $0.bottom.equalTo(kakaoLoginButton.snp.top).offset(-16.adjusted)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc
    private func kakaoLoginButtonDidTap() {
        self.loginPlatform = "kakao"

        if (UserApi.isKakaoTalkLoginAvailable()) {
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("==== 카카오 톡으로 로그인 성공")
                    // 로그인 관련 메소드 추가
                    self.accesstoken = oauthToken?.accessToken ?? ""
                    self.requestPostLoginAPI(accesstoken: self.accesstoken, tokenType: self.loginPlatform)
                }
            }
        } else {
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("==== 카카오 계정으로 로그인 성공 /n ===oauthToken: \(String(describing: oauthToken?.accessToken))")
                    // 관련 메소드 추가
                    self.accesstoken = oauthToken?.accessToken ?? ""
                    self.requestPostLoginAPI(accesstoken: self.accesstoken, tokenType: self.loginPlatform)
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
            if let identityToken = credential.identityToken,
               let tokenString = String(data: identityToken, encoding: .utf8){
                print("==== tokenString: \(identityToken)")
                self.accesstoken = tokenString
                self.loginPlatform = "apple"
                self.requestPostLoginAPI(accesstoken: self.accesstoken, tokenType: self.loginPlatform)
                let email2 = JWTDecode.decode(jwtToken: tokenString)["email"] as? String ?? ""
                print("이메일 - \(email2)")
            }
        }

        // 이름
        if let fullName = credential.fullName {
            print("이름 : \(fullName.familyName ?? "")\(fullName.givenName ?? "")")
        }
    }

    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("apple login failed")
        self.loginRetryLabel.isHidden = false
    }
}

extension LoginViewController {
    func requestPostLoginAPI(accesstoken: String, tokenType: String) {
        let param = OnboardingLoginRequest(socialAccessToken: accesstoken, tokenType: loginPlatform)
        OnboardingAPI.shared.postLogin(param: param) { result in
            guard let result = self.validateResult(result) as? OnboardingLoginResponse 
            else {
                self.loginRetryLabel.isHidden = false
                return
            }

            print("=== postLogin result: \(result)")

            TokenManager.shared.saveToken(token: "Bearer \(result.accessToken)")
            UserDefaultManager.shared.saveFinishedOnboarding(finished: result.isFinishedOnboarding)
            UserDefaultManager.shared.saveUserMatcehd(match: result.isMatched)

            let isMatched: Bool = UserDefaultManager.shared.getUserMatcehd()
            let isFinished: Bool = UserDefaultManager.shared.getFinishedOnboarding()
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            guard let delegate = sceneDelegate else {
                print("sceneDelegate가 할당 Error")
                return
            }

            if isMatched && isFinished {
                // 로그인 -> 온보딩 정보 입력 및 매칭 확인 (둘 다 true)
                let rootViewController = UINavigationController(rootViewController: MotivooTabBarController())
                delegate.window?.rootViewController = rootViewController
            } else {
                if isFinished {
                    if !isMatched {
                        // 온보딩은 입력했지만 매칭이 안된 경우는 StartVC
                        let rootViewController = UINavigationController(rootViewController: StartViewController())
                        delegate.window?.rootViewController = rootViewController
                    }
                } else {
                    // 온보딩 정보 입력을 안했다면 OnboardingVC
                    let rootViewController = UINavigationController(rootViewController: AuthorizationViewController())
                    delegate.window?.rootViewController = rootViewController
                }
            }
        }
    }
}
