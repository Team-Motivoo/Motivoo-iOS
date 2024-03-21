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
    
    var missionID: Int = Int()
    var missionSelectedHandler: (() -> (Void))?
            
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
            $0.font = UIFont(name: "Pretendard-Medium", size: 20)
            $0.textColor = .black
            $0.setLineSpacing(lineSpacing: 1.24.adjusted)
            $0.numberOfLines = 3
        }
        
        totalStackView.do {
            $0.axis = .vertical
            $0.spacing = 16.adjusted
            $0.alignment = .leading
        }
    }
    
    override func setHierachy() {
        self.addSubview(totalStackView)
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(162.adjusted)
            $0.width.equalTo(335.adjusted)
        }
        missionImageView.snp.makeConstraints {
            $0.height.width.equalTo(48.adjusted)
        }
        
        totalStackView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20.adjusted)
            $0.trailing.equalToSuperview().inset(10.adjusted)
        }
    }
    
    // MARK: - Custom Functions
    
    func configureView(imageURL: String, mission: String, id: Int) {
        missionImageView.kfSetImage(url: imageURL)
        missionLabel.text = mission
        self.missionID = id
    }
}
