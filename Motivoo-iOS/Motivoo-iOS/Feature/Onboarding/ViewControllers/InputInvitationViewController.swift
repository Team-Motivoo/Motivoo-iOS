//
//  InputInvitationViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/15/24.
//

import UIKit

import SnapKit
import Then

final class InputInvitationViewController: BaseViewController {

    //MARK: - Properties

    private lazy var textFieldValue: String = ""

    // MARK: - UI Component

    private let inputInvitationView = InputInvitationView()

    var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled {
                inputInvitationView.startMotivooButton.setTitleColor(.white, for: .normal)
                inputInvitationView.startMotivooButton.backgroundColor = .gray900
            } else {
                inputInvitationView.startMotivooButton.setTitleColor(.gray400, for: .normal)
                inputInvitationView.startMotivooButton.backgroundColor = .gray100
            }
            inputInvitationView.startMotivooButton.isEnabled = isButtonEnabled
        }
    }

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        inputInvitationView.startMotivooButton.isEnabled = false
        inputInvitationView.startMotivooButton.setTitleColor(.gray400, for: .normal)
        inputInvitationView.startMotivooButton.backgroundColor = .gray100
    }

    // MARK: - Override Functions

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
        self.view.addSubviews(inputInvitationView)
    }

    override func setLayout() {
        inputInvitationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        inputInvitationView.startMotivooButton.addTarget(self, action: #selector(startMotivooButtonDidTap), for: .touchUpInside)
        inputInvitationView.inputTextField.addTarget(self, action:  #selector(textFieldDidChanacge), for: .editingChanged)
    }

    // MARK: - Actions

    @objc
    private func startMotivooButtonDidTap() {
        textFieldValue = inputInvitationView.inputTextField.text ?? ""
        print("textFieldValue= \(textFieldValue)")
        requestPatchInviteCodeAPI(inviteCode: textFieldValue)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        inputInvitationView.inputTextField.layer.borderColor = UIColor.gray300.cgColor
    }

    @objc
    func textFieldDidChanacge(_ sender: Any?) {
        if let text = inputInvitationView.inputTextField.text {
            if (!text.isEmpty) {
                isButtonEnabled = true
            } else {
                isButtonEnabled = false
            }
            inputInvitationView.inputTextField.layer.borderColor = UIColor.blue500.cgColor
            inputInvitationView.wrongLabel.isHidden = true
        }
    }
}

extension InputInvitationViewController {
    func requestPatchInviteCodeAPI(inviteCode: String) {
        let param = InviteCodeRequest(inviteCode: inviteCode)
        OnboardingAPI.shared.patchInviteCode(param: param) { result in
            guard let result = self.validateResult(result) as? InviteCodeResponse else { return }
            print(result)

            if !result.myInviteCode {
                if result.isMatched {
                    // 매치 O
                    UserDefaultManager.shared.saveUserMatcehd(match: result.isMatched)
                    self.inputInvitationView.inputTextField.layer.borderColor = UIColor.gray300.cgColor
                    self.inputInvitationView.wrongLabel.isHidden = true
                    if result.isFinishedOnboarding {
                        // 온보딩 완료
                        // 모티부 시작하기 홈VC로 이동
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        guard let delegate = sceneDelegate else {
                            print("sceneDelegate가 할당 Error")
                            return
                        }
                        let rootViewController = UINavigationController(rootViewController: MotivooTabBarController())
                        delegate.window?.rootViewController = rootViewController
                    } else {
                        // 온보딩 안함
                        // 온보딩 VC로 이동
                        let onboardingViewController = OnboardingViewController()
                        self.navigationController?.pushViewController(onboardingViewController, animated: true)
                    }
                } else {
                    self.inputInvitationView.inputTextField.layer.borderColor = UIColor.pink.cgColor
                    self.inputInvitationView.wrongLabel.isHidden = false
                }
            } else {
                self.inputInvitationView.inputTextField.layer.borderColor = UIColor.pink.cgColor
                self.inputInvitationView.wrongLabel.isHidden = false
            }

            if (result.isMatched && !result.myInviteCode) {
            } else {
                print("실패에에")
                self.inputInvitationView.inputTextField.layer.borderColor = UIColor.pink.cgColor
                self.inputInvitationView.wrongLabel.isHidden = false
            }
        }
    }
}
