//
//  HomeStepCountView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/09.
//

import UIKit

import SnapKit
import Then

final class HomeStepCountView: BaseView {
    
    // MARK: - Properties
        
    // MARK: - UI Components
    
    private var myWalkLabel = UILabel()
    var parentWalkLabel = UILabel()
    var myWalkCountLabel = UILabel()
    var parentWalkCountLabel = UILabel()
    private var divideLineView = UIView()
    private lazy var myWalkStackView = UIStackView(arrangedSubviews: [myWalkLabel,
                                                                      myWalkCountLabel])
    private lazy var parentWalkStackView = UIStackView(arrangedSubviews: [parentWalkLabel,
                                                                          parentWalkCountLabel])
    private lazy var totalStackView = UIStackView(arrangedSubviews: [myWalkStackView,
                                                                     divideLineView,
                                                                     parentWalkStackView])
    
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
        
        myWalkLabel.do {
            $0.font = .caption1
            $0.textColor = .gray700
            $0.text = TextLiterals.Home.Main.myWalk
        }
        
        parentWalkLabel.do {
            $0.font = .caption2
            $0.textColor = .gray600
            $0.text = TextLiterals.Home.Main.parentWalk
        }
        
        myWalkCountLabel.do {
            $0.font = .heading1
            $0.text = "0"
            $0.textColor = .blue800
        }
        
        parentWalkCountLabel.do {
            $0.font = .heading2
            $0.text = "0"
            $0.textColor = .gray600
        }
        
        divideLineView.do {
            $0.backgroundColor = .gray300
        }
        
        myWalkStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
            $0.alignment = .center
        }
        
        parentWalkStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
            $0.alignment = .center
        }
        
        totalStackView.do {
            $0.axis = .horizontal
            $0.spacing = 45.adjusted
            $0.alignment = .center
        }
    }
    
    override func setHierachy() {
        self.addSubview(totalStackView)
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(104.adjusted)
        }
        
        totalStackView.snp.makeConstraints {
            $0.center.height.equalToSuperview()
        }

        divideLineView.snp.makeConstraints {
            $0.width.equalTo(1.adjusted)
            $0.top.bottom.equalToSuperview().inset(20.adjusted)
        }
    }
    
    // MARK: - Custom Functions
    
    func configureView(myWalk: Int, parentWalk: Int) {
        myWalkCountLabel.text = "\(myWalk)"
        parentWalkCountLabel.text = "\(parentWalk)"
    }
}
