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
    private let inviteCodeCreateButton = MotivooButton(text: TextLiterals.Onboarding.Login.inviteCodeCreate, buttonStyle: .gray900)
    private let dividerImageView = UIImageView()
    private let inviteCodeInputButton = MotivooButton(text: TextLiterals.Onboarding.Login.inviteCodeInput, buttonStyle: .gray100)
    

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
            $0.text = TextLiterals.Onboarding.Login.slogan
            $0.font = .heading4
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.addLineHeight(lineHeight: 28.adjusted)
        }
        imageView.do {
            $0.image = ImageLiterals.img.loginAfter
        }
        dividerImageView.do {
            $0.image = ImageLiterals.img.orDivider
        }
    }

    override func setHierachy() {
        self.view.addSubviews(motivooTextLogo, sloganLabel, imageView, inviteCodeCreateButton, dividerImageView, inviteCodeInputButton)
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
            $0.top.equalTo(sloganLabel.snp.bottom).offset(77.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(264.adjusted)
            $0.width.equalTo(249.adjusted)
        }
        inviteCodeCreateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(dividerImageView.snp.top).offset(-6.adjusted)
        }
        dividerImageView.snp.makeConstraints {
            $0.width.equalTo(335.adjusted)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(inviteCodeInputButton.snp.top).offset(-6.adjusted)
        }
        inviteCodeInputButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(44.adjusted)
        }
    }

    override func setButtonEvent() {
        inviteCodeCreateButton.addTarget(self, action: #selector(inviteCodeCreateButtonDidTap), for: .touchUpInside)
        inviteCodeInputButton.addTarget(self, action: #selector(inviteCodeInputButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func inviteCodeCreateButtonDidTap() {
        let invitationViewController = InvitationViewController()
        self.navigationController?.pushViewController(invitationViewController, animated: true)
    }

    @objc
    private func inviteCodeInputButtonDidTap() {
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
