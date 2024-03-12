//
//  SplashViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

import Lottie
import SnapKit
import Then

final class SplashViewController: BaseViewController {

    // MARK: - UI Component

    let lottieView = LottieAnimationView(name: "splash")
    var isUserLoggedIn: Bool = UserDefaultManager.shared.getUserLoggedIn()
    var token = TokenManager.shared.getToken()
    var isFinished: Bool = UserDefaultManager.shared.getFinishedOnboarding()
    var isMached: Bool = UserDefaultManager.shared.getUserMatcehd()

    // MARK: - Life Cycles

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 변경!! 앱이 최초에 시작할 때 불러오는 방법은 없을까?
        self.isUserLoggedIn = UserDefaultManager.shared.getUserLoggedIn()
        self.token = TokenManager.shared.getToken()
        self.isFinished = UserDefaultManager.shared.getFinishedOnboarding()
        self.isMached = UserDefaultManager.shared.getUserMatcehd()
        print("\n============viewWillAppear============")
        print("===isUserLoggedIn: \(isUserLoggedIn)")
        print("===token: \(token)")
        print("===isFinished: \(isFinished)")

        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lottieView.play()
        self.lottieView.loopMode = .playOnce

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            guard let delegate = sceneDelegate else {
                print("sceneDelegate가 할당 Error")
                return
            }

            print("\n==========viewDidLoad================")
            print(TokenManager.shared.getToken())
            print("==========================\n")

            print("isUserLoggedIn: \(self.isUserLoggedIn)")
            print("token: \(self.token)")
            print("isFinished: \(self.isFinished)")
            print("isMached: \(self.isMached)")

            if self.token == "" {
                // token이 없다면
                // 소셜로그인 화면으로 이동 (이후 이용약관)
                let rootViewController = UINavigationController(rootViewController: LoginViewController())
                delegate.window?.rootViewController = rootViewController
            } else {
                // token이 있다면
                if self.isFinished {
                    if self.isMached {
                        let rootViewController = UINavigationController(rootViewController: MotivooTabBarController())
                        delegate.window?.rootViewController = rootViewController
                    } else {
                        let rootViewController = UINavigationController(rootViewController: StartViewController())
                        delegate.window?.rootViewController = rootViewController
                    }
                } else {
                    let rootViewController = UINavigationController(rootViewController: OnboardingViewController())
                    delegate.window?.rootViewController = rootViewController
                }
                return
            }
        }
    }

    // MARK: - Override Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationItem.leftBarButtonItem?.isHidden = true
    }

    override func setUI() {
        lottieView.do {
            $0.frame = self.view.bounds
            $0.center = self.view.center
            $0.contentMode = .scaleAspectFit
        }
    }

    override func setHierachy() {
        self.view.addSubview(lottieView)
    }

    override func setLayout() {
        lottieView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SplashViewController {
    private func requestGetUserExercise() {
        OnboardingAPI.shared.getExercise() { result in
            guard let result = self.validateResult(result) as? UserExerciseResponse else {
                return
            }
            UserDefaultManager.shared.saveFinishedOnboarding(finished: result.isFinishedOnboarding)
            print("===Finish:  \(result.isFinishedOnboarding)")
            self.isFinished = UserDefaultManager.shared.getFinishedOnboarding()
        }
    }

    private func requestGetMatchingCheck() {
        OnboardingAPI.shared.getMatchingCheck() { result in
            guard let result = self.validateResult(result) as? MatchingCheckResponse
            else { return }
            if result.isMatched {
                UserDefaultManager.shared.saveUserMatcehd(match: result.isMatched)
            }
        }
    }
}
