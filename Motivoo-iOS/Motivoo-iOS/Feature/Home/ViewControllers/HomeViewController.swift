//
//  HomeViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/05.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var missionDummy: [HomeMissionModel] = [HomeMissionModel(image: ImageLiterals.img.motivooLogo,
                                                                     mission: TextLiterals.Home.firstMission),
                                                    HomeMissionModel(image: ImageLiterals.img.motivooLogo,
                                                                     mission: TextLiterals.Home.secondMission)]
    private var stepCountDummy: HomeStepModel = HomeStepModel(myStep: 1900,
                                                              parentStep: 4900)
    
    // MARK: - UI Components
    
    private var homeView = HomeView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureMissionView(dataList: self.missionDummy)
        configureStepCountView(data: self.stepCountDummy)
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        self.view.backgroundColor = .gray100
    }
    
    override func setHierachy() {
        self.view.addSubview(homeView)
    }
    
    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {

    }
    
    private func configureMissionView(dataList: [HomeMissionModel]) {
        homeView.firstMissionView.configureView(image: dataList[0].image,
                                                mission: dataList[0].mission)
        
        homeView.secondMissionView.configureView(image: dataList[1].image,
                                                mission: dataList[1].mission)
    }
    
    private func configureStepCountView(data: HomeStepModel) {
        homeView.homeStepCountView.configureView(myWalk: data.myStep,
                                                 parentWalk: data.parentStep)
    }
}
