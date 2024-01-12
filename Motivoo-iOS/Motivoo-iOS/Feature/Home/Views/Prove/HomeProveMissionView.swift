//
//  HomeProveMissionView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/11.
//

import UIKit

import SnapKit
import Then

final class HomeProveMissionView: BaseView {
    
    // MARK: - Properties
            
    // MARK: - UI Components
    
    private var missionImageView = UIImageView()
    private var missionLabel = UILabel()
    private lazy var totalStackView = UIStackView(arrangedSubviews: [missionImageView,
                                                                      missionLabel])
    
    // MARK: - inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        self.do {
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 8
        }
        
        missionLabel.do {
            $0.font = .body5
            $0.textColor = .black
        }
        
        totalStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
            $0.alignment = .center
        }
    }
    
    override func setHierachy() {
        self.addSubview(totalStackView)
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(123.adjusted)
        }
        missionImageView.snp.makeConstraints {
            $0.height.width.equalTo(40.adjusted)
        }
        
        totalStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(19.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Custom Functions
    
    func configureView(image: UIImage, text: String) {
        missionImageView.image = image
        missionLabel.text = text
    }
}
