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

    private let startMotivooButton = UIButton()
    private let invitationCodeButton = UIButton()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }

    override func setUI() {
        startMotivooButton.do {
            $0.setTitle("모티부 시작하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .body5
            $0.backgroundColor = .gray900
            $0.layer.cornerRadius = 8
        }
        invitationCodeButton.do {
            $0.setTitle("초대코드 입력하기", for: .normal)
            $0.setTitleColor(.gray900, for: .normal)
            $0.titleLabel?.font = .body5
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 8
        }
    }

    // MARK: - Override Functions

    override func setHierachy() {
        self.view.addSubviews(startMotivooButton, invitationCodeButton)
    }

    override func setLayout() {
        startMotivooButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(52.adjusted)
            $0.bottom.equalTo(invitationCodeButton.snp.top).offset(-16.adjusted)
        }
        invitationCodeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(52.adjusted)
            $0.bottom.equalToSuperview().inset(78.adjusted)
        }
    }

    override func setButtonEvent() {
        startMotivooButton.addTarget(self, action: #selector(startMotivooButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func startMotivooButtonDidTap() {
        let OnboardingViewController = OnboardingViewController()
        self.navigationController?.pushViewController(OnboardingViewController, animated: true)
    }
}
