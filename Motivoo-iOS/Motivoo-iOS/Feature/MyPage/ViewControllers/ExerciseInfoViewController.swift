//
//  ExerciseInfoViewController.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class ExerciseInfoViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var exerciseInfoDummy: [ExerciseInfo] = [ExerciseInfo(title: TextLiterals.MyPage.exercisestatus, info: "예"),
                                                     ExerciseInfo(title: TextLiterals.MyPage.intensity, info: "아니오"),
                                                     ExerciseInfo(title: TextLiterals.MyPage.weeklyaverageFrequency, info: "예"),
                                                     ExerciseInfo(title: TextLiterals.MyPage.averageTimePerDay, info: "아니오"),
                                                     ExerciseInfo(title: TextLiterals.MyPage.pointsToNote, info: "예")]
    
    // MARK: - UI Components
    
    let exerciseInfoView = ExerciseInfoView()
    private var nextButton = UIButton()
    
    
    private func setTableViewConfig() {
        exerciseInfoView.exerciseInfotableView.register(SectionTitleTableViewCell.self,
                                      forCellReuseIdentifier: SectionTitleTableViewCell.cellIdentifier)
        exerciseInfoView.exerciseInfotableView.dataSource = self
        exerciseInfoView.exerciseInfotableView.delegate = self
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfig()
    }
    
    // MARK: - Override Functions
    override func setHierachy() {
        self.view.addSubview(exerciseInfoView)
    }
    
    override func setLayout() {
        exerciseInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension ExerciseInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseInfoDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleTableViewCell.cellIdentifier) as? SectionTitleTableViewCell else {return UITableViewCell()}
        cell.configureCell(title: exerciseInfoDummy[indexPath.row].title, info: exerciseInfoDummy[indexPath.row].info)
        print("cell: \(indexPath.row)")
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
   
}
