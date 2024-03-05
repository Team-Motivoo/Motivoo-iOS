//
//  InvitationViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/12/24.
//

import UIKit

import SnapKit
import Then

final class InvitationViewController: BaseViewController {

    //MARK: - Properties

    var invitationCode: String = UserDefaults.standard.string(forKey: "inviteCode") ?? "Error"
    lazy var invitationText: String = ""

    // MARK: - UI Component

    private let invitationView = InvitationView()

    // MARK: - Override Functions
    override func viewWillAppear(_ animated: Bool) {
        invitationView.codeLabel.text = invitationCode
        invitationText = invitationCode
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationController?.isNavigationBarHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    override func setHierachy() {
        self.view.addSubviews(invitationView)
    }

    override func setLayout() {
        invitationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        invitationView.copyButton.addTarget(self, action: #selector(copyButtonDidTap), for: .touchUpInside)
        invitationView.matchingCheckButton.addTarget(self, action: #selector(matchingCheckButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func copyButtonDidTap() {
        showClipboardLabel(TextLiterals.Onboarding.Invitation.clipboard, withDuration: 0.5, delay: 1.0)
        // 클립보드 복사하기
        UIPasteboard.general.string = invitationText
    }

    @objc
    private func matchingCheckButtonDidTap() {
        requestGetMatchingCheck()
    }

    func showMatchingLabel(_ message : String, withDuration: Double, delay: Double) {
        let toastLabel = UILabel()
        toastLabel.do {
            $0.textColor = .pink
            $0.font = .caption1
            $0.textAlignment = .center
            $0.text = message
            $0.alpha = 1.0
        }

        self.view.addSubview(toastLabel)

        toastLabel.snp.makeConstraints {
            $0.bottom.equalTo(invitationView.matchingCheckButton.snp.top).offset(-2.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(192.adjusted)
            $0.height.equalTo(44.adjusted)
        }

        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

    func showClipboardLabel(_ message : String, withDuration: Double, delay: Double) {
        let toastLabel = UILabel()
        toastLabel.do {
            $0.backgroundColor = .gray600
            $0.textColor = .white
            $0.font = .caption2
            $0.textAlignment = .center
            $0.text = message
            $0.alpha = 1.0
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }

        self.view.addSubview(toastLabel)

        toastLabel.snp.makeConstraints {
            $0.bottom.equalTo(invitationView.matchingCheckButton.snp.top).offset(-16.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(192.adjusted)
            $0.height.equalTo(44.adjusted)
        }

        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension InvitationViewController {
    private func requestGetMatchingCheck() {
        OnboardingAPI.shared.getMatchingCheck() { result in
            guard let result = self.validateResult(result) as? MatchingCheckResponse 
            else {
                self.showMatchingLabel(TextLiterals.Onboarding.Invitation.checking, withDuration: 0.5, delay: 2.0)
                return
            }
            if result.isMatched {
                UserDefaultManager.shared.saveUserMatcehd(match: result.isMatched)
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                guard let delegate = sceneDelegate else {
                    print("sceneDelegate가 할당 Error")
                    return
                }
                let rootViewController = UINavigationController(rootViewController: MotivooTabBarController())
                delegate.window?.rootViewController = rootViewController
            }
        }
    }
}
