//
//  logoutpopupView.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/15/24.
//

import UIKit

import SnapKit
import Then

final class LeavePopupView: BaseView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    var popupView = UIView()
    var mainTitleLabel = UILabel()
    var subTitleLabel = UILabel()
    var blackButton = UIButton()
    var grayButton = UIButton()
    
    // MARK: - inits
    init() {
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        self.do {
            $0.backgroundColor = .gray900.withAlphaComponent(0.7)
        }
        
        popupView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
        
        mainTitleLabel.do {
            $0.font = .heading5
            $0.textColor = .black
        }
        
        subTitleLabel.do {
            $0.font = .body6
            $0.textColor = .gray600
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        
        blackButton.do {
            $0.backgroundColor = .gray900
            $0.titleLabel?.font = .body5
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }
        
        grayButton.do {
            $0.backgroundColor = .gray100
            $0.setTitle(TextLiterals.MyPage.no, for: .normal)
            $0.setTitleColor(.gray900, for: .normal)
            $0.titleLabel?.font = .body5
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
    }
    
    override func setHierachy() {
        self.addSubview(popupView)
        popupView.addSubviews(mainTitleLabel, subTitleLabel,
                              blackButton,
                              grayButton)
    }
    
    override func setLayout() {
        popupView.snp.makeConstraints {
            $0.height.equalTo(272.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(8.adjusted)
        }
        
        blackButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(131.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(220.adjusted)
            $0.height.equalTo(52.adjusted)
        }
        
        grayButton.snp.makeConstraints {
            $0.top.equalTo(blackButton.snp.bottom).offset(12.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(220.adjusted)
            $0.height.equalTo(52.adjusted)
        }
    }
}
