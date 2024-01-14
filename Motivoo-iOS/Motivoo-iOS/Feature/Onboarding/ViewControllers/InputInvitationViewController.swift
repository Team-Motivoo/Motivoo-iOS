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

        self.navigationItem.leftBarButtonItem?.isHidden = true
        inputInvitationView.startMotivooButton.isEnabled = false
        inputInvitationView.startMotivooButton.setTitleColor(.gray400, for: .normal)
        inputInvitationView.startMotivooButton.backgroundColor = .gray100
    }

    // MARK: - Override Functions

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
        // checking
        let text = inputInvitationView.inputTextField.text
        if (text == "123") {
            // 모티부 시작하기 홈VC로 이동
            print("=== 모티부 시작하기 홈VC로 이동")
            inputInvitationView.inputTextField.layer.borderColor = UIColor.gray300.cgColor
            inputInvitationView.wrongLabel.isHidden = true
        } else {
            inputInvitationView.inputTextField.layer.borderColor = UIColor.pink.cgColor
            inputInvitationView.wrongLabel.isHidden = false
        }
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
