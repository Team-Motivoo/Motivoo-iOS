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
            let rootViewController = UINavigationController(rootViewController: AuthorizationViewController())
            delegate.window?.rootViewController = rootViewController
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
