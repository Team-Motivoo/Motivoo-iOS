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

        invitationText =
        """
        자녀와 부모를 잇는 매일 한 걸음! 🏃‍♂️🩵 '모티부'에 초대받았어요.
        매일 운동 미션을 수행하며 가족과 함께 건강 습관을 만들어 보아요!

        https://gayeong04.notion.site/7f6097380a0b43d38ae265ea985152e7?pvs=4

        1.위 링크로 들어가 모티부를 설치해요.
        2.설치가 완료되면 로그인 후 '초대코드 입력하기' 버튼을 누르고 아래 초대코드를 입력하세요.
        3.주어진 질문들에 답하면 맞춤 운동과 함께 자녀와의 운동이 시작됩니다 :)

        초대코드: \(invitationCode)
        """
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
