//
//  HomeView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/06.
//

import UIKit

import SnapKit
import Then

final class HomeView: BaseView {
    
    // MARK: - Properties
    
    private var isMissionSelected: Bool = false {
        willSet {
            print("이거보세요오오오ㅗ!!!!!")
        }
    }
    var missionTappedHadler: (() -> (Void))?
    
    // MARK: - UI Components
    
    private var dateLabel = UILabel()
    var pickMissionLabel = UILabel()
    var firstMissionView = HomeMissionView()
    var secondMissionView = HomeMissionView()
    var stepTitleLabel = UILabel()
    private lazy var missionStackView = UIStackView(arrangedSubviews: [firstMissionView,
                                                                       secondMissionView])
    var homeStepCountView = HomeStepCountView()
    lazy var homeCircularProgressView = HomeCircularProgressView()
    var checkMissionButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureMissionTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Method
    
    override func setUI() {
        self.backgroundColor = .white
        
        dateLabel.do {
            $0.text = TextLiterals.Home.date
            $0.font = .caption1
            $0.textColor = .gray600
        }
        
        pickMissionLabel.do {
            $0.text = TextLiterals.Home.pick
            $0.font = .heading2
            $0.textColor = .black
        }
        
        missionStackView.do {
            $0.axis = .horizontal
            $0.spacing = 9.adjusted
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
        
        stepTitleLabel.do {
            $0.font = .caption1
            $0.textColor = .gray600
            $0.text = TextLiterals.Home.walk
        }
        
        homeCircularProgressView.do {
            $0.isHidden = true
        }
        
        checkMissionButton.do {
            $0.backgroundColor = .gray100
            $0.setTitle(TextLiterals.Home.checkMission,
                        for: .normal)
            $0.setTitleColor(.gray400, for: .normal)
            $0.layer.cornerRadius = 8.adjusted
            $0.isHidden = true
        }
    }
    
    override func setHierachy() {
        self.addSubviews(dateLabel,
                         pickMissionLabel,
                         missionStackView,
                         stepTitleLabel,
                         homeStepCountView,
                         homeCircularProgressView,
                         checkMissionButton)
    }
    
    override func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        pickMissionLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalTo(dateLabel)
        }
        
        missionStackView.snp.makeConstraints {
            $0.top.equalTo(pickMissionLabel.snp.bottom).offset(28.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(146.adjusted)
        }
        
        stepTitleLabel.snp.makeConstraints {
            $0.top.equalTo(missionStackView.snp.bottom).offset(36.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        homeStepCountView.snp.makeConstraints {
            $0.top.equalTo(stepTitleLabel.snp.bottom).offset(8.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
        }
        
        homeCircularProgressView.snp.makeConstraints {
            $0.top.equalTo(pickMissionLabel.snp.bottom).offset(44.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        checkMissionButton.snp.makeConstraints {
            $0.top.equalTo(homeStepCountView.snp.bottom).offset(16.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.height.equalTo(52.adjusted)
        }
    }
    
    // MARK: - Custom Method
    
    private func configureMissionTapGesture() {
        let firstMissionViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(missionViewDidTapped))
        let secondMissionViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(missionViewDidTapped))

        firstMissionView.addGestureRecognizer(firstMissionViewTappedGesture)
        secondMissionView.addGestureRecognizer(secondMissionViewTappedGesture)
    }
    
    @objc
    private func missionViewDidTapped() {
//        missionTappedHadler?()
        configureMissionSelectedView()
    }
    
    private func configureMissionSelectedView() {
        firstMissionView.isHidden = true
        secondMissionView.isHidden = true
        homeCircularProgressView.setMyProgress(to: 0.5, withAnimation: true)
        homeCircularProgressView.setParentProgress(to: 0.3, withAnimation: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.checkMissionButton.isHidden = false
            self.stepTitleLabel.isHidden = true
            self.homeCircularProgressView.isHidden = false
            self.homeStepCountView.transform = CGAffineTransform(translationX: 0, y: 102.adjusted)
            self.checkMissionButton.transform = CGAffineTransform(translationX: 0, y: 102.adjusted)
        })
    }
}
