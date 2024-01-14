//
//  HomeMissionView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/08.
//

import UIKit

import SnapKit
import Then

final class HomeMissionView: BaseView {
    
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
            $0.font = .body6
            $0.textColor = .black
            $0.numberOfLines = 2
        }
        
        totalStackView.do {
            $0.axis = .vertical
            $0.spacing = 10.adjusted
            $0.alignment = .leading
        }
    }
    
    override func setHierachy() {
        self.addSubview(totalStackView)
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(146.adjusted)
        }
        missionImageView.snp.makeConstraints {
            $0.height.width.equalTo(48.adjusted)
        }
        
        totalStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Custom Functions
    
    func configureView(image: UIImage, mission: String) {
        missionImageView.image = image
        missionLabel.text = mission
    }
    
}
