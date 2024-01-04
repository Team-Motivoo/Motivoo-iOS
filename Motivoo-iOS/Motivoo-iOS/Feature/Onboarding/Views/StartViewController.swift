//
//  StartViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/4/24.
//

import UIKit

import SnapKit
import Then

final class StartViewController: BaseViewController {

    // MARK: - UI Component

    private let kakaoLoginButton = UIButton().then {
        $0.setTitle("초대코드 입력하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .heading4
        $0.backgroundColor = UIColor(red: 0.36, green: 0.2, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 8
    }

    private let appleLoginButton = UIButton().then {
        $0.setTitle("모티부 시작하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .heading4
        $0.backgroundColor = UIColor(red: 0.957, green: 0.961, blue: 0.976, alpha: 1)
        $0.layer.cornerRadius = 8
    }

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Override Functions

    override func setHierachy() {
        self.view.addSubviews(kakaoLoginButton, appleLoginButton)
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
}
