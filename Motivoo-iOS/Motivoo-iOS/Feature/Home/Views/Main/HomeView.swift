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
    var dimmView = UIView()
    
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
            $0.text = TextLiterals.Home.Main.date
            $0.font = .caption1
            $0.textColor = .gray600
        }
        
        pickMissionLabel.do {
            $0.text = TextLiterals.Home.Main.pick
            $0.font = .heading4
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
            $0.text = TextLiterals.Home.Main.walk
        }
        
        homeCircularProgressView.do {
            $0.isHidden = true
        }
        
        checkMissionButton.do {
            $0.backgroundColor = .gray100
            $0.setTitle(TextLiterals.Home.Main.checkMission,
                        for: .normal)
            $0.setTitleColor(.gray400, for: .normal)
            $0.layer.cornerRadius = 8.adjusted
            $0.titleLabel?.font = .body5
            $0.isHidden = true
        }
        
        dimmView.do {
            $0.backgroundColor = .gray900.withAlphaComponent(0.7)
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
                         checkMissionButton,
                         dimmView)
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
        
        dimmView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        configureMissionSelectedView()
    }
    
    /// 나중에 아래 작업을 enum으로 처리하기! -> 서버 명세 참고
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
