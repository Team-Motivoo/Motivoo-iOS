//
//  HomeView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/06.
//

import UIKit

import SnapKit
import Then

enum MissionButtonState {
    case unCompleted
    case completed
    case checkCompleted
}

final class HomeView: BaseView {
    
    // MARK: - Properties
    
    var isMissionSelected: Bool = false
    var responseData: HomeMissionsResponse?
    var isBlinking: Bool = false
    var missionSelectedHandler: ((Int) -> Void)?
    
    // MARK: - UI Components
    
    var dateLabel = UILabel()
    var pickMissionLabel = UILabel()
    lazy var firstMissionView = HomeMissionView()
    lazy var secondMissionView = HomeMissionView()
    private lazy var missionStackView = UIStackView(arrangedSubviews: [firstMissionView,
                                                                       secondMissionView])
    var homeStepCountView = HomeStepCountView()
    lazy var homeCircularProgressView = HomeCircularProgressView()
    var checkMissionButton = UIButton()
    var dimmView = UIView()
    var guideButton = UIButton()
    
    // MARK: - Override Method
    
    override func setUI() {
        self.backgroundColor = .white
        
        dateLabel.do {
            $0.text = TextLiterals.Home.Main.date
            $0.font = .caption1
            $0.textColor = .gray600
            $0.addLineHeight(lineHeight: 28.adjusted)
        }
        
        pickMissionLabel.do {
            $0.text = TextLiterals.Home.Main.pick
            $0.font = .heading4
            $0.numberOfLines = 2
            $0.textColor = .black
            $0.setLineSpacing(lineSpacing: 1.17.adjusted)
        }
        
        missionStackView.do {
            $0.axis = .vertical
            $0.spacing = 10.adjusted
            $0.alignment = .center
            $0.distribution = .fillEqually
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
        
        guideButton.do {
            $0.setImage(ImageLiterals.img.exerciseGuide, for: .normal)
            $0.isHidden = true
        }
        
        homeStepCountView.do {
            $0.isHidden = true
        }
    }
    
    override func setHierachy() {
        self.addSubviews(dateLabel,
                         pickMissionLabel,
                         guideButton,
                         missionStackView,
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
        
        guideButton.snp.makeConstraints {
            $0.height.equalTo(36.adjusted)
            $0.width.equalTo(96.adjusted)
            $0.top.equalTo(dateLabel)
            $0.trailing.equalToSuperview().inset(19.adjusted)
        }
        
        missionStackView.snp.makeConstraints {
            $0.top.equalTo(pickMissionLabel.snp.bottom).offset(18.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
        }
        
        homeStepCountView.snp.makeConstraints {
            $0.top.equalTo(homeCircularProgressView.snp.bottom)
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
    
    func configureCheckButtonStyle(state: MissionButtonState) {
        switch state {
        case .unCompleted:
            checkMissionButton.do {
                $0.backgroundColor = .gray100
                $0.setTitle(TextLiterals.Home.Main.checkMission,
                            for: .normal)
                $0.setTitleColor(.gray400, for: .normal)
                $0.titleLabel?.font = .body5
                $0.isEnabled = false
            }
        case .completed:
            checkMissionButton.do {
                $0.backgroundColor = .gray900
                $0.setTitle(TextLiterals.Home.Main.checkMission,
                            for: .normal)
                $0.setTitleColor(.white, for: .normal)
                $0.titleLabel?.font = .body5
                $0.isEnabled = true
            }
        case .checkCompleted:
            checkMissionButton.do {
                $0.backgroundColor = .gray100
                $0.setTitle(TextLiterals.Home.Main.completedMission,
                            for: .normal)
                $0.setTitleColor(.gray400, for: .normal)
                $0.titleLabel?.font = .body5
                $0.isEnabled = false
            }
        }
    }
    
    /// 나중에 아래 작업을 enum으로 처리하기! -> 서버 명세 참고
    /// 여기서 아이디 받아서 서버통신 함수 쏘기
    func configureMissionSelectedView(isSelected: Bool) {
        print("들어왔어요!!!!!!!!!!!🔥🔥🔥🔥 미션 선정 여부 값 -> \(isSelected)")
        if isSelected {
            firstMissionView.isHidden = true
            secondMissionView.isHidden = true
            self.checkMissionButton.isHidden = false
            self.guideButton.isHidden = false
            self.homeCircularProgressView.isHidden = false
            self.homeStepCountView.isHidden = false
        } else {
            firstMissionView.isHidden = false
            secondMissionView.isHidden = false
            self.checkMissionButton.isHidden = true
            self.homeCircularProgressView.isHidden = true
            self.homeStepCountView.isHidden = true
            self.guideButton.isHidden = true
        }
    }
    
    func configureView(data: HomeMissionsResponse) {
        isMissionSelected = data.isChoiceFinished
        configureMissionSelectedView(isSelected: data.isChoiceFinished)
        ///오늘의 날짜가 nil값이 들어오는 경우
        if data.date == nil {
            dateLabel.text = TextLiterals.Home.Main.date
        } else {
            dateLabel.text = data.date
        }
        
        /// 오늘의 미션 구조체가 존재하는 경우(미션 선택 후)
        if data.todayMission != nil {
            pickMissionLabel.text = data.todayMission?.missionContent
        }
        
        /// 미션 선택 전
        if data.missionChoiceList != nil {
            let firstMission = data.missionChoiceList?[0]
            let secondMission = data.missionChoiceList?[1]


            firstMissionView.configureView(imageURL: firstMission?.missionIconURL ?? "",
                                           mission: firstMission?.missionContent ?? "",
                                           id: firstMission?.missionID ?? Int())
            
            secondMissionView.configureView(imageURL: secondMission?.missionIconURL ?? "",
                                            mission: secondMission?.missionContent ?? "",
                                            id: secondMission?.missionID ?? Int())
        }
    }
}
