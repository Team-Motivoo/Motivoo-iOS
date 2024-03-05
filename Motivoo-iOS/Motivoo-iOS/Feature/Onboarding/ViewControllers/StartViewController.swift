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

    //MARK: - Properties
    lazy var isMatched: Bool = false
    lazy var isFinished: Bool = false

    // MARK: - UI Component
    private let motivooTextLogo = UIImageView()
    private let sloganLabel = UILabel()
    private let imageView = UIImageView()
    // 버튼 TextLiterals 수정 및 디자인 변경 반영 필요
    private let startMotivooButton = MotivooButton(text: TextLiterals.Onboarding.Login.motivooStart, buttonStyle: .gray900)
    private let invitationCodeButton = MotivooButton(text: TextLiterals.Onboarding.Login.invitationCode, buttonStyle: .gray100)

    // MARK: - Life Cycles

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        requestPostInviteCode()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Override Functions

    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationController?.isNavigationBarHidden = true
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
        let invitationViewController = InvitationViewController()
        self.navigationController?.pushViewController(invitationViewController, animated: true)
    }

    @objc
    private func invitationCodeButtonDidTap() {
        let inputInvitationViewController = InputInvitationViewController()
        self.navigationController?.pushViewController(inputInvitationViewController, animated: true)
    }
}

extension StartViewController {
    private func requestPostInviteCode() {
        OnboardingAPI.shared.postInviteCode() { result in
            guard let result = self.validateResult(result) as? NewInviteCodeResponse else { return }

            UserDefaultManager.shared.saveInviteCode(inviteCode: result.inviteCode)
            // print("==== invitationCode: \(self.invitationCode)")
        }
    }
}
