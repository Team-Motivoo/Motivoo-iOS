//
//  SplashViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

import SnapKit
import Then

final class SplashViewController: BaseViewController {
    
    // MARK: - UI Component

    private let logoImage = UIImageView()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            guard let delegate = sceneDelegate else {
                print("sceneDelegate가 할당 Error")
                return
            }

            let isUserLoggedIn: Bool = UserDefaultManager.shared.getUserLoggedIn()
            let userid: Int = UserDefaultManager.shared.getUserId()
            if userid == 0 {
                // userid가 없다면
                // 회원가입을 한 적이 없으므로 권한 허용 페이지로 진입
                let rootViewController = UINavigationController(rootViewController: AuthorizationViewController())
                delegate.window?.rootViewController = rootViewController
            } else {
                // userid가 있다면
                if isUserLoggedIn {
                    // 로그인 = true
                    // splash에서 바로 홈으로 진입
                    let rootViewController = UINavigationController(rootViewController: MotivooTabBarController())
                    delegate.window?.rootViewController = rootViewController
                    return
                }
                // userid는 있지만, 로그인 = false라면
                // 카카오톡 회원가입은 했지만, 이용약관 허용을 아직 진행하지 않았음으로 이용 약관 페이지로 이동
                let rootViewController = UINavigationController(rootViewController: TermsOfUseViewController())
                delegate.window?.rootViewController = rootViewController
            }
        }
    }

    // MARK: - Override Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationItem.leftBarButtonItem?.isHidden = true
    }

    override func setUI() {
        logoImage.do {
            $0.image = ImageLiterals.img.motivooLogo
        }
    }

    override func setHierachy() {
        self.view.addSubview(logoImage)
    }

    override func setLayout() {
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(240.adjusted)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(252.adjusted)
        }
    }
}
