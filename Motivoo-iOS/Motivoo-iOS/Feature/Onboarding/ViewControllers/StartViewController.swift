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

    private let startMotivooButton = MotivooButton(text: "모티부 시작하기", buttonStyle: .gray900)
    private let invitationCodeButton = MotivooButton(text: "초대코드 입력하기", buttonStyle: .gray100)


    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Override Functions

    override func setHierachy() {
        self.view.addSubviews(startMotivooButton, invitationCodeButton)
    }

    override func setLayout() {
        startMotivooButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(invitationCodeButton.snp.top).offset(-16.adjusted)
        }
        invitationCodeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
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
