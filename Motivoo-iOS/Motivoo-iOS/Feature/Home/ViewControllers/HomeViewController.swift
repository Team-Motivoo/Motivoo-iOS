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
        homeView.checkMissionButton.addTarget(self, action: #selector(checkButtonDidTapped), for: .touchUpInside)
    }

    // MARK: - Custom Method
    
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
    
    @objc
    private func checkButtonDidTapped() {
        let homeProveViewController = HomeProveViewController()
        if let proveSheet = homeProveViewController.sheetPresentationController {
            proveSheet.detents = [
                .custom { _ in
                    return 356.adjusted
                }
            ]
            proveSheet.preferredCornerRadius = 20
        }
        /// present 됐을 때 뒷배경을 더 어둡게 하기 위한 View 보이게 해주기
        /// 이때, closure를 사용하여 dismiss 됐을 때, 어둡게 보이는 View를 숨기기
        homeView.dimmView.isHidden = false
        homeProveViewController.onDismissHandler = { [weak self] in
            guard let self else { return }
            self.homeView.dimmView.isHidden = true
        }
        
        self.present(homeProveViewController, animated: true)
    }
}
