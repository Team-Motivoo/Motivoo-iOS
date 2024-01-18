//
//  HomeProveSuccessView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/12/24.
//

import UIKit

import SnapKit
import Then

final class HomeProveSuccessView: BaseView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private var popupView = UIView()
    private var titleLabel = UILabel()
    private var subTitleLabel = UILabel()
    var proveImageView = UIImageView()
    private var checkImageView = UIImageView()
    var checkButton = UIButton()
    private lazy var bottomStackView = UIStackView(arrangedSubviews: [subTitleLabel,
                                                                      proveImageView,
                                                                      checkButton])
    
    // MARK: - inits
    
    init(image: UIImage) {
        super.init(frame: CGRect())
        
        proveImageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        self.do {
            $0.backgroundColor = .black.withAlphaComponent(0.7)
        }
        
        popupView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.text = TextLiterals.Home.Prove.title
            $0.font = .heading5
            $0.textColor = .black
        }
        
        subTitleLabel.do {
            $0.text = TextLiterals.Home.Prove.subTitle
            $0.font = .caption2
            $0.textColor = .gray600
        }
        
        checkButton.do {
            $0.setTitle(TextLiterals.Home.Prove.check, for: .normal)
            $0.backgroundColor = .gray900
            $0.titleLabel?.font = .body5
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }
        
        proveImageView.do {
            $0.layer.cornerRadius = 8
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        checkImageView.do {
            $0.image = ImageLiterals.icon.checkActive
        }
        
        bottomStackView.do {
            $0.axis = .vertical
            $0.spacing = 16.adjusted
            $0.alignment = .center
        }
    }
    
    override func setHierachy() {
        self.addSubview(popupView)
        popupView.addSubviews(titleLabel,
                              bottomStackView,
                              checkImageView)
    }
    
    override func setLayout() {
        popupView.snp.makeConstraints {
            $0.height.equalTo(369.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        proveImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(popupView).inset(20.adjusted)
            $0.height.equalTo(196.adjusted)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16.adjusted)
        }
        
        checkImageView.snp.makeConstraints {
            $0.height.width.equalTo(48.adjusted)
            $0.center.equalTo(proveImageView)
        }
        
        checkButton.snp.makeConstraints {
            $0.height.equalTo(52.adjusted)
            $0.leading.trailing.equalTo(popupView).inset(37.5.adjusted)
        }
    }
}
