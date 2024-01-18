//
//  LeaveViewController.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/16/24.
//

import UIKit

import SnapKit
import Then

final class LeaveViewController: BaseViewController {
    

    // MARK: - UI Components
    
    let popupView: LeavePopupView
    
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    
    init() {
        self.popupView = LeavePopupView()
        super.init(nibName: nil, bundle:nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Override Functions
    
    override func setHierachy() {
        self.view.addSubviews(popupView)
    }
    
    override func setLayout() {
        popupView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        popupView.grayButton.addTarget(self, action: #selector(checkButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom  Method
    
    @objc
    private func checkButtonDidTapped() {
        dismiss(animated: true)
    }
    func popupConfigureCell(title: String, subtitle: String, buttonTitle: String) {
        popupView.mainTitleLabel.text = title
        popupView.subTitleLabel.text = subtitle
        popupView.blackButton.titleLabel?.text = buttonTitle
        popupView.blackButton.setTitle(buttonTitle, for: .normal) // 여기를 수정
    }
}
