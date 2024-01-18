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
    
    var exerciseInfo: ExerciseInfoResponse? {
        didSet {
            exerciseInfoView.exerciseInfotableView.reloadData()
        }
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        requestExerciseAPI()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleTableViewCell.cellIdentifier) as? SectionTitleTableViewCell else {return UITableViewCell()}
        if indexPath.row == 0 {
            guard let isExercise = exerciseInfo?.isExercise else {return UITableViewCell() }
            let answer: String
               if isExercise == true {
                   answer = "예"
               } else {
                   answer = "아니오"
               }
            cell.configureCell(title: TextLiterals.MyPage.exercisestatus, info: (answer))
        }
        else if indexPath.row  == 1 {
            guard let intensity = exerciseInfo?.exerciseType else {return UITableViewCell() }
            cell.configureCell(title: TextLiterals.MyPage.intensity, info: "\(intensity)")
        }
        else if indexPath.row == 2 {
            guard let exerciseFrequency = exerciseInfo?.exerciseFrequency else {return UITableViewCell() }
            cell.configureCell(title: TextLiterals.MyPage.weeklyaverageFrequency, info: "\(exerciseFrequency)")
        }
        else if indexPath.row == 3 {
            guard let exerciseTime = exerciseInfo?.exerciseTime else {return UITableViewCell() }
            cell.configureCell(title: TextLiterals.MyPage.averageTimePerDay, info: "\(exerciseTime)")
        }
        else {
            guard let healthNotes = exerciseInfo?.healthNotes else { return UITableViewCell() }
               let joinedHealthNotes = healthNotes.joined(separator: ", ")
               cell.configureCell(title: TextLiterals.MyPage.pointsToNote, info: joinedHealthNotes)
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func requestExerciseAPI() {
        MyAPI.shared.getExerciseInfo()  { result in
            guard let result = self.validateResult(result) as? ExerciseInfoResponse else {
                return
            }
            self.exerciseInfo = result
        }
    }
}
