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
    private let motivooTextLogo = UIImageView()
    private let sloganLabel = UILabel()
    private let imageView = UIImageView()
    private let startMotivooButton = MotivooButton(text: "모티부 시작하기", buttonStyle: .gray900)
    private let invitationCodeButton = MotivooButton(text: "초대코드 입력하기", buttonStyle: .gray100)


    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        print(TokenManager.shared.getToken())
        requestGetUserExercise()
    }

    // MARK: - Override Functions

    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationItem.leftBarButtonItem?.isHidden = true
    }

    override func setUI() {
        motivooTextLogo.do {
            $0.image = ImageLiterals.img.motivooTextLogo
            $0.backgroundColor = .lightGray
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
            $0.image = ImageLiterals.img.loginAfter
        }
    }

    override func setHierachy() {
        self.view.addSubviews(motivooTextLogo, sloganLabel, imageView, startMotivooButton, invitationCodeButton)
    }

    override func setLayout() {
        motivooTextLogo.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
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
        startMotivooButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(invitationCodeButton.snp.top).offset(-16.adjusted)
        }
        invitationCodeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(44.adjusted)
        }
    }

    override func setButtonEvent() {
        startMotivooButton.addTarget(self, action: #selector(startMotivooButtonDidTap), for: .touchUpInside)
        invitationCodeButton.addTarget(self, action: #selector(invitationCodeButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func startMotivooButtonDidTap() {
        let onboardingViewController = OnboardingViewController()
        self.navigationController?.pushViewController(onboardingViewController, animated: true)
    }

    @objc
    private func invitationCodeButtonDidTap() {
        let inputInvitationViewController = InputInvitationViewController()
        self.navigationController?.pushViewController(inputInvitationViewController, animated: true)
    }
}

extension StartViewController {
    private func requestGetUserExercise() {
        OnboardingAPI.shared.getExercise() { result in
            guard let result = self.validateResult(result) as? UserExerciseResponse else {
                return
            }
            print("===Finish:  \(result.isFinishedOnboarding)")
        }
    }
}
