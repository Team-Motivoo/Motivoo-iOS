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
    let exerciseInfoView = ExerciseInfoView()
    private var nextButton = UIButton()
    
    
    private func setTableViewConfig() {
        exerciseInfoView.ExerciseInfotableView.register(DetailExerciseInfoTableViewCell.self,
                                      forCellReuseIdentifier: DetailExerciseInfoTableViewCell.cellIdentifier)
        exerciseInfoView.ExerciseInfotableView.dataSource = self
        exerciseInfoView.ExerciseInfotableView.delegate = self
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
    
    override func setButtonEvent() {
    }
    
    // MARK: - 이 곳은 위의 오버라이드 함수 영역과 구분될 수 있도록 자유로운 마크주석을 달아주세요
    
}
extension ExerciseInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
            cell = tableView.dequeueReusableCell(withIdentifier: "DisclosureTableViewCell", for: indexPath)
                cell.textLabel?.text = "\(TextLiterals.MyPage.AppInfoItems[indexPath.row])"
                cell.textLabel?.font = UIFont.heading6
                cell.textLabel?.textColor = .gray900
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 64
    }
   


   
}
