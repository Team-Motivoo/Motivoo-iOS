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

    private let invitationView = InvitationView()

    // MARK: - Life Cycles

    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem?.isHidden = true
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
        UIPasteboard.general.string = invitationView.codeLabel.text
    }

    @objc
    private func matchingCheckButtonDidTap() {
        // checking
        showMatchingLabel(TextLiterals.Onboarding.Invitation.checking, withDuration: 0.5, delay: 2.0)
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

