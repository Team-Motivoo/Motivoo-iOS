//
//  MissionOverviewViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/05.
//

import UIKit

import SnapKit
import Then

final class MissionOverviewViewController: BaseViewController {
    
    // MARK: - Properties
    let missionOverviewView = MissionOverviewView()

    
    // MARK: - UI Components
    
    
    
    private func setTableViewConfig() {
        //        exerciseInfoView.exerciseInfotableView.register(SectionTitleTableViewCell.self,
        //                                      forCellReuseIdentifier: SectionTitleTableViewCell.cellIdentifier)
        //        exerciseInfoView.exerciseInfotableView.dataSource = self
        //        exerciseInfoView.exerciseInfotableView.delegate = self
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfig()
    }
    
    // MARK: - Override Functions
    override func setHierachy() {
        self.view.addSubview(missionOverviewView)

    }
    
    override func setLayout() {
        missionOverviewView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: -

